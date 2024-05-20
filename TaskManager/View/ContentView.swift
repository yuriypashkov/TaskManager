//
//  ContentView.swift
//  TaskManager
//
//  Created by Yuriy Pashkov on 20.05.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray.opacity(0.1))
            .preferredColorScheme(.light)
    }
}

#Preview {
    ContentView()
}
