//
//  AdaptyPaywallDelegate.swift
//  TestVibration
//
//  Created by mac book on 26.09.2023.
//

import Adapty
import AdaptyUI
import SwiftUI

/// Делегат для работы с событиями платежного экрана Adapty.
class AdaptyPaywallDelegate: NSObject, AdaptyPaywallControllerDelegate {
    
    /// Обработка выполненного действия на платежном экране.
    func paywallController(_ controller: AdaptyPaywallController, didPerform action: AdaptyUI.Action) {
        // Реализуйте обработку, если нужно
        print("Вызывается метод: \(#function)")
        
        switch action {
              case .close:
                  controller.dismiss(animated: true)
              case let .openURL(url):
                    print(url)
                  UIApplication.shared.open(url, options: [:])
              case let .custom(id):
                  if id == "login" {
                     // implement login flow
                  }
                  break
          }
    }
    
    /// Обработка выбора продукта на платежном экране.
    func paywallController(_ controller: AdaptyPaywallController, didSelectProduct product: AdaptyPaywallProduct) {
        // Реализуйте обработку, если нужно
        print("Вызывается метод: \(#function)")
    }

    /// Обработка начала процесса покупки продукта.
    func paywallController(_ controller: AdaptyPaywallController, didStartPurchase product: AdaptyPaywallProduct) {
        // Реализуйте обработку, если нужно
        print("Вызывается метод: \(#function)")
    }
    
    /// Обработка успешной покупки продукта.
    func paywallController(_ controller: AdaptyPaywallController, didFinishPurchase product: AdaptyPaywallProduct, purchasedInfo: AdaptyPurchasedInfo) {
        // Реализуйте обработку, если нужно
        print("Вызывается метод: \(#function)")
    }
    
    /// Обработка ошибки покупки продукта.
    func paywallController(_ controller: AdaptyPaywallController, didFailPurchase product: AdaptyPaywallProduct, error: AdaptyError) {
        // Реализуйте обработку, если нужно
        print("Вызывается метод: \(#function)")
    }
    
    /// Обработка отмены покупки продукта.
    func paywallController(_ controller: AdaptyPaywallController, didCancelPurchase product: AdaptyPaywallProduct) {
        // Реализуйте обработку, если нужно
        print("Вызывается метод: \(#function)")
    }
    
    /// Обработка успешного восстановления покупок.
    func paywallController(_ controller: AdaptyPaywallController, didFinishRestoreWith profile: AdaptyProfile) {
        // Реализуйте обработку, если нужно
        print("Вызывается метод: \(#function)")
    }
    
    /// Обработка ошибки восстановления покупок.
    func paywallController(_ controller: AdaptyPaywallController, didFailRestoreWith error: AdaptyError) {
        // Реализуйте обработку, если нужно
        print("Вызывается метод: \(#function)")
    }
    
    /// Обработка ошибки отображения платежного экрана.
    func paywallController(_ controller: AdaptyPaywallController, didFailRenderingWith error: AdaptyError) {
        // Реализуйте обработку, если нужно
        print("Вызывается метод: \(#function)")
    }
    
    /// Обработка ошибки загрузки продуктов для платежного экрана.
    /// Возвращает true, если следует попробовать загрузить продукты снова.
    func paywallController(_ controller: AdaptyPaywallController, didFailLoadingProductsWith error: AdaptyError) -> Bool {
        // Реализуйте обработку и верните значение, если нужно
        print("Вызывается метод: \(#function)")
        return false
    }
}
