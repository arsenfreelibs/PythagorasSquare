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
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Ваш квадрат Пифагора")
                    .font(.headline)
                    .padding(.top)
                
                // Визуализация квадрата
                VStack(spacing: 2) {
                    ForEach(0..<3) { row in
                        HStack(spacing: 2) {
                            ForEach(1...3, id: \.self) { col in
                                let number = row * 3 + col
                                SquareCell(number: number, count: square.numbers[number] ?? 0)
                            }
                        }
                    }
                }
                .padding()
                
                // Дополнительные числа
                HStack(spacing: 10) {
                    ForEach([10, 11, 12, 13], id: \.self) { number in
                        AdditionalNumberView(label: "Число \(number-9)", value: square.numbers[number] ?? 0)
                    }
                }
                .padding()
                
                Button(action: {
                    showExplanation = true
                }) {
                    Text("Посмотреть трактовку")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Межстраничная реклама
                InterstitialAdButton()
                    .padding(.top, 5)
            }
            .padding(.bottom, 20)
            
            NavigationLink(
                destination: ExplanationView(characteristics: square.characteristics),
                isActive: $showExplanation
            ) {
                EmptyView()
            }
        }
        .navigationTitle("Результат")
    }
}

struct SquareCell: View {
    let number: Int
    let count: Int
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.blue.opacity(0.1))
                .frame(width: 80, height: 80)
                .border(Color.blue, width: 2)
            
            VStack {
                Text("\(number)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                Text("\(count)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
        }
    }
}

struct AdditionalNumberView: View {
    let label: String
    let value: Int
    
    var body: some View {
        VStack {
            Text(label)
                .font(.caption)
            
            Text("\(value)")
                .font(.title2)
                .fontWeight(.bold)
                .padding(8)
                .background(Circle().fill(Color.blue.opacity(0.2)))
        }
    }
}
