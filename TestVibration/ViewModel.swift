//
//  ViewModel.swift
//  TestVibration
//
//  Created by mac book on 22.09.2023.
//

import Foundation
import SwiftUI

final class ViewModel: ObservableObject {
    @Published var visualPaywall: UIViewController?
    private var service = SubscriptionService()
    
    @Published var intencity: Float  = 0.5
    @Published var sharpness: Float  = 0.5
    
    @Published var impactFrequency: Frequency = .high
    @Published var notifFrequency: Frequency = .high
    
    @Published var impactStyle: ImpactStyle = .medium
    @Published var impacForce: ImpacForce = .medium
    
    private let hapticsManager = HapticsManager.shared
    private let impactManager = ImpactVibrationManager.shared
    private let notifVibroManager = NotificationVibrationManager.shared
    
    init() {
        loadPaywall() 
    }
    
    public func startHapticsVibrate() {
        hapticsManager.startHapticsVibrate(intensity: intencity, sharpness: sharpness)
    }
    
    public func stopHapticsVibrate() {
        hapticsManager.stopVibration()
    }
    
    public func startImpactVibrate() {
        impactManager.startImactVibration(frequency: impactFrequency, style: impactStyle)
    }
    
    public func stopImpactVibrate() {
        impactManager.stopImpactLoopTimer()
    }
    
    public  func startNotificationVibrate() {
        notifVibroManager.startNotificationLoopTimer(frequency: notifFrequency, impacForce: impacForce)
    }
    
    public func stopNotificationVibrate() {
        notifVibroManager.stopNotificationLoopTimer()
    }
    
    func loadPaywall() {
            service.fetchVisualPaywall { [weak self] paywall in
                DispatchQueue.main.async {
                    self?.visualPaywall = paywall
                    print("SET PAYWALL")
                }
            }
        }
}
