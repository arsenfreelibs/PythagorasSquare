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
        for i in 1...13 {
            numbers[i] = 0
        }
        
        // Получаем компоненты даты
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: birthDate)
        
        guard let day = components.day, let month = components.month, let year = components.year else {
            print("Ошибка: не удалось извлечь компоненты даты")
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
        let firstDigitOfDay = Int(String(dayString.first ?? "0")) ?? 0
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
    
    fileprivate func getKeyBy(num:Int) -> String {
        return String(format: NSLocalizedString("result_number_label", comment: "Label for Pythagoras square number (e.g., 'Number 1')"), num)
    }
    
    mutating func generateCharacteristics() {
        let requiredKeys = Set(1...13)
        let currentKeys = Set(numbers.keys)
        
        guard currentKeys == requiredKeys else {
            print("Ошибка: не все числа рассчитаны в numbers. Отсутствуют ключи: \(requiredKeys.subtracting(currentKeys))")
            return
        }
        
        // Трактовки для цифр 1-9
        for number in 1...9 {
            if let count = numbers[number], count > 0 {
                switch count {
                case 1:
                    characteristics[getKeyBy(num: number)] = NSLocalizedString("pythagoras_number_\(number)_one", comment: "Description for one occurrence of number \(number)")
                case 2:
                    characteristics[getKeyBy(num: number)] = NSLocalizedString("pythagoras_number_\(number)_two", comment: "Description for two occurrence of number \(number)")
                case 3...:
                    characteristics[getKeyBy(num: number)] = String(format: NSLocalizedString("pythagoras_number_\(number)_many", comment: "Description for \(count) occurrences of number \(number)"), count)
                default:
                    break
                }
            } else {
                characteristics[getKeyBy(num: number)] = NSLocalizedString("pythagoras_number_\(number)_none", comment: "Description for no occurrences of number \(number)")
            }
        }
        
        // Трактовки для дополнительных чисел (10-13)
        for number in 10...13 {
            if let count = numbers[number] {
                var description = String(format: NSLocalizedString("pythagoras_number_\(number)_intro", comment: "Intro for additional number \(number)"), count)
                description += NSLocalizedString("pythagoras_number_\(number)_\(reduceToSingleDigit(count))", comment: "Description for reduced value of number \(number)")
                characteristics[NSLocalizedString("pythagoras_number_\(number)_title", comment: "Title for additional number \(number)")] = description
            }
        }
        
        // Генерация уникальной общей характеристики
        var strongTraits: [String] = []
        var weakTraits: [String] = []
        
        // Анализируем цифры 1-9
        for digit in 1...9 {
            if let count = numbers[digit] {
                switch count {
                case 2...Int.max:
                    strongTraits.append(NSLocalizedString("strong_trait_\(digit)", comment: "Strong trait for number \(digit)"))
                case 0:
                    weakTraits.append(NSLocalizedString("weak_trait_\(digit)", comment: "Weak trait for number \(digit)"))
                default:
                    break
                }
            }
        }
        
        // Формируем текст
        var generalText = NSLocalizedString("general_characteristic_intro", comment: "Introduction to general characteristic")
        
        // Сильные стороны
        if strongTraits.isEmpty {
            generalText += NSLocalizedString("general_characteristic_no_strong", comment: "Text when no strong traits are present")
        } else {
            let traitsList = strongTraits.enumerated().map { $0.offset == strongTraits.count - 1 && strongTraits.count > 1 ? NSLocalizedString("and", comment: "Conjunction 'and'") + " " + $0.element : $0.element }.joined(separator: NSLocalizedString("comma", comment: "Comma separator") + " ")
            let formatString = NSLocalizedString("general_characteristic_strong", comment: "Text with strong traits")
            generalText += String(format: formatString, traitsList)
        }
        
        // Слабые стороны
        if weakTraits.isEmpty {
            generalText += NSLocalizedString("general_characteristic_no_weak", comment: "Text when no weak traits are present")
        } else {
            let traitsList = weakTraits.enumerated().map { $0.offset == weakTraits.count - 1 && weakTraits.count > 1 ? NSLocalizedString("and", comment: "Conjunction 'and'") + " " + $0.element : $0.element }.joined(separator: NSLocalizedString("comma", comment: "Comma separator") + " ")
            let formatString = NSLocalizedString("general_characteristic_weak", comment: "Text with weak traits")
            generalText += String(format: formatString, traitsList)
        }
        
        // Завершение
        generalText += NSLocalizedString("general_characteristic_outro", comment: "Outro for general characteristic")
        
        characteristics[NSLocalizedString("general_characteristic_title", comment: "Title for general characteristic")] = generalText
    }
    
    func reduceToSingleDigit(_ number: Int) -> Int {
        var result = abs(number)
        while result > 9 {
            result = String(result).compactMap { Int(String($0)) }.reduce(0, +)
        }
        return result
    }
}
