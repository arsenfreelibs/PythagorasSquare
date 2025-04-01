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
    
    mutating func generateCharacteristics() {
        let requiredKeys = Set(1...13)
        let currentKeys = Set(numbers.keys)
        
        guard currentKeys == requiredKeys else {
            print("Ошибка: не все числа рассчитаны в numbers. Отсутствуют ключи: \(requiredKeys.subtracting(currentKeys))")
            return
        }
        
        // Трактовки для цифр 1-9
        if let ones = numbers[1], ones > 0 {
            if ones == 1 {
                characteristics["Число 1"] = "У вас 1 единица. Это говорит о наличии характера, воли, целеустремленности. Вы способны к лидерству, но не всегда им пользуетесь."
            } else if ones == 2 {
                characteristics["Число 1"] = "У вас 2 единицы. Вы обладаете сильным характером, целеустремленностью и ярко выраженными лидерскими качествами."
            } else if ones >= 3 {
                characteristics["Число 1"] = "У вас \(ones) единицы. Это указывает на очень сильную волю, упрямство и ярко выраженное стремление к лидерству. Вы не терпите возражений и стремитесь всегда быть первым."
            }
        } else {
            characteristics["Число 1"] = "Отсутствие единиц говорит о мягком характере, недостатке инициативы и воли. Вам сложно настоять на своем, но зато вы умеете приспосабливаться к обстоятельствам."
        }
        
        if let twos = numbers[2], twos > 0 {
            if twos == 1 {
                characteristics["Число 2"] = "У вас 1 двойка. Это указывает на уравновешенность, способность к компромиссам и дипломатии. Вы умеете находить баланс в отношениях."
            } else if twos == 2 {
                characteristics["Число 2"] = "У вас 2 двойки. Вы обладаете хорошими дипломатическими способностями, умеете слушать других и находить общий язык с разными людьми."
            } else if twos >= 3 {
                characteristics["Число 2"] = "У вас \(twos) двойки. Это указывает на выдающиеся дипломатические способности, миролюбие и склонность к сотрудничеству. Вы прирожденный миротворец и посредник."
            }
        } else {
            characteristics["Число 2"] = "Отсутствие двоек может указывать на недостаток гибкости в отношениях, трудности в нахождении компромиссов. Вам бывает сложно воспринимать чужую точку зрения."
        }
        
        if let threes = numbers[3], threes > 0 {
            if threes == 1 {
                characteristics["Число 3"] = "У вас 1 тройка. Это говорит о наличии творческого потенциала и самовыражения. Вы способны к нестандартному мышлению."
            } else if threes == 2 {
                characteristics["Число 3"] = "У вас 2 тройки. Вы обладаете ярким творческим мышлением, богатым воображением и стремлением к самовыражению."
            } else if threes >= 3 {
                characteristics["Число 3"] = "У вас \(threes) тройки. Это указывает на исключительные творческие способности, богатую фантазию и оригинальное мышление. Вы рождены для творчества и самовыражения."
            }
        } else {
            characteristics["Число 3"] = "Отсутствие троек может указывать на преобладание логического мышления над творческим, некоторую скованность в самовыражении. Вам может не хватать воображения."
        }
        
        if let fours = numbers[4], fours > 0 {
            if fours == 1 {
                characteristics["Число 4"] = "У вас 1 четверка. Это указывает на определенную методичность, стабильность и работоспособность. Вы способны к планомерному труду."
            } else if fours == 2 {
                characteristics["Число 4"] = "У вас 2 четверки. Вы обладаете хорошей работоспособностью, практичностью и методичностью. Вы надежны и основательны."
            } else if fours >= 3 {
                characteristics["Число 4"] = "У вас \(fours) четверки. Это указывает на выдающуюся трудоспособность, практичность и методичность. Вы очень надежны, ответственны и основательны во всем, что делаете."
            }
        } else {
            characteristics["Число 4"] = "Отсутствие четверок может указывать на недостаток практичности и методичности. Вам может быть сложно заниматься рутинной работой и доводить дела до конца."
        }
        
        if let fives = numbers[5], fives > 0 {
            if fives == 1 {
                characteristics["Число 5"] = "У вас 1 пятерка. Это говорит о любознательности, стремлении к новизне и переменам. Вы не любите застоя и рутины."
            } else if fives == 2 {
                characteristics["Число 5"] = "У вас 2 пятерки. Вы обладаете сильной тягой к новому опыту, любознательностью и стремлением к свободе. Вам необходимы перемены и разнообразие."
            } else if fives >= 3 {
                characteristics["Число 5"] = "У вас \(fives) пятерки. Это указывает на ярко выраженное стремление к свободе, авантюризм и жажду новых впечатлений. Вы не выносите ограничений и однообразия."
            }
        } else {
            characteristics["Число 5"] = "Отсутствие пятерок может указывать на консервативность, боязнь перемен и склонность к привычному образу жизни. Вам комфортнее в стабильной, предсказуемой обстановке."
        }
        
        if let sixes = numbers[6], sixes > 0 {
            if sixes == 1 {
                characteristics["Число 6"] = "У вас 1 шестерка. Это указывает на ответственность, заботливость и семейные ценности. Вы способны к состраданию и заботе о других."
            } else if sixes == 2 {
                characteristics["Число 6"] = "У вас 2 шестерки. Вы обладаете сильным чувством ответственности, заботой о близких и приверженностью к семейным ценностям. Вы надежный и заботливый человек."
            } else if sixes >= 3 {
                characteristics["Число 6"] = "У вас \(sixes) шестерки. Это указывает на выдающуюся способность к заботе, сильную привязанность к семье и высокое чувство ответственности. Забота о других - ваше призвание."
            }
        } else {
            characteristics["Число 6"] = "Отсутствие шестерок может указывать на трудности с выражением заботы и сострадания, некоторую отстраненность в отношениях. Вам может быть сложно брать на себя ответственность за других."
        }
        
        if let sevens = numbers[7], sevens > 0 {
            if sevens == 1 {
                characteristics["Число 7"] = "У вас 1 семерка. Это говорит о склонности к анализу, интеллектуальности и духовным поискам. Вы способны к глубокому мышлению."
            } else if sevens == 2 {
                characteristics["Число 7"] = "У вас 2 семерки. Вы обладаете сильным аналитическим умом, стремлением к познанию и духовному развитию. Вы глубокий мыслитель."
            } else if sevens >= 3 {
                characteristics["Число 7"] = "У вас \(sevens) семерки. Это указывает на выдающиеся интеллектуальные способности, глубокую мудрость и сильную тягу к духовным поискам. Вы философ и мыслитель по натуре."
            }
        } else {
            characteristics["Число 7"] = "Отсутствие семерок может указывать на преобладание практического мышления над теоретическим, некоторую поверхностность в суждениях. Вам может не хватать склонности к глубокому анализу."
        }
        
        if let eights = numbers[8], eights > 0 {
            if eights == 1 {
                characteristics["Число 8"] = "У вас 1 восьмерка. Это указывает на определенные организаторские способности, деловую хватку и материальные амбиции. Вы способны достичь финансового благополучия."
            } else if eights == 2 {
                characteristics["Число 8"] = "У вас 2 восьмерки. Вы обладаете хорошими организаторскими способностями, деловым чутьем и стремлением к материальному успеху. Вы прирожденный управленец."
            } else if eights >= 3 {
                characteristics["Число 8"] = "У вас \(eights) восьмерки. Это указывает на выдающиеся способности к бизнесу, управлению и достижению материального благополучия. Вы рождены быть лидером в деловой сфере."
            }
        } else {
            characteristics["Число 8"] = "Отсутствие восьмерок может указывать на недостаток деловой хватки, организаторских способностей и материальных амбиций. Вам может быть сложно достичь финансового благополучия."
        }
        
        if let nines = numbers[9], nines > 0 {
            if nines == 1 {
                characteristics["Число 9"] = "У вас 1 девятка. Это говорит о способности к состраданию, альтруизму и гуманистическим идеалам. Вы способны думать о благе других."
            } else if nines == 2 {
                characteristics["Число 9"] = "У вас 2 девятки. Вы обладаете сильным чувством справедливости, альтруизмом и гуманистическими ценностями. Вы стремитесь сделать мир лучше."
            } else if nines >= 3 {
                characteristics["Число 9"] = "У вас \(nines) девятки. Это указывает на высокий уровень альтруизма, сострадания и преданность гуманистическим идеалам. Ваше призвание - помогать другим и делать мир лучше."
            }
        } else {
            characteristics["Число 9"] = "Отсутствие девяток может указывать на преобладание личных интересов над общественными, некоторый эгоцентризм. Вам может быть сложно жертвовать своими интересами ради других."
        }
        
        // Трактовки для дополнительных чисел (10-13)
        if let firstNumber = numbers[10] {
            var destinyDescription = "Ваше число судьбы - \(firstNumber). Это число отражает вашу жизненную миссию и основной жизненный урок. "
            switch reduceToSingleDigit(firstNumber) {
            case 1:
                destinyDescription += "Ваша миссия - развивать лидерство, самостоятельность и уверенность в себе. Вам предстоит научиться брать инициативу в свои руки."
            case 2:
                destinyDescription += "Ваша миссия - найти гармонию в отношениях, научиться сотрудничать и быть дипломатичным. Вам важно развивать терпение и понимание."
            case 3:
                destinyDescription += "Ваша миссия - раскрыть творческий потенциал и делиться им с миром. Вам предстоит научиться самовыражению и вдохновлять других."
            case 4:
                destinyDescription += "Ваша миссия - строить стабильность и порядок в своей жизни и жизни окружающих. Вам важно развивать трудолюбие и практичность."
            case 5:
                destinyDescription += "Ваша миссия - принять перемены и свободу как часть жизни. Вам предстоит научиться адаптироваться и искать новые возможности."
            case 6:
                destinyDescription += "Ваша миссия - заботиться о других и создавать гармонию в семье и обществе. Вам важно развивать ответственность и сострадание."
            case 7:
                destinyDescription += "Ваша миссия - искать знания и духовную глубину. Вам предстоит развивать аналитический ум и внутреннюю мудрость."
            case 8:
                destinyDescription += "Ваша миссия - достичь материального успеха и управлять ресурсами. Вам важно научиться балансировать амбиции и справедливость."
            case 9:
                destinyDescription += "Ваша миссия - служить человечеству и приносить пользу миру. Вам предстоит развивать альтруизм и глобальное мышление."
            default:
                destinyDescription += "Это число указывает на уникальную задачу, которую вам предстоит раскрыть в течение жизни."
            }
            characteristics["Число судьбы (1)"] = destinyDescription
        }
        
        if let secondNumber = numbers[11] {
            var characterDescription = "Ваше число характера - \(secondNumber). Это число отражает ваши внутренние качества, особенности характера и темперамента. "
            switch reduceToSingleDigit(secondNumber) {
            case 1:
                characterDescription += "Вы независимы, решительны и стремитесь быть первым во всём."
            case 2:
                characterDescription += "Вы мягкий, дипломатичный и умеете находить общий язык с людьми."
            case 3:
                characterDescription += "Вы творческая личность с богатым воображением и ярким самовыражением."
            case 4:
                characterDescription += "Вы практичны, надёжны и любите порядок во всём."
            case 5:
                characterDescription += "Вы любознательны, свободолюбивы и не терпите рутины."
            case 6:
                characterDescription += "Вы заботливы, ответственны и цените семью."
            case 7:
                characterDescription += "Вы аналитичны, вдумчивы и стремитесь к знаниям."
            case 8:
                characterDescription += "Вы амбициозны, организованны и ориентированы на успех."
            case 9:
                characterDescription += "Вы сострадательны, идеалистичны и думаете о благе других."
            default:
                characterDescription += "Ваш характер уникален и многогранен."
            }
            characteristics["Число характера (2)"] = characterDescription
        }
        
        if let thirdNumber = numbers[12] {
            var appearanceDescription = "Ваше число внешнего проявления - \(thirdNumber). Это число отражает то, как вас воспринимают окружающие. "
            switch reduceToSingleDigit(thirdNumber) {
            case 1:
                appearanceDescription += "Люди видят вас как лидера, уверенного и инициативного."
            case 2:
                appearanceDescription += "Вас воспринимают как мягкого, дружелюбного и уравновешенного человека."
            case 3:
                appearanceDescription += "Окружающие замечают вашу креативность и яркость."
            case 4:
                appearanceDescription += "Вас считают надёжным, стабильным и практичным."
            case 5:
                appearanceDescription += "Люди видят в вас энергичного, свободного и непредсказуемого человека."
            case 6:
                appearanceDescription += "Вас воспринимают как заботливого и ответственного."
            case 7:
                appearanceDescription += "Окружающие видят вас как глубокого, загадочного и умного."
            case 8:
                appearanceDescription += "Люди считают вас сильным, властным и успешным."
            case 9:
                appearanceDescription += "Вас воспринимают как доброго, щедрого и вдохновляющего."
            default:
                appearanceDescription += "Вы производите уникальное впечатление на окружающих."
            }
            characteristics["Число внешнего проявления (3)"] = appearanceDescription
        }
        
        if let fourthNumber = numbers[13] {
            var energyDescription = "Ваше число энергии - \(fourthNumber). Это число отражает ваш энергетический потенциал и силу воздействия на мир. "
            switch reduceToSingleDigit(fourthNumber) {
            case 1:
                energyDescription += "Ваша энергия направлена на достижение целей и лидерство."
            case 2:
                energyDescription += "Ваша энергия мягкая, гармоничная и способствует сотрудничеству."
            case 3:
                energyDescription += "Ваша энергия творческая и вдохновляющая."
            case 4:
                energyDescription += "Ваша энергия стабильная и поддерживает упорный труд."
            case 5:
                energyDescription += "Ваша энергия динамичная, направлена на перемены и свободу."
            case 6:
                energyDescription += "Ваша энергия тёплая, заботливая и поддерживающая."
            case 7:
                energyDescription += "Ваша энергия глубокая, интеллектуальная и созерцательная."
            case 8:
                energyDescription += "Ваша энергия мощная, направлена на успех и управление."
            case 9:
                energyDescription += "Ваша энергия щедрая, направлена на помощь другим."
            default:
                energyDescription += "Ваша энергия уникальна и многогранна."
            }
            characteristics["Число энергии (4)"] = energyDescription
        }
        
        // Генерация уникальной общей характеристики
        var strongTraits: [String] = []
        var weakTraits: [String] = []
        
        // Анализируем цифры 1-9
        for digit in 1...9 {
            if let count = numbers[digit] {
                switch count {
                case 2...Int.max: // Сильные стороны (2 и более повторений)
                    switch digit {
                    case 1: strongTraits.append("сильный характер и лидерство")
                    case 2: strongTraits.append("дипломатичность и гибкость")
                    case 3: strongTraits.append("творческий потенциал")
                    case 4: strongTraits.append("практичность и трудолюбие")
                    case 5: strongTraits.append("любознательность и стремление к свободе")
                    case 6: strongTraits.append("заботливость и ответственность")
                    case 7: strongTraits.append("интеллектуальность и мудрость")
                    case 8: strongTraits.append("деловая хватка и организаторские способности")
                    case 9: strongTraits.append("альтруизм и гуманизм")
                    default: break
                    }
                case 0: // Слабые стороны (отсутствие цифры)
                    switch digit {
                    case 1: weakTraits.append("инициативу и уверенность")
                    case 2: weakTraits.append("гибкость в отношениях")
                    case 3: weakTraits.append("творческое самовыражение")
                    case 4: weakTraits.append("методичность и стабильность")
                    case 5: weakTraits.append("открытость переменам")
                    case 6: weakTraits.append("заботу о других")
                    case 7: weakTraits.append("глубокий анализ и духовность")
                    case 8: weakTraits.append("материальные амбиции")
                    case 9: weakTraits.append("стремление к помощи окружающим")
                    default: break
                    }
                default: break // 1 повторение — нейтрально, не упоминаем
                }
            }
        }
        
        // Формируем текст
        var generalText = "Ваш квадрат Пифагора отражает уникальное сочетание качеств. "
        
        // Сильные стороны
        if strongTraits.isEmpty {
            generalText += "Ваша сила пока не выделяется ярко выраженными чертами, но это даёт вам гибкость в развитии любых качеств. "
        } else {
            generalText += "Ваши сильные стороны — это \(strongTraits.enumerated().map { $0.offset == strongTraits.count - 1 && strongTraits.count > 1 ? "и " + $0.element : $0.element }.joined(separator: ", ")). "
        }
        
        // Слабые стороны
        if weakTraits.isEmpty {
            generalText += "У вас нет явных пробелов, что указывает на сбалансированную натуру. "
        } else {
            generalText += "Области, которые стоит развивать, включают \(weakTraits.enumerated().map { $0.offset == weakTraits.count - 1 && weakTraits.count > 1 ? "и " + $0.element : $0.element }.joined(separator: ", ")). "
        }
        
        // Завершение
        generalText += "Гармоничное развитие ваших уникальных черт поможет вам достичь успеха и внутреннего баланса."
        
        characteristics["Общая характеристика"] = generalText
    }
    
    func reduceToSingleDigit(_ number: Int) -> Int {
        var result = abs(number)
        while result > 9 {
            result = String(result).compactMap { Int(String($0)) }.reduce(0, +)
        }
        return result
    }
}
