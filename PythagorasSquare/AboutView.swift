//
//  AboutView.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import SwiftUI

struct AboutView: View {
    @State private var isVisible = false // Для анимации появления
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.1), .purple.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Заголовок
                    Text(LocalizedStringKey("about_title"))
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .padding(.top)
                        .opacity(isVisible ? 1 : 0)
                        .animation(.easeIn(duration: 0.5), value: isVisible)
                    
                    // Текст
                    VStack(alignment: .leading, spacing: 15) {
                        Text(LocalizedStringKey("about_text1"))
                            .opacity(isVisible ? 1 : 0)
                            .animation(.easeIn(duration: 0.6).delay(0.2), value: isVisible)
                        
                        Text(LocalizedStringKey("about_text2"))
                            .opacity(isVisible ? 1 : 0)
                            .animation(.easeIn(duration: 0.6).delay(0.3), value: isVisible)
                        
                        Text(LocalizedStringKey("about_text3"))
                            .opacity(isVisible ? 1 : 0)
                            .animation(.easeIn(duration: 0.6).delay(0.4), value: isVisible)
                        
                        Text(LocalizedStringKey("about_text4"))
                            .opacity(isVisible ? 1 : 0)
                            .animation(.easeIn(duration: 0.6).delay(0.5), value: isVisible)
                    }
                    .font(.system(size: 16, design: .rounded))
                    .foregroundColor(.primary)
                    .padding()
                    .background(Color(.systemBackground).opacity(0.8))
                    .cornerRadius(12)
                    .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
                    
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
                    .animation(.easeIn(duration: 0.6).delay(0.6), value: isVisible)
            }
            .navigationTitle("Информация")
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

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AboutView()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Светлая тема (Вертикально)")
                .previewLayout(.device)
                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            
            AboutView()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Тёмная тема (Горизонтально)")
                .previewLayout(.device)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
