//
//  PythagorasSquareApp.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import SwiftUI
import GoogleMobileAds

@main
struct PythagorasSquareApp: App {
    init() {
        // Инициализация Google Mobile Ads SDK
        MobileAds.shared.start(completionHandler: nil)
    }
    
    var body: some Scene {
            WindowGroup {
//                SplashScreenView()
                ContentView()
            }
    }
}
