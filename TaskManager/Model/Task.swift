//
//  Task.swift
//  TaskManager
//
//  Created by Yuriy Pashkov on 20.05.2024.
//

import Foundation
import SwiftUI

struct Task: Identifiable {
    var id: UUID = UUID()
    var taskTitle: String
    var creationDate: Date = Date()
    var isCompleted: Bool = false
    var tint: Color
}

