//
//  DateInputView.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import SwiftUI

struct DateInputView: View {
    @State private var birthDate = Date()
    @State private var showResults = false
    @State private var isButtonPressed = false
    @State private var isVisible = false
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(0.1), .purple.opacity(0.1)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                GeometryReader { geometry in
                    ScrollView { // Добавляем прокрутку
                        VStack(spacing: 20) {
                            // Заголовок
                            Text("Введите дату рождения")
                                .font(.system(size: 24, weight: .bold, design: .rounded))
                                .foregroundColor(.primary)
                                .padding(.top)
                                .opacity(isVisible ? 1 : 0)
                                .animation(.easeIn(duration: 0.5), value: isVisible)
                            
                            // DatePicker с подсказкой
                            VStack(spacing: 8) {
                                DatePicker(
                                    "Дата рождения",
                                    selection: $birthDate,
                                    in: ...Date(),
                                    displayedComponents: .date
                                )
                                .datePickerStyle(.graphical)
                                .accentColor(.purple)
                                .background(Color(.systemBackground).opacity(0.8))
                                .cornerRadius(12)
                                .shadow(radius: 5)
                                .frame(maxWidth: geometry.size.width > 500 ? 400 : .infinity)
                                .padding(.horizontal)
                                .opacity(isVisible ? 1 : 0)
                                .animation(.easeIn(duration: 0.6).delay(0.2), value: isVisible)
                                
                                Text("Выберите дату для расчёта вашей судьбы")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                    .opacity(isVisible ? 1 : 0)
                                    .animation(.easeIn(duration: 0.6).delay(0.3), value: isVisible)
                            }
                            
                            // Кнопка
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    isButtonPressed = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                    isButtonPressed = false
                                    showResults = true
                                }
                            }) {
                                Text("Рассчитать")
                                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: geometry.size.width > 500 ? 400 : .infinity)
                                    .background(
                                        LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                                    )
                                    .cornerRadius(15)
                                    .scaleEffect(isButtonPressed ? 0.95 : 1.0)
                                    .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 2)
                            }
                            .padding(.horizontal, geometry.size.width > 500 ? 50 : 40)
                            .opacity(isVisible ? 1 : 0)
                            .animation(.easeIn(duration: 0.6).delay(0.4), value: isVisible)
                            
                            // Минимальный отступ для прокрутки
                            Spacer(minLength: 60) // Учитываем высоту баннера и табов
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .safeAreaInset(edge: .bottom) { // Баннер в безопасной зоне
                        BannerView()
                            .frame(height: 50)
                            .background(Color(.systemBackground).opacity(0.8))
                            .opacity(isVisible ? 1 : 0)
                            .animation(.easeIn(duration: 0.6).delay(0.5), value: isVisible)
                    }
                }
            }
            .navigationTitle("Квадрат Пифагора")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { birthDate = Date() }) {
                        Image(systemName: "arrow.clockwise")
                            .foregroundColor(.purple)
                    }
                }
            }
            .background(
                NavigationLink(
                    destination: ResultView(square: PythagorasSquare(birthDate: birthDate)),
                    isActive: $showResults
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

struct DateInputView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DateInputView()
                .environment(\.colorScheme, .light)
                .previewDisplayName("Светлая тема (Вертикально)")
                .previewLayout(.device)
                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            
            DateInputView()
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Тёмная тема (Горизонтально)")
                .previewLayout(.device)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
                .previewInterfaceOrientation(.landscapeLeft)
        }
    }
}
