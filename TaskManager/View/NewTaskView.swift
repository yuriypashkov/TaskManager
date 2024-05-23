//
//  NewTaskView.swift
//  TaskManager
//
//  Created by Yuriy Pashkov on 23.05.2024.
//

import SwiftUI

struct NewTaskView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var taskColor: Color = .taskColorOne
    @State private var taskTitle: String = ""
    @State private var taskDate: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .tint(.red)
            })
            .hSpacing(.trailing)
            .padding(.top, 12)

            VStack(alignment: .leading, spacing: 8, content: {
                Text("Task Title")
                    .font(.caption)
                    .foregroundStyle(.gray)
                TextField("Enter your task title", text: $taskTitle)
                    .padding(.vertical, 12)
                    .padding(.horizontal, 12)
                    .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 2)), in: .rect(cornerRadius: 12))
                
            })
            .padding(4)
            
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Task Date")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                        .scaleEffect(0.9, anchor: .leading)
                })
                //.padding(.top, 4)
                .padding(.trailing, -16)
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text("Task Color")
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    HStack(spacing: 0) {
                        ForEach(Color.colors, id: \.self) { color in
                            Circle()
                                .fill(color)
                                .frame(width: 20, height: 20)
                                .background(content: {
                                    Circle()
                                        .stroke(lineWidth: 2)
                                        .opacity(taskColor == color ? 1 : 0)
                                })
                                .hSpacing(.center)
                                .contentShape(.rect)
                                .onTapGesture {
                                    withAnimation(.snappy) {
                                        taskColor = color
                                    }
                                }
                        }
                    }
                    
                })
                //.padding(4)
            }
            .padding(.top, 5)
            
            Spacer()
            
            Button(action: {
                
            }, label: {
                Text("Create task")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .textScale(.secondary)
                    .foregroundStyle(.black)
                    .hSpacing(.center)
                    .padding(.vertical, 12)
                    .background(taskColor, in: .rect(cornerRadius: 12))
            })
            .disabled(taskTitle == "")
            .opacity(taskTitle == "" ? 0.5 : 1)
        }
        .padding(16)
    }
}

#Preview {
    NewTaskView()
        .vSpacing(.bottom)
}
