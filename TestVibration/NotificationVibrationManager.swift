//
//  NotificationVibrationManager.swift
//  TestVibration
//
//  Created by mac book on 24.09.2023.
//
import AudioToolbox
import UIKit

final class NotificationVibrationManager {
    static let shared = NotificationVibrationManager()
    private var notificationLoopTimer: Timer?
    
    private init() { }
    
    public func startNotificationLoopTimer(frequency: Frequency, impacForce: ImpacForce ) {
        guard notificationLoopTimer == nil else { return }
        notificationLoopTimer = Timer.scheduledTimer(timeInterval: frequency.timeInterval,
                                                     target: self,
                                                     selector: #selector(playNotificationSystemSound),
                                                     userInfo: impacForce,
                                                     repeats: true)
    }
    
    public func stopNotificationLoopTimer() {
        guard
            let timer: Timer = notificationLoopTimer,
            timer.isValid
        else { return }
        
        timer.invalidate()
        notificationLoopTimer = nil
    }
    
    private func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
    
    @objc private func playNotificationSystemSound(_ timer: Timer) {
        if let impacForce = timer.userInfo as? ImpacForce {
            DispatchQueue.main.async {
                AudioServicesPlaySystemSoundWithCompletion(1521) {
                    UINotificationFeedbackGenerator().notificationOccurred(impacForce.force)
                }
            }
        }
    }
    
}
