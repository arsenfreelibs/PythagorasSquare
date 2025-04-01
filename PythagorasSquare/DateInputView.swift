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
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Введите дату рождения")
                    .font(.headline)
                    .padding()
                
                DatePicker("", selection: $birthDate, displayedComponents: .date)
                    .datePickerStyle(WheelDatePickerStyle())
                    .labelsHidden()
                    .padding()
                
                Button(action: {
                    showResults = true
                }) {
                    Text("Рассчитать")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                
                // Баннерная реклама внизу экрана
                BannerView()
                    .frame(height: 50)
                    .padding(.top)
                
                NavigationLink(
                    destination: ResultView(square: PythagorasSquare(birthDate: birthDate)),
                    isActive: $showResults
                ) {
                    EmptyView()
                }
            }
            .navigationTitle("Квадрат Пифагора")
        }
    }
}

struct DateInputView_Previews: PreviewProvider {
    static var previews: some View {
        DateInputView()
    }
}
