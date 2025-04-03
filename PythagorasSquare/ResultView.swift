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
    @State private var isVisible = false
    @State private var selectedCell: Int? = nil
    @State private var showCellPopup = false
    @State private var popupText = ""
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green.opacity(0.1), .blue.opacity(0.1)]),                           startPoint: .top,                           endPoint: .bottom)
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Верхняя часть для шаринга
                    ShareableResultContent(
                        square: square,
                        isVisible: isVisible,
                        onCellTap: { number in
                            selectedCell = number
                            showCellPopup = true
                            // Выбираем правильный ключ в зависимости от диапазона числа
                            let descriptionKey: String
                            if (1...9).contains(number) {
                                descriptionKey = String(format: NSLocalizedString("result_number_label", comment: ""), number)
                            } else {
                                descriptionKey = NSLocalizedString("pythagoras_number_\(number)_title", comment: "Title for additional number \(number)")
                            }
                            
                            popupText = square.characteristics[descriptionKey] ?? ""
                        },
                        selectedCell: selectedCell
                    )
                    
                    // Остальные кнопки (оставить без изменений)
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
                    
                    // Кнопка "Поделиться"
                    Button(action: {
                        shareResult()
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text(LocalizedStringKey("share_button_title"))
                        }
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(15)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
                    }
                    .padding(.horizontal, 40)
                    .opacity(isVisible ? 1 : 0)
                    .animation(.easeIn(duration: 0.6).delay(0.5), value: isVisible)
                    
                    // Реклама
                    InterstitialAdButton()
                        .padding(.top, 5)
                        .opacity(isVisible ? 1 : 0)
                        .animation(.easeIn(duration: 0.6).delay(0.6), value: isVisible)
                    
                    Spacer(minLength: 20)
                }
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
            
            // Popup для ячеек
            if showCellPopup, let number = selectedCell {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showCellPopup = false
                            selectedCell = nil
                        }
                    }
                
                VStack(spacing: 15) {
                    HStack {
                        Spacer()
                        Button {
                            withAnimation(.spring()) {
                                showCellPopup = false
                                selectedCell = nil
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Text((1...9).contains(number) ?
                         String(format: NSLocalizedString("result_number_label", comment: ""), number) :
                         NSLocalizedString("pythagoras_number_\(number)_title", comment: ""))
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.blue)
                    
                    Text(popupText)
                        .font(.system(size: 16, design: .rounded))
                        .foregroundColor(.primary)
                        .padding(.leading, 10)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.systemBackground))
                )
                .transition(.scale.combined(with: .opacity))
                .zIndex(1)
                .frame(maxWidth: 300)
            }
        }
    }
    
    private func shareResult() {
        // Формируем текст для шаринга
        let shareTitle = NSLocalizedString("share_result_title", comment: "Title for sharing result")
        let generalCharacteristic = square.characteristics[NSLocalizedString("general_characteristic_title", comment: "Title for general characteristic")] ?? ""
        let resultText = "\(shareTitle)\n\n\(generalCharacteristic)"
        
        // Добавляем ссылку на приложение (опционально)
        let appURLString = "https://your-app-url.com" // Замени на реальную ссылку
        var items: [Any] = [resultText]
        
//        if let appURL = URL(string: appURLString) {
//            items.append(appURL)
//        }
        
        // Создаём скриншот только верхней части
        let shareableContent = ShareableResultContent(square: square, isVisible: true)
        let image = shareableContent.snapshot()
        items.append(image)
        
        // Настраиваем UIActivityViewController
        let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
        
        // Исключаем ненужные опции
        activityController.excludedActivityTypes = [
            .airDrop,
            .print,
            .addToReadingList,
            .saveToCameraRoll
        ]
        
        // Настройка для iPad
        if UIDevice.current.userInterfaceIdiom == .pad {
            activityController.popoverPresentationController?.sourceView = UIApplication.shared.windows.first?.rootViewController?.view
            activityController.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
        }
        
        // Показываем панель шаринга
        UIApplication.shared.windows.first?.rootViewController?.present(activityController, animated: true, completion: nil)
    }
}

struct SquareCell: View {
    let number: Int
    let count: Int
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .fill(isSelected ? Color.blue.opacity(0.3) : Color.blue.opacity(0.15))
                    .cornerRadius(10)
                    .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                    .scaleEffect(isSelected ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isSelected)
                
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
        .buttonStyle(PlainButtonStyle())
    }
}

struct AdditionalNumberView: View {
    let label: String
    let value: Int
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
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
                            .fill(isSelected ? Color.blue.opacity(0.3) : Color.blue.opacity(0.15))
                            .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                    )
                    .scaleEffect(isSelected ? 1.1 : 1.0)
                    .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isSelected)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
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
