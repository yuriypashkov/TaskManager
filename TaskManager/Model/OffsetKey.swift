//
//  OffsetKey.swift
//  TaskManager
//
//  Created by Yuriy Pashkov on 21.05.2024.
//

import Foundation
import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
