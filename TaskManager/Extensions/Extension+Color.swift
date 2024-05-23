//
//  Extension+Color.swift
//  TaskManager
//
//  Created by Yuriy Pashkov on 21.05.2024.
//

import Foundation
import SwiftUI

extension Color {
    
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
    
    static var darkBlue: Color = .init(hex: 0x1850c0)
    static var taskColorOne: Color = .blue
    static var taskColorTwo: Color = .red
    static var taskColorThree: Color = .green
    static var taskColorFour: Color = .yellow
    static var taskColorFive: Color = .orange
    
    static var colors: [Color] = [.taskColorOne, .taskColorTwo, .taskColorThree, .taskColorFour, taskColorFive]
}
