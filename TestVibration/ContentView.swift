//
//  ContentView.swift
//  TestVibration
//
//  Created by mac book on 22.09.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    @State private var isVibrationHapitcs: Bool = false
    @State private var isVibrateNotification: Bool = false
    @State private var isVibrateImpact: Bool = false
    
    @State private var showPaywall = false
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(spacing: 10) {
                    impactSpeedPicker
                    impactStylePicker
                    start_stop_impactVibration
                }
                Divider()
                VStack(spacing: 10) {
                    intencitySlider
                    sharpSlider
                    start_stop_HapticButton
                }
                Divider()
                VStack(spacing: 10) {
                    notifSpeedPicker
                    notifForcePicker
                    start_stop_notifVibration
                }
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Paywall") {
                        showPaywall.toggle()
                    }
                }
            }
            .fullScreenCover(isPresented: $showPaywall, content: {
                if let paywall = viewModel.visualPaywall {
                    VisualPaywallController(visualPaywall: paywall).edgesIgnoringSafeArea(.vertical)
                }
            })
            
        }

    }
    
    var start_stop_notifVibration: some View {
        return Button(isVibrateNotification ? "Stop VibrateNotification" : "Start VibrateNotification") {
            if isVibrateNotification {
                viewModel.stopNotificationVibrate()
            } else {
                viewModel.startNotificationVibrate()
            }
            isVibrateNotification.toggle()
        }
    }
    
    var start_stop_HapticButton: some View {
        return Button(isVibrationHapitcs ? "Stop HapticsVibro" : "Start HapticsVibro") {
            if isVibrationHapitcs {
                viewModel.stopHapticsVibrate()
            } else {
                viewModel.startHapticsVibrate()
            }
            isVibrationHapitcs.toggle()
        }
    }
    
    var start_stop_impactVibration: some View {
        return Button(isVibrateImpact ? "Stop VibrateImpact" : "Start VibrateImpact") {
            if isVibrateImpact {
                viewModel.stopImpactVibrate()
            } else {
                viewModel.startImpactVibrate()
            }
            isVibrateImpact.toggle()
        }
    }
    
    
    var notifForcePicker: some View {
        VStack {
            Label {
                Picker("Сила Удара", selection: $viewModel.impacForce) {
                    ForEach(ImpacForce.allCases) { force in
                        Text(force.rawValue.localizedCapitalized).tag(force)
                    }
                }
                .pickerStyle(.menu)
            } icon: {
                Text("Сила Удара NotifVibrate")
            }
        }
        .onChange(of: viewModel.impacForce) { newValue in
            if isVibrateImpact {
                viewModel.stopNotificationVibrate()
                viewModel.startNotificationVibrate()
            }
        }
    }
    
    var intencitySlider: some View {
        VStack(spacing: 10) {
            Slider(value: $viewModel.intencity,
                   in: 0...1,
                   step: 0.1) {
                Text("Интенсивность")
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("1")
            }
            Text("Интенсивность \(String(format: "%.1f", viewModel.intencity))")
        }
        .onChange(of: viewModel.intencity) { newValue in
            if isVibrationHapitcs {
                viewModel.stopHapticsVibrate()
                viewModel.startHapticsVibrate()
            }
        }
    }
    
        var sharpSlider: some View {
            VStack(spacing: 10) {
                Slider(value: $viewModel.sharpness,
                       in: 0...1,
                       step: 0.1) {
                    Text("Острота")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("1")
                }
                Text("Острота \(String(format: "%.1f", viewModel.sharpness))")
            }
            .onChange(of: viewModel.sharpness) { newValue in
                if isVibrationHapitcs {
                    viewModel.stopHapticsVibrate()
                    viewModel.startHapticsVibrate()
                }
            }
        }
    
    var notifSpeedPicker: some View {
        VStack {
            Label {
                Picker("", selection: $viewModel.notifFrequency) {
                    ForEach(Frequency.allCases)  { frequency in
                        Text(frequency.rawValue.localizedCapitalized).tag(frequency)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: viewModel.notifFrequency) { newValue in
                    if isVibrateNotification {
                        viewModel.stopNotificationVibrate()
                        viewModel.startNotificationVibrate()
                    }
                }
            } icon: {
                Text("Cкорость NotifVibrate")
            }
        }
    }
    
    var impactSpeedPicker: some View {
        VStack {
            Label {
                Picker("", selection: $viewModel.impactFrequency) {
                    ForEach(Frequency.allCases)  { frequency in
                        Text(frequency.rawValue.localizedCapitalized).tag(frequency)
                    }
                }
                .pickerStyle(.menu)
                .onChange(of: viewModel.impactFrequency) { newValue in
                    if isVibrateImpact {
                        viewModel.stopImpactVibrate()
                        viewModel.startImpactVibrate()
                    }
                }
            } icon: {
                Text("Cкорость Impact")
            }
        }
    }
    
    var impactStylePicker: some View {
        Label {
            Picker("Impact Style", selection: $viewModel.impactStyle) {
                ForEach(ImpactStyle.allCases) { style in
                    Text(style.rawValue.localizedCapitalized).tag(style)
                }
            }
            .pickerStyle(.menu)
        } icon: {
            Text("Стиль Impact")
        }
        .onChange(of: viewModel.impactStyle) { newValue in
            if isVibrateImpact {
                viewModel.stopImpactVibrate()
                viewModel.startImpactVibrate()
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
