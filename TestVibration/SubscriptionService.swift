//
//  SubscriptionService.swift
//  TestVibration
//
//  Created by mac book on 26.09.2023.
//

import Adapty
import AdaptyUI
import SwiftUI

class SubscriptionService {
    
    private let adaptyDelegate = AdaptyPaywallDelegate()
    
    /// Получить визуальное представление платежного экрана.
    ///
    /// - Parameters:
    ///   - completion: Обратный вызов с контроллером визуального платежного экрана или nil в случае ошибки.
    func fetchVisualPaywall(completion: @escaping (UIViewController?) -> Void) {
        Adapty.getPaywall("test_vibro_placements") { result in
            switch result {
            case let .success(paywall):
                AdaptyUI.getViewConfiguration(forPaywall: paywall, locale: "en") { configResult in
                    switch configResult {
                    case let .success(viewConfiguration):
                        let visualPaywall = AdaptyUI.paywallController(
                            for: paywall,
                            products: nil,
                            viewConfiguration: viewConfiguration,
                            delegate: self.adaptyDelegate
                        )
                        completion(visualPaywall)
                    case .failure:
                        completion(nil)
                    }
                }
            case .failure:
                completion(nil)
            }
        }
    }
}

