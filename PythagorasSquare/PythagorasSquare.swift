//
//  PythagorasSquare.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import Foundation

struct PythagorasSquare {
    var birthDate: Date
    var numbers: [Int: Int] = [:]
    var characteristics: [String: String] = [:]
    
    init(birthDate: Date) {
        self.birthDate = birthDate
        calculate()
    }
    
    mutating func calculate() {
        // Получаем компоненты даты
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: birthDate)
        
        guard let day = components.day, let month = components.month, let year = components.year else {
            return
        }
        
        // Преобразуем дату рождения в строку цифр
        let dayString = String(day)
        let monthString = String(month)
        let yearString = String(year)
        
        // Соединяем все цифры в одну строку
        let dateString = dayString + monthString + yearString
        
        // Первое число (первая цифра) - это сумма всех цифр даты рождения
        let firstNumber = dateString.compactMap { Int(String($0)) }.reduce(0, +)
        
        // Второе число - сумма цифр первого числа
        let secondNumber = String(firstNumber).compactMap { Int(String($0)) }.reduce(0, +)
        
        // Третье число - разность первого и удвоенной первой цифры дня рождения
        let firstDigitOfDay = Int(String(dayString.first!))!
        let thirdNumber = firstNumber - (2 * firstDigitOfDay)
        
        // Четвертое число - сумма цифр третьего числа
        let fourthNumber = String(abs(thirdNumber)).compactMap { Int(String($0)) }.reduce(0, +)
        
        // Заполняем квадрат цифрами из даты рождения
        let allDigits = dateString.compactMap { Int(String($0)) }
        for digit in 1...9 {
            numbers[digit] = allDigits.filter { $0 == digit }.count
        }
        
        // Добавляем расчетные числа в карту
        numbers[10] = firstNumber
        numbers[11] = secondNumber
        numbers[12] = thirdNumber
        numbers[13] = fourthNumber
        
        // Заполняем характеристики на основе квадрата
        generateCharacteristics()
    }
    
    mutating func generateCharacteristics() {
        // Заполнение трактовок
        if let ones = numbers[1], ones > 0 {
            characteristics["Число 1"] = "Наличие \(ones) единиц говорит о вашей целеустремленности и лидерских качествах."
        } else {
            characteristics["Число 1"] = "Отсутствие единиц может указывать на недостаток инициативы."
        }
        
        // Добавьте трактовки для остальных чисел...
    }
}
