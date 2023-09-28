//
//  VisualPaywallController.swift
//  TestVibration
//
//  Created by mac book on 26.09.2023.
//

import SwiftUI

struct VisualPaywallController: UIViewControllerRepresentable {
    var visualPaywall: UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        visualPaywall.edgesForExtendedLayout = []
        return visualPaywall
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // здесь можно обновить UIViewController, если требуется
    }
}
