//
//  Project.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/20/24.
//

import SwiftUI
import SwiftData

@Model
class Project {
    var title: String
    var briefDescription: String
    var dateAdded: Date
    var dateStarted: Date
    var dateCompleted: Date
    var notes: String
    var priority: Int?
    var status: Status.RawValue
    var recommendedBy: String = ""
    
    init(
        title: String,
        briefDescription: String,
        dateAdded: Date = Date.now,
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date = Date.distantPast,
        notes: String = "",
        priority: Int? = nil,
        status: Status = .active,
        recommendedBy: String = ""
    ) {
        self.title = title
        self.briefDescription = briefDescription
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.notes = notes
        self.priority = priority
        self.status = status.rawValue
        self.recommendedBy = recommendedBy
    }
    var icon: Image {
        switch Status(rawValue: status)! {
        case .planning:
            Image(systemName: "calendar.badge.clock")
        case .active:
            Image(systemName: "hourglass.circle")
        case .completed:
            Image(systemName: "checkmark.seal")
        case .hold:
            Image(systemName: "exclamationmark.circle")
        }
    }
}


enum Status: Int, Codable, Identifiable, CaseIterable {
    case planning,active, completed, hold
    var id: Self {
        self
    }
    var descr: String {
        switch self {
        case .planning:
            "Planning"
        case .active:
            "Active"
        case .completed:
            "Completed"
        case .hold:
            "Hold"
        }
    }
}

