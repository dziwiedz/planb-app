//
//  ListsOfTasksView.swift
//  PlanB
//
//  Created by Łukasz Niedźwiedź on 12/03/2020.
//

import SwiftUI


struct Task: Identifiable, Hashable {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let category: String
    let color: ColorAsset?
    let dueDate: Date?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
}

struct TasksView: View {
    let task: Task
    
    var body: some View {
        Text(task.name)
            .foregroundColor(.init(.orange))
    }
}

struct TasksListView: View {
    let tasks: [Task] = [ .init(id: 0, name: "lol", category: "asda", color: nil, dueDate: nil)]
    
    var body: some View {
        List(tasks, id: \.self) { task in
            VStack(alignment: .leading, spacing: 8) {
                Text(task.name)
                Text(task.category)
            }
        }
    }
}
