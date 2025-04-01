//
//  ContentView.swift
//  PythagorasSquare
//
//  Created by Roman Valchuk on 01.04.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            DateInputView()
                .tabItem {
                    Label("Расчет", systemImage: "calculator")
                }
                .tag(0)
            
            AboutView()
                .tabItem {
                    Label("О методе", systemImage: "info.circle")
                }
                .tag(1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
