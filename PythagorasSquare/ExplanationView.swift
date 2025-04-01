//
//  ExplanationView.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import SwiftUI

struct ExplanationView: View {
    let characteristics: [String: String]
    @State private var isVisible = false // Для анимации появления
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple.opacity(0.1), .blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Заголовок
                    Text("Трактовка вашего квадрата Пифагора")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .padding(.top)
                        .opacity(isVisible ? 1 : 0)
                        .animation(.easeIn(duration: 0.5), value: isVisible)
                    
                    // Характеристики
                    ForEach(Array(characteristics.keys.sorted()), id: \.self) { key in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(key)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(.blue)
                            
                            Text(characteristics[key] ?? "")
                                .font(.system(size: 16, design: .rounded))
                                .foregroundColor(.primary)
                                .padding(.leading, 10)
                        }
                        .padding()
                        .background(Color(.systemBackground).opacity(0.8))
                        .cornerRadius(12)
                        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(isVisible ? 1 : 0)
                        .animation(.easeIn(duration: 0.6).delay(Double(characteristics.keys.sorted().firstIndex(of: key) ?? 0) * 0.1), value: isVisible)
                    }
                    
                    Spacer(minLength: 60) // Отступ для баннера
                }
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .safeAreaInset(edge: .bottom) {
                BannerView()
                    .frame(height: 50)
                    .background(Color(.systemBackground).opacity(0.8))
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 0.6).delay(0.5), value: isVisible)
            }
            .navigationTitle("Трактовка")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation {
                    isVisible = true
                }
            }
            .onDisappear {
                isVisible = false
            }
        }
    }
}

struct ExplanationView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCharacteristics = [
            "Число 1": "У вас 2 единицы. Вы обладаете сильным характером...",
            "Число 2": "Отсутствие двоек может указывать на недостаток гибкости...",
            "Число судьбы (1)": "Ваше число судьбы - 28..."
        ]
        
        return Group {
            ExplanationView(characteristics: sampleCharacteristics)
                .environment(\.colorScheme, .light)
                .previewDisplayName("Светлая тема (Вертикально)")
                .previewLayout(.device)
                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            
            ExplanationView(characteristics: sampleCharacteristics)
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Тёмная тема (Горизонтально)")
                .previewLayout(.device)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
