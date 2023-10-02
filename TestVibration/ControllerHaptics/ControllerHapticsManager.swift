//
//  ControllerHapticsManager.swift
//  TestVibration
//
//  Created by Kateryna Gumenna on 28/9/23.
//

import GameController
import CoreHaptics

final class ControllerHapticsManager {
    static let shared = ControllerHapticsManager()
    private var phoneEngine: CHHapticEngine?
    var controllerEngine: CHHapticEngine?

    private var player: CHHapticPatternPlayer?
    var shouldStop = false

    private init() {
        setupEngineForPhone()
    }
    
    func setupEngineForPhone() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            phoneEngine = try CHHapticEngine()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func setupEngineFor(controller: GCController?) {
        guard controllerEngine == nil else { return }
        guard let controller = controller else { return }
        controllerEngine = controller.haptics?.createEngine(withLocality: .default)
    }

    func startVibrationPattern(named filename: String, isControllerOn: Bool ) {
        guard let engine = isControllerOn ? controllerEngine : phoneEngine else { return }
        
        guard let path = Bundle.main.path(forResource: filename, ofType: "ahap") else { return }

        guard let patternData = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            print("Failed to parse json data")
            return
        }

        guard let patternSerialized = try? JSONSerialization.jsonObject(with: patternData, options: []) else {
            print("Failed to deserialize json data")
            return
        }

        guard let patternDictionary = patternSerialized as? [CHHapticPattern.Key: Any] else {
            print("Failed to deserialize json data as NSDictionary")
            return
        }

        do {
            // Start the engine in case it's idle.
            try engine.start()
            // Tell the engine to play a pattern.
            let pattern = try CHHapticPattern(dictionary: patternDictionary)
            player = try engine.makePlayer(with: pattern)
            startHapticsPattern()
        } catch { // Process engine startup errors.
            print("An error occured playing \(filename): \(error).")
        }
    }
    
    func startAdjustableVibration(intensity: Float, sharpness: Float, isControllerOn: Bool) {
        guard let engine = isControllerOn ? controllerEngine : phoneEngine else { return }

        guard let pattern = createPatternForAdjustable(intensity: intensity, sharpness: sharpness) else { return }
        
        shouldStop = false

        do {
            // Start the engine in case it's idle.
            try engine.start()
            player = try engine.makePlayer(with: pattern)
            try player?.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("An error occured playing adjustable haptics: \(error).")
            return
        }
    }
    
    private func createPatternForAdjustable(intensity: Float, sharpness: Float) -> CHHapticPattern? {
        let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
        let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensityParameter, sharpnessParameter], relativeTime: 0, duration: 300)
        
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            return pattern
        } catch {
            print("Error creating pattern for adjustable haptics \(error.localizedDescription)")
            return nil
        }
    }

    private func startHapticsPattern() {
        shouldStop = false

        do {
            try player?.start(atTime: CHHapticTimeImmediate)

            let loopDeadline: DispatchTime = DispatchTime.now() + 1.5
            DispatchQueue.main.asyncAfter(deadline: loopDeadline) { [weak self] in
                guard let self = self else { return }
                if !self.shouldStop {
                    self.startHapticsPattern()
                }
            }
        } catch {
            print("error starting playing haptics: \(error.localizedDescription)")
        }
    }

    func stopHaptics() {
        shouldStop = true

        do {
            try player?.stop(atTime: CHHapticTimeImmediate)
        } catch {
            print("error stopping playing haptics: \(error.localizedDescription)")

        }
    }

}
