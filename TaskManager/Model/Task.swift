//
//  Task.swift
//  TaskManager
//
//  Created by Yuriy Pashkov on 20.05.2024.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class Task: Identifiable {
    var id: UUID
    var taskTitle: String
    var creationDate: Date
    var isCompleted: Bool
    var tint: String
    
    init(id: UUID = UUID(), taskTitle: String, creationDate: Date = Date(), isCompleted: Bool = false, tint: String) {
        self.id = id
        self.taskTitle = taskTitle
        self.creationDate = creationDate
        self.isCompleted = isCompleted
        self.tint = tint
    }
    
    var tintColor: Color {
//        switch tint {
//        case "taskColorOne": return .taskColorOne
//        case "taskColorTwo": return .taskColorTwo
//        case "taskColorThree": return .taskColorThree
//        case "taskColorFour": return .taskColorFour
//        case "taskColorFive": return .taskColorFive
//        default: return .black
//        }
        return Color.getColorFromString(tint)
    }
}

