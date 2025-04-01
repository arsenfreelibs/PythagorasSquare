//
//  ExplanationView.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import SwiftUI

struct ExplanationView: View {
    let characteristics: [String: String]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Трактовка вашего квадрата Пифагора")
                    .font(.headline)
                    .padding(.top)
                
                ForEach(Array(characteristics.keys.sorted()), id: \.self) { key in
                    VStack(alignment: .leading) {
                        Text(key)
                            .font(.title3)
                            .fontWeight(.bold)
                        
                        Text(characteristics[key] ?? "")
                            .padding(.leading)
                    }
                    .padding(.vertical, 5)
                }
                
                // Баннерная реклама
                BannerView()
                    .frame(height: 50)
                    .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Трактовка")
    }
}
