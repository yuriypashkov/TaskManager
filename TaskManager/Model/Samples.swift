//
//  Samples.swift
//  TaskManager
//
//  Created by Yuriy Pashkov on 20.05.2024.
//

import Foundation

class Samples {
    static var sampleTasks: [Task] = [
        Task(taskTitle: "Record video", creationDate: .updateHour(-4), isCompleted: true, tint: .taskColorOne),
        Task(taskTitle: "Redesign website", creationDate: .updateHour(-3), isCompleted: true, tint: .taskColorTwo),
        Task(taskTitle: "Eat the lunch", tint: .taskColorThree),
        Task(taskTitle: "Go for a walk", creationDate: .updateHour(3), tint: .taskColorFour),
        Task(taskTitle: "Go to sleep", creationDate: .updateHour(1), tint: .taskColorFive)
    ]
}
