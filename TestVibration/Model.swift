//
//  Model.swift
//  TestVibration
//
//  Created by mac book on 22.09.2023.
//

import UIKit

enum Frequency: String, CaseIterable, Identifiable {
    case high
    case averageHight
    case medium
    case avarageLow
    case low
    
    var id: Self { self }
    
    var timeInterval: TimeInterval {
        switch self {
        case .high: return 0.01
        case.averageHight: return 0.1
        case.medium: return 0.3
        case .avarageLow: return 0.5
        case .low: return 0.7
            
        }
    }
}

enum ImpactStyle: String, CaseIterable, Identifiable {
    case light
    case medium
    case heavy
    case soft
    case rigid
    
    var id: Self { self }
    
    var style: UIImpactFeedbackGenerator.FeedbackStyle {
        switch self {
        case .light:
            return UIImpactFeedbackGenerator.FeedbackStyle.light
        case .medium:
            return UIImpactFeedbackGenerator.FeedbackStyle.medium
        case .heavy:
            return UIImpactFeedbackGenerator.FeedbackStyle.heavy
        case .soft:
            return UIImpactFeedbackGenerator.FeedbackStyle.soft
        case .rigid:
            return UIImpactFeedbackGenerator.FeedbackStyle.rigid
        }
    }
}

enum ImpacForce: String, CaseIterable, Identifiable {
    case soft
    case medium
    case heavy
    
    var id: Self { self }
    
    var force: UINotificationFeedbackGenerator.FeedbackType {
        switch self {
            
        case .soft:
            return .success
        case .medium:
            return .warning
        case .heavy:
            return .error
        }
    }
}
