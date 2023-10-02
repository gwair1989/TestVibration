//
//  ControllerHapticsViewModel.swift
//  TestVibration
//
//  Created by Kateryna Gumenna on 29/9/23.
//

import SwiftUI
import GameController
import CoreHaptics

enum VibrationMode: String {
    case adjustable
    case pattern1 = "Rumble"
    case pattern2 = "Heartbeats2"
    case pattern3 = "InLavaStrong"
}

class ControllerHapticsViewModel: ObservableObject {
    private var player: CHHapticAdvancedPatternPlayer?
    private let hapticsManager = ControllerHapticsManager.shared

    @Published var isControllerOn: Bool = false
    @Published var isControllerConnected: Bool = false
    @Published var isVibrating: Bool = false
    
    private var previousPatternVibrationMode: VibrationMode = .adjustable
    @Published var currentVibrationMode: VibrationMode = .adjustable

    @Published var intensity: Float = 0.5
    @Published var sharpness: Float = 1.0
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
        guard let gameController = notification.object as? GCController else { return }
        hapticsManager.setupEngineFor(controller: gameController)
    }

    @objc private func controllerDisconnected(notification: Notification) {
        checkConnection()
        hapticsManager.controllerEngine = nil
    }

    private func checkConnection() {
        isControllerConnected = GCController.controllers().count > 0
    }
    
    func startVibration() {
        isVibrating = true
        if currentVibrationMode == .adjustable {
            hapticsManager.startAdjustableVibration(intensity: intensity, sharpness: sharpness, isControllerOn: isControllerOn)
        } else {
            hapticsManager.startVibrationPattern(named: currentVibrationMode.rawValue, isControllerOn: isControllerOn)
        }
    }

    func stopVibration() {
        isVibrating = false
        hapticsManager.stopHaptics()
    }
}

