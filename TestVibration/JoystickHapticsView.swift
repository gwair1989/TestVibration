//
//  JoystickHapticsView.swift
//  TestVibration
//
//  Created by mac book on 25.09.2023.
//

import SwiftUI

struct JoystickHapticsView: View {
    @StateObject var viewModel = JoystickHapticsViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.isConnected ? "Controller Connected" : "No Controller Connected")
                .foregroundColor(viewModel.isConnected ? .green : .red)

            Slider(value: $viewModel.intensity, in: 0...1, step: 0.1)
                .padding()
                .disabled(!viewModel.isConnected)

            Slider(value: $viewModel.duration, in: 0.5...5, step: 0.5)
                .padding()
                .disabled(!viewModel.isConnected)

            Button(action: {
                viewModel.vibrate()
            }) {
                Text("Start Vibration")
            }
            .disabled(!viewModel.isConnected)
            .padding()

            Button(action: {
                viewModel.stopVibration()
            }) {
                Text("Stop Vibration")
            }
            .disabled(!viewModel.isConnected)
            .padding()
        }
    }
}

struct JoystickHapticsView_Previews: PreviewProvider {
    static var previews: some View {
        JoystickHapticsView()
    }
}
