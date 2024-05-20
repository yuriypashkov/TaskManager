//
//  Extension+Date.swift
//  TaskManager
//
//  Created by Yuriy Pashkov on 20.05.2024.
//

import Foundation

extension Date {
    static func updateHour(_ value: Int) -> Date {
        Calendar.current.date(byAdding: .hour, value: value, to: Date()) ?? Date()
    }
    
    func toString(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
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
}
