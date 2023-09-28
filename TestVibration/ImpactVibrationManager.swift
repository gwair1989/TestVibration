//
//  ImpactVibrationManager.swift
//  TestVibration
//
//  Created by mac book on 22.09.2023.
//

import UIKit

final class ImpactVibrationManager {
    static let shared = ImpactVibrationManager()
    private var impactLoopTimer: Timer?
    private init() { }
    
    public func startImactVibration(frequency: Frequency, style: ImpactStyle) {
        guard impactLoopTimer == nil else { return }
        impactLoopTimer = Timer.scheduledTimer(timeInterval: frequency.timeInterval,
                                               target: self,
                                               selector: #selector(playImactSystemSound),
                                               userInfo: style.style,
                                               repeats: true)
    }
    
    private func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        DispatchQueue.main.async {
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.prepare()
            generator.impactOccurred()
        }
    }
    
    @objc private func playImactSystemSound(_ timer: Timer) {
        if let style = timer.userInfo as? UIImpactFeedbackGenerator.FeedbackStyle {
            impact(style: style)
        }
    }
    
    public func stopImpactLoopTimer() {
        guard
            let timer: Timer = impactLoopTimer,
            timer.isValid
        else { return }
        
        timer.invalidate()
        impactLoopTimer = nil
    }
}
