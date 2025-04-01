//
//  AboutView.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("О методе «Квадрат Пифагора»")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top)
                
                Text("«Квадрат Пифагора» или «Психоматрица» — это метод нумерологического анализа личности, основанный на дате рождения человека.")
                
                Text("Метод позволяет определить сильные и слабые стороны характера, таланты, склонности и потенциал человека.")
                
                Text("Для расчета используются числа из даты рождения, которые размещаются в особой матрице, состоящей из 9 ячеек. Каждое число имеет свое значение и влияние на различные аспекты жизни.")
                
                // Добавьте больше информации о методе
                
                // Баннерная реклама
                BannerView()
                    .frame(height: 50)
                    .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Информация")
    }
}
