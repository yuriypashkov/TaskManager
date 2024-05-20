//
//  HomeView.swift
//  TaskManager
//
//  Created by Yuriy Pashkov on 20.05.2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var currentDate: Date = Date()
    @State private var weekSlider: [[WeekDay]] = []
    @State private var currentWeekIndex: Int = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            makeHeader()
        }
        .vSpacing(.top)
    }
    
    private func makeHeader() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 4) {
                Text(currentDate.toString("MMMM"))
                    .foregroundStyle(.blue)
                
                Text(currentDate.toString("YYYY"))
                    .foregroundStyle(.gray)
            }
            .font(.title.bold())
            
            Text(currentDate.formatted(date: .complete, time: .omitted))
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
            
            // week slider
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index in
                    let week = weekSlider[index]
                    makeWeekView(week)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .hSpacing(.leading)
        .overlay(alignment: .topTrailing) {
            Button(action: {
                print("tap image")
            }, label: {
                Image("lemmy")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44, height: 44)
                    .clipShape(.circle)
            })
        }
        .padding(16)
        .background(.white)
    }
    
    private func makeWeekView(_ week: [WeekDay]) -> some View {
        HStack(spacing: 0) {
            
        }
    }
}

#Preview {
    ContentView()
}
