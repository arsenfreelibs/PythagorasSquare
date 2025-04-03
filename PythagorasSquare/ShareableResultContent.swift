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
    var onCellTap: (Int) -> Void
    var selectedCell: Int?
    
    private let cellSize: CGFloat = 100
    
    // Инициализатор для обычного режима
    init(square: PythagorasSquare, isVisible: Bool, onCellTap: @escaping (Int) -> Void, selectedCell: Int?) {
        self.square = square
        self.isVisible = isVisible
        self.onCellTap = onCellTap
        self.selectedCell = selectedCell
    }
    
    // Инициализатор для режима шаринга (без обработки нажатий)
    init(square: PythagorasSquare, isVisible: Bool) {
        self.square = square
        self.isVisible = isVisible
        self.onCellTap = { _ in }
        self.selectedCell = nil
    }
    
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
            squareGrid
                .frame(height: 320)
                .padding(.horizontal)
            
            // Дополнительные числа
            additionalNumbers
                .frame(height: 100)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            LinearGradient(gradient: Gradient(colors: [.green.opacity(0.1), .blue.opacity(0.1)]),
                           startPoint: .top,
                           endPoint: .bottom)
        )
    }
    
    private var squareGrid: some View {
        VStack(spacing: 4) {
            ForEach(0..<3) { row in
                HStack(spacing: 4) {
                    ForEach(1...3, id: \.self) { col in
                        let number = row * 3 + col
                        SquareCell(
                            number: number,
                            count: square.numbers[number] ?? 0,
                            isSelected: selectedCell == number,
                            action: { onCellTap(number) }
                        )
                        .frame(width: cellSize, height: cellSize)
                    }
                }
            }
        }
        .opacity(isVisible ? 1 : 0)
        .animation(.easeIn(duration: 0.6).delay(0.2), value: isVisible)
    }

    private var additionalNumbers: some View {
        HStack(spacing: 10) {
            ForEach([10, 11, 12, 13], id: \.self) { number in
                AdditionalNumberView(
                    label: String(format: NSLocalizedString("result_number_label", comment: ""), number-9),
                    value: square.numbers[number] ?? 0,
                    isSelected: selectedCell == number,
                    action: {
                        onCellTap(number)
                    }
                )
                .frame(maxWidth: 100)
            }
        }
        .opacity(isVisible ? 1 : 0)
        .animation(.easeIn(duration: 0.6).delay(0.3), value: isVisible)
    }
}
