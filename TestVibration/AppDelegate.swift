//
//  AppDelegate.swift
//  TestVibration
//
//  Created by mac book on 26.09.2023.
//

import UIKit
import Adapty

final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        Adapty.activate("public_live_tJBjf0Fn.OX6xuVLS07PuqStqEY4n")
        Adapty.activate("public_live_tJBjf0Fn.OX6xuVLS07PuqStqEY4n") { error in
            if let error {
                print("Error Activate: ", error.localizedDescription)
            }
        }
        
        return true
    }
    
}
