//
//  ContentView.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import SwiftUI
import AVFoundation // Для работы со звуком

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var audioPlayer: AVAudioPlayer? // Для воспроизведения звука
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DateInputView()
                .tabItem {
                    Label(LocalizedStringKey("content_view_tab1"), systemImage: "number")
                }
                .tag(0)
            
            AboutView()
                .tabItem {
                    Label(LocalizedStringKey("content_view_tab2"), systemImage: "info.circle")
                }
                .tag(1)
        }
        .animation(.easeInOut(duration: 0.3), value: selectedTab) // Анимация переключения
        .onChange(of: selectedTab) { _ in
            playTabSwitchSound() // Воспроизведение звука при смене вкладки
        }
        .onAppear {
            // Настройка внешнего вида TabBar
            UITabBar.appearance().barTintColor = .systemBackground
            UITabBar.appearance().isTranslucent = true
            prepareAudioPlayer() // Подготовка звука при загрузке
        }
    }
    
    // Подготовка аудиоплеера
    private func prepareAudioPlayer() {
        guard let soundURL = Bundle.main.url(forResource: "tab_switch", withExtension: "mp3") else {
            print("Звуковой файл 'tab_switch.mp3' не найден")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.prepareToPlay() // Загружаем звук в память
        } catch {
            print("Ошибка подготовки звука: \(error.localizedDescription)")
        }
    }
    
    // Воспроизведение звука
    private func playTabSwitchSound() {
        audioPlayer?.currentTime = 0 // Сбрасываем на начало
        audioPlayer?.play()
    }
}

// Расширенный предпросмотр
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDisplayName("Светлая тема")
                .environment(\.colorScheme, .light)
                .previewLayout(.device)
                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
            
            ContentView()
                .previewDisplayName("Тёмная тема")
                .environment(\.colorScheme, .dark)
                .previewLayout(.device)
                .previewDevice(PreviewDevice(rawValue: "iPad Air (5th generation)"))
        }
    }
}
