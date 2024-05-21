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
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = false
    @State private var tasks: [Task] = Samples.sampleTasks.sorted(by: { $1.creationDate > $0.creationDate })
    @State private var createNewTask: Bool = false
    
    // animation week tab
    @Namespace private var animation
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            makeHeader()
            ScrollView(.vertical) {
                VStack {
                    makeTasksView()
                }
                .hSpacing(.center)
                .vSpacing(.center)
            }
            .scrollIndicators(.hidden)
        }
        .vSpacing(.top)
        .overlay(alignment: .bottomTrailing, content: {
            Button(action: {
                createNewTask.toggle()
            }, label: {
                Image(systemName: "plus")
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(width: 54, height: 54)
                    .background(Color.darkBlue.shadow(.drop(color: .black.opacity(0.25), radius: 5, x: 10, y: 10)), in: .circle)
            })
            .padding(16)
        })
        .onAppear {
            if weekSlider.isEmpty {
                let currentWeek = Date().fetchWeek()
                
                if let firstDay = currentWeek.first?.date {
                    weekSlider.append(firstDay.createPreviousWeek())
                }
                
                weekSlider.append(currentWeek)
                
                if let lastDay = currentWeek.last?.date {
                    weekSlider.append(lastDay.createNextWeek())
                }
                
            }
        }
        .sheet(isPresented: $createNewTask, content: {
            
        })
    }
    
    // MARK: - Make HeaderView
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
                        //.padding(.horizontal, 12)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 90)
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
        .onChange(of: currentWeekIndex) { oldValue, newValue in
            // paginator-flag, set when reaches first/last pages
            if newValue == 0 || newValue == (weekSlider.count - 1) {
                createWeek = true
            }
        }
    }
    
    // MARK: - Make WeeikView
    private func makeWeekView(_ week: [WeekDay]) -> some View {
        HStack(spacing: 0) {
            ForEach(week) { day in
                VStack(spacing: 8) {
                    Text(day.date.toString("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.gray)
                    
                    Text(day.date.toString("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .textScale(.secondary)
                        .foregroundStyle(isSameDate(day.date, currentDate) ? .white : .gray)
                        .frame(width: 36, height: 36)
                        .background(content: {
                            if isSameDate(day.date, currentDate) {
                                Circle()
                                    .fill(Color.darkBlue)
                                    .matchedGeometryEffect(id: "TABANIMATION", in: animation)
                            }
                            
                            // today indicator
                            if day.date.isToday {
                                Circle()
                                    .fill(.cyan)
                                    .frame(width: 5, height: 5)
                                    .vSpacing(.bottom)
                                    .offset(y: 12)
                            }
                        })
                        .background(.white.shadow(.drop(radius: 1)), in: .circle)
                }
                .hSpacing(.center)
                //.contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        currentDate = day.date
                    }
                }
            }
        }
        .background {
            GeometryReader {
                let minX = $0.frame(in: .global).minX
                Color.clear
                    .preference(key: OffsetKey.self, value: minX)
                    .onPreferenceChange(OffsetKey.self, perform: { value in
                        if value.rounded() == 16 && createWeek { // generate next set of weeks when offset reaches 16, padding in header value
                            paginateWeek()
                            createWeek = false
                            print("Generate week")
                        }
                    })
            }
        }
    }
    
    // MARK: - Make TasksView
    private func makeTasksView() -> some View {
        VStack(alignment: .leading, spacing: 36) {
            ForEach($tasks) { $task in
                TaskRowView(task: $task)
                    .background(alignment: .leading) {
                        if tasks.last?.id != task.id {
                            Rectangle()
                                .frame(width: 1)
                                .offset(x: 8)
                                .padding(.bottom, -36)
                        }
                    }
            }
        }
        .padding([.leading, .vertical], 16)
        .padding(.top, 16)
    }
    
    private func paginateWeek() {
        if weekSlider.indices.contains(currentWeekIndex) {
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0 {
                // insert new week at start pos, remove last week
                weekSlider.insert(firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
            
            if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == (weekSlider.count - 1) {
                // append new week, remove first week
                weekSlider.append(lastDate.createNextWeek())
                weekSlider.removeFirst()
                currentWeekIndex = weekSlider.count - 2
            }
        } else {
            print("Doesn't have current week index")
        }
    }
}

#Preview {
    ContentView()
}
