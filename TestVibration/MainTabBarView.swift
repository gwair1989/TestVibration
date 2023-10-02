//
//  MainTabBarView.swift
//  TestVibration
//
//  Created by mac book on 25.09.2023.
//

import SwiftUI

struct MainTabBarView: View {
    var body: some View {
        TabView {
//            JoystickHapticsView()
            ControllerHapticsView()
                .tabItem {
                    Label("Joystick", systemImage: "waveform.path.ecg")
                }
            
            ContentView()
                .tabItem {
                    Label("Haptics", systemImage: "square.and.pencil")
                }
        }
    }
}

struct MainTabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}
