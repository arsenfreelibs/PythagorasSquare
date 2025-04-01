//
//  SplashScreenView.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var opacity = 0.0
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            ZStack {
                //                Color.black.ignoresSafeArea()
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.1), .purple.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Image(systemName: "square.grid.3x3.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .overlay(
                            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                        )
                        .mask(
                            Image(systemName: "square.grid.3x3.fill")
                                .resizable()
                                .scaledToFit()
                        )
                    
                    Text(LocalizedStringKey("splash_title"))
                        .font(.largeTitle)
                        .bold()
                        .overlay(
                            LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                        )
                        .mask(
                            Text(LocalizedStringKey("splash_title"))
                                .font(.largeTitle)
                                .bold()
                        )
                }
            }
            .onAppear {
                opacity = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isActive = true
                }
            }
        }
    }
}
