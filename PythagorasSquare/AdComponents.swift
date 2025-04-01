//
//  AdComponents.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import SwiftUI
import GoogleMobileAds

struct BannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GoogleMobileAds.BannerView {
        let banner = GoogleMobileAds.BannerView(adSize: AdSizeBanner)
        banner.adUnitID = "ca-app-pub-3132483666658391/7560968814" // Замените на ваш ID
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(Request())
        return banner
    }
    
    func updateUIView(_ uiView: GoogleMobileAds.BannerView, context: Context) {}
}

struct InterstitialAdButton: View {
    @State private var interstitial = InterstitialAdLoader()
    
    var body: some View {
        Button(action: {
            interstitial.showAd()
        }) {
            Text("Поддержать разработчика")
                .font(.footnote)
                .foregroundColor(.blue)
        }
    }
}

class InterstitialAdLoader: NSObject {
    private var interstitial: GoogleMobileAds.InterstitialAd?
    
    override init() {
        super.init()
        loadInterstitial()
    }
    
    func loadInterstitial() {
        let request = Request()
        GoogleMobileAds.InterstitialAd.load(
            with: "ca-app-pub-3132483666658391/3759548500", // Замените на ваш ID
            request: request
        ) { [weak self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad: \(error.localizedDescription)")
                return
            }
            self?.interstitial = ad
        }
    }
    
    func showAd() {
        if let interstitial = interstitial,
           let rootVC = UIApplication.shared.windows.first?.rootViewController {
            interstitial.present(from: rootVC)
            loadInterstitial() // Загружаем следующую рекламу
        } else {
            print("Not ready")
        }
    }
}
