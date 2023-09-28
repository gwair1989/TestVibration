//
//  HapticsManager.swift
//  TestVibration
//
//  Created by mac book on 22.09.2023.
//
import Foundation
import CoreHaptics

final class HapticsManager {
    static let shared = HapticsManager()
    private var engine: CHHapticEngine?
    private var player: CHHapticPatternPlayer?
    
    private init() {
        prepareHaptics()
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func startHapticsVibrate(intensity: Float, sharpness: Float, type: HapticType = .continuous) {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        let intensityParam = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
        let sharpnessParam = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
        
        var event: CHHapticEvent!
        switch type {
        case .continuous:
            event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensityParam, sharpnessParam], relativeTime: 0, duration: 2.0) // Adjust duration as needed
        case .transient:
            event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensityParam, sharpnessParam], relativeTime: 0)
        }
        
        do {
            try engine?.start()
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription)")
        }
    }
    
    func stopVibration() {
        do {
            try player?.stop(atTime: CHHapticTimeImmediate)
            engine?.stop(completionHandler: nil)
        } catch {
            print("Failed to stop pattern: \(error.localizedDescription)")
        }
    }
    
    enum HapticType {
        case continuous
        case transient
    }
}
