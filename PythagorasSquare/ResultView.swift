//
//  ResultView.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import SwiftUI

struct ResultView: View {
    let square: PythagorasSquare
    @State private var showExplanation = false
    @State private var isVisible = false // Для анимации появления
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green.opacity(0.1), .blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Заголовок
                    Text(LocalizedStringKey("result_title"))
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .foregroundColor(.primary)
                        .padding(.top)
                        .opacity(isVisible ? 1 : 0)
                        .animation(.easeIn(duration: 0.5), value: isVisible)
                    
                    // Визуализация квадрата
                    GeometryReader { geometry in
                        VStack(spacing: 4) {
                            ForEach(0..<3) { row in
                                HStack(spacing: 4) {
                                    ForEach(1...3, id: \.self) { col in
                                        let number = row * 3 + col
                                        SquareCell(number: number, count: square.numbers[number] ?? 0)
                                            .frame(width: min(geometry.size.width / 3.5, 100), height: min(geometry.size.width / 3.5, 100))
                                    }
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .opacity(isVisible ? 1 : 0)
                        .animation(.easeIn(duration: 0.6).delay(0.2), value: isVisible)
                    }
                    .frame(height: 320) // Фиксированная высота для стабильности
                    .padding(.horizontal)
                    
                    // Дополнительные числа
                    GeometryReader { geometry in
                        HStack(spacing: 10) {
                            ForEach([10, 11, 12, 13], id: \.self) { number in
                                AdditionalNumberView(label:  String(format: NSLocalizedString("result_number_label", comment: ""), number-9), value: square.numbers[number] ?? 0)
                                    .frame(maxWidth: geometry.size.width > 500 ? 100 : 80)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .frame(height: 100)
                    .padding(.horizontal)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 0.6).delay(0.3), value: isVisible)
                    
                    // Кнопка
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            showExplanation = true
                        }
                    }) {
                        Text(LocalizedStringKey("result_btn_title"))
                            .font(.system(size: 18, weight: .semibold, design: .rounded))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .leading, endPoint: .trailing)
                            )
                            .cornerRadius(15)
                            .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal, 40)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 0.6).delay(0.4), value: isVisible)
                    
                    // Реклама
                    InterstitialAdButton()
                        .padding(.top, 5)
                        .opacity(isVisible ? 1 : 0)
                        .animation(.easeIn(duration: 0.6).delay(0.5), value: isVisible)
                    
                    Spacer(minLength: 20)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .navigationTitle(LocalizedStringKey("result_res"))
            .navigationBarTitleDisplayMode(.inline)
            .background(
                NavigationLink(
                    destination: ExplanationView(characteristics: square.characteristics),
                    isActive: $showExplanation
                ) {
                    EmptyView()
                }
            )
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

struct SquareCell: View {
    let number: Int
    let count: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue.opacity(0.15))
                .cornerRadius(10)
                .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
            
            VStack {
                Text("\(number)")
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.gray)
                
                Text("\(count)")
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .foregroundColor(count > 0 ? .blue : .gray)
            }
        }
    }
}

struct AdditionalNumberView: View {
    let label: String
    let value: Int
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 12, weight: .medium, design: .rounded))
                .foregroundColor(.gray)
            
            Text("\(value)")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.blue)
                .padding(10)
                .background(
                    Circle()
                        .fill(Color.blue.opacity(0.15))
                        .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                )
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResultView(square: PythagorasSquare(birthDate: Date()))
                .environment(\.colorScheme, .light)
                .previewDisplayName("Светлая тема (Вертикально)")
                .previewLayout(.device)
                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            
            ResultView(square: PythagorasSquare(birthDate: Date()))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Тёмная тема (Горизонтально)")
                .previewLayout(.device)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
