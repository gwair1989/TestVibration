//
//  JoystickHapticsManager.swift
//  TestVibration
//
//  Created by mac book on 25.09.2023.
//

import GameController
import CoreHaptics

final class JoystickHapticsManager {
    
    static let shared = JoystickHapticsManager()
    private var controllers: [GCController] = []

    private init() {
        setupObservers()
    }
    
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(controllerConnected), name: NSNotification.Name.GCControllerDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(controllerDisconnected), name: NSNotification.Name.GCControllerDidDisconnect, object: nil)
    }
    
    @objc private func controllerConnected(notification: Notification) {
        guard let controller = notification.object as? GCController else { return }
        controllers.append(controller)
    }

    @objc private func controllerDisconnected(notification: Notification) {
        guard let controller = notification.object as? GCController else { return }
        controllers.removeAll(where: { $0 == controller })
    }
    
    func vibrateController(controller: GCController?, intensity: Float, duration: TimeInterval) {
        guard let controller = controller ?? GCController.current else { return }

        if let haptics = controller.haptics {
            // Создание двигателя гаптики
            let hapticEngine = haptics.createEngine(withLocality: .default)
            
            // Создание гаптического паттерна
            let intensityParam = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
            let sharpnessParam = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)
            let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [intensityParam, sharpnessParam], relativeTime: 0, duration: duration)
            
            do {
                let pattern = try CHHapticPattern(events: [event], parameters: [])
                let player = try hapticEngine?.makePlayer(with: pattern)
                
                try hapticEngine?.start()
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play pattern: \(error.localizedDescription)")
            }
        }
    }

    func stopVibration(controller: GCController?) {
        guard let controller = controller ?? GCController.current else { return }
        
        if let haptics = controller.haptics {
            let hapticEngine = haptics.createEngine(withLocality: .default)
            hapticEngine?.stop()
        }
    }

}
