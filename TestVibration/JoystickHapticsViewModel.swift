//
//  JoystickHapticsViewModel.swift
//  TestVibration
//
//  Created by mac book on 25.09.2023.
//

import SwiftUI
import GameController

class JoystickHapticsViewModel: ObservableObject {
    private var controller: GCController? {
        GCController.current
    }

    @Published var isConnected: Bool = false
    @Published var intensity: Float = 0.5
    @Published var duration: TimeInterval = 1.0

    init() {
        checkConnection()
        setupObservers()
    }

    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(controllerConnected), name: NSNotification.Name.GCControllerDidConnect, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(controllerDisconnected), name: NSNotification.Name.GCControllerDidDisconnect, object: nil)
    }

    @objc private func controllerConnected(notification: Notification) {
        checkConnection()
    }

    @objc private func controllerDisconnected(notification: Notification) {
        checkConnection()
    }

    private func checkConnection() {
        isConnected = GCController.controllers().count > 0
    }

    func vibrate() {
        JoystickHapticsManager.shared.vibrateController(controller: controller, intensity: intensity, duration: duration)
    }

    func stopVibration() {
        JoystickHapticsManager.shared.stopVibration(controller: controller)
    }
}

