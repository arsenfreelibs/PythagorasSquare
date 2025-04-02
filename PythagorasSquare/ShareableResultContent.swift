//
//  ShareableResultContent.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 02.04.2025.
//

import SwiftUI

struct ShareableResultContent: View {
    let square: PythagorasSquare
    var isVisible: Bool

    var body: some View {
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
            .frame(height: 320)
            .padding(.horizontal)
            
            // Дополнительные числа
            GeometryReader { geometry in
                HStack(spacing: 10) {
                    ForEach([10, 11, 12, 13], id: \.self) { number in
                        AdditionalNumberView(label: String(format: NSLocalizedString("result_number_label", comment: ""), number-9), value: square.numbers[number] ?? 0)
                            .frame(maxWidth: geometry.size.width > 500 ? 100 : 80)
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 100)
            .padding(.horizontal)
            .opacity(isVisible ? 1 : 0)
            .animation(.easeIn(duration: 0.6).delay(0.3), value: isVisible)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            LinearGradient(gradient: Gradient(colors: [.green.opacity(0.1), .blue.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
        )
    }
}
