//
//  TaskRowView.swift
//  TaskManager
//
//  Created by Yuriy Pashkov on 21.05.2024.
//

import SwiftUI

struct TaskRowView: View {
    
    @Binding var task: Task
    
    private var indicatorColor: Color {
        if task.isCompleted {
            return .green
        }
        
        return task.creationDate.isSameHour ? Color.darkBlue : task.creationDate.isPast ? .red : .black
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Circle()
                .fill(indicatorColor)
                .frame(width: 12, height: 12)
                .padding(4)
                .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
                .overlay { // for more accessible tap
                    Circle()
                        .frame(width: 50, height: 50)
                        .blendMode(.destinationOver)
                        .onTapGesture {
                            withAnimation(.snappy) {
                                task.isCompleted.toggle()
                            }
                        }
                }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(task.taskTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
                Label(task.creationDate.toString("hh:mm a"), systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.black)
            }
            .padding(16)
            .hSpacing(.leading)
            .background(task.tint, in: .rect(topLeadingRadius: 16, bottomLeadingRadius: 16))
            .strikethrough(task.isCompleted, pattern: .solid, color: .black.opacity(0.55))
            .offset(y: -8)
        }

    }
}

#Preview {
    ContentView()
}
