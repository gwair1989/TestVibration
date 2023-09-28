//
//  TestVibrationApp.swift
//  TestVibration
//
//  Created by mac book on 22.09.2023.
//

import SwiftUI
import Adapty

@main
struct TestVibrationApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            MainTabBarView()
        }
    }
}


