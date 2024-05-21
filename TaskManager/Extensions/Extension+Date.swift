//
//  Extension+Date.swift
//  TaskManager
//
//  Created by Yuriy Pashkov on 20.05.2024.
//

import Foundation

extension Date {
    // increase hour by value
    static func updateHour(_ value: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: value, to: Date()) ?? Date()
    }
    
    // check today date
    var isToday: Bool {
        return Calendar.current.isDateInToday(self)
    }
    
    // check date same hour
    var isSameHour: Bool {
        return Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedSame
    }
    
    // check date is past
    var isPast: Bool {
        return Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedAscending
    }
    
    // date to string in custom format
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    // create current week based on current date
    func fetchWeek(_ date: Date = Date()) -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        var week: [WeekDay] = []
        
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDay)
        guard let startOfWeek = weekForDate?.start else { return week }
        
        // get full week
        (0...6).forEach { index in
            if let weekDay = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                week.append(WeekDay(date: weekDay))
            }
        }
        
        return week
    }
    
    // create next week based last date of current week
    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfLastDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfLastDate) else { return [] }
        
        return fetchWeek(nextDate)
    }
    
    // create previous week based first date of current week
    func createPreviousWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfFirstDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfFirstDate) else { return [] }
        
        return fetchWeek(previousDate)
    }
}
