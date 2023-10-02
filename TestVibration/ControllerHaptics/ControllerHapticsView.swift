//
//  ControllerHapticsView.swift
//  TestVibration
//
//  Created by Kateryna Gumenna on 29/9/23.
//

import SwiftUI

struct ControllerHapticsView: View {
    @StateObject var vm = ControllerHapticsViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            phoneControllerButtons
            adjustableVibrationControls
            Spacer().frame(height: 20)
            patternVibrationsButtons
            startStopButton
        }
        .padding(.horizontal)
        .onChange(of: vm.intensity) { _ in
            if vm.isVibrating {
                vm.stopVibration()
                vm.startVibration()
            }
        }
        .onChange(of: vm.sharpness) { _ in
            if vm.isVibrating {
                vm.stopVibration()
                vm.startVibration()
            }
        }
    }
    
    private var startStopButton: some View {
        Button(vm.isVibrating ? "Stop vibration" : "Start vibration") {
            if vm.isVibrating {
                vm.stopVibration()
            } else {
                vm.startVibration()
            }
        }
        .padding()
        .padding(.top, 50)
        .disabled(vm.isControllerOn && !vm.isControllerConnected ? true : false)
        .opacity(vm.isControllerOn && !vm.isControllerConnected ? 0.3 : 1)
    }
    
    private var phoneControllerButtons: some View {
        var controllerButtonColor: Color = .gray
        if vm.isControllerOn && vm.isControllerConnected {
            controllerButtonColor = .green
        } else if vm.isControllerOn {
            controllerButtonColor = .red
        }
        
        return HStack(alignment: .top, spacing: 10) {
            Spacer()
            
            // iPhone button
            Button {
                vm.isControllerOn.toggle()
            } label: {
                Image(systemName: "iphone")
                    .foregroundColor(vm.isControllerOn ? .gray : .green)
            }
            .frame(width: 80)
            
            // Controller button
            VStack(spacing: 10) {
                Button {
                    vm.isControllerOn.toggle()
                } label: {
                    Image(systemName: "gamecontroller.fill")
                        .foregroundColor(controllerButtonColor)
                }
                .frame(width: 80)
                
                Text(vm.isControllerConnected ? "Connected" : "Not Connected")
                    .font(.caption)
                    .foregroundColor(vm.isControllerConnected ? .green : .red)
                    .opacity(vm.isControllerOn ? 1 : 0)
            }
            
            Spacer()
        }
        .font(.largeTitle)
        .disabled(vm.isVibrating ? true : false)
        .opacity(vm.isVibrating ? 0.3 : 1)
        //        .disabled(vm.isVibrating || (vm.isControllerOn && !vm.isControllerConnected) ? true : false)
        //        .opacity(vm.isVibrating || (vm.isControllerOn && !vm.isControllerConnected) ? 0.3 : 1)
        
    }
    
    private var adjustableVibrationControls: some View {
        VStack(spacing: 0) {
            Text("Adjustable vibration").foregroundColor(.black)
                .padding(.bottom)
            
            VStack(spacing: 20) {
                intensitySlider
                sharpnessSlider
            }
            .font(.caption)
        }
        .padding(.vertical)
        .background {
            RoundedRectangle(cornerRadius: 18)
                .fill(vm.currentVibrationMode == .adjustable ? .purple : .gray)
                .opacity(0.3)
        }
        .onTapGesture {
            vm.currentVibrationMode = .adjustable
        }
        .disabled(vm.isVibrating && vm.currentVibrationMode != .adjustable ? true : false)
        .opacity(vm.isVibrating && vm.currentVibrationMode != .adjustable ? 0.3 : 1)
    }
    
    private var intensitySlider: some View {
        VStack(spacing: 0) {
            Slider(value: $vm.intensity, in: 0...1, step: 0.1) {
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("1")
            }
            .padding(.horizontal)
            .disabled(vm.currentVibrationMode != .adjustable)
            
            Text("Intensity \(String(format: "%.1f", vm.intensity))")
        }
    }
    
    private var sharpnessSlider: some View {
        VStack(spacing: 0) {
            Slider(value: $vm.sharpness, in: 0...1, step: 0.1) {
            } minimumValueLabel: {
                Text("0")
            } maximumValueLabel: {
                Text("1")
            }
            .padding(.horizontal)
            .disabled(vm.currentVibrationMode != .adjustable)
            
            Text("Sharpness \(String(format: "%.1f", vm.sharpness))")
        }
    }
    
    
    private var patternVibrationsButtons: some View {
        let buttonOffColor = Color.gray.opacity(0.7)
        let buttonOnColor = Color.green
        
        return VStack {
            Text("Vibration patterns")
                .padding(.bottom, 10)
            
            HStack(spacing: 30) {
                // Pattern 1 button
                Button {
                    vm.currentVibrationMode = .pattern1
                } label: {
                    Image(systemName: "1.circle.fill")
                }
                .foregroundColor(vm.currentVibrationMode == .pattern1 ? buttonOnColor : buttonOffColor)
                
                // Pattern 2 button
                Button {
                    vm.currentVibrationMode = .pattern2
                } label: {
                    Image(systemName: "2.circle.fill")
                }
                .foregroundColor(vm.currentVibrationMode == .pattern2 ? buttonOnColor : buttonOffColor)
                
                // Pattern 3 button
                Button {
                    vm.currentVibrationMode = .pattern3
                } label: {
                    Image(systemName: "3.circle.fill")
                }
                .foregroundColor(vm.currentVibrationMode == .pattern3 ? buttonOnColor : buttonOffColor)
            }
            .font(.largeTitle)
            
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background {
            RoundedRectangle(cornerRadius: 18)
                .fill(vm.currentVibrationMode != .adjustable ? .purple : .gray)
                .opacity(0.3)
        }
        .onTapGesture {
            vm.currentVibrationMode = .pattern1
//            previouslyChosenPattern = viewModel.currentVibrationMode
        }
        .disabled(vm.isVibrating ? true : false)
        .opacity(vm.isVibrating ? 0.3 : 1)
    }
}

struct ControllerHapticsView_Previews: PreviewProvider {
    static var previews: some View {
        ControllerHapticsView(vm: ControllerHapticsViewModel())
    }
}
