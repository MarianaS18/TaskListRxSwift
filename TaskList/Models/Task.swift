//
//  Task.swift
//  TaskList
//
//  Created by Mariana Steblii on 06/01/2022.
//

import Foundation

struct Task {
    let title: String
    let priority: Priority
}

enum Priority: Int {
    case high
    case medium
    case low
}
