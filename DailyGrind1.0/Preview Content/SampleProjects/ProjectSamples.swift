//
//  ProjectSamples.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/24/24.
//

import Foundation

extension Project {
    static let lastWeek = Calendar.current.date(byAdding: .day, value: -7, to: Date.now)!
    static let lastMonth = Calendar.current.date(byAdding: .month, value: -1, to: Date.now)!
    static var sampleProjects: [Project] {
        [
            Project(title: "Create Personal Budget", briefDescription: "organize bills and opportunities for saving.", dateAdded: lastWeek, dateCompleted: Date.now, status: .planning),
            Project(title: "Create Workout App", briefDescription: "Workout app that captures training times, tracks workouts and journal entries for each workout", dateAdded: lastWeek, dateStarted: lastWeek, dateCompleted: Date.distantPast, status: .completed),
            Project(title: "Create Personal Budget", briefDescription: "Lorem ipsum odor amet, consectetuer adipiscing elit. Curae proin dignissim tellus turpis curabitur sodales tempus. Natoque proin arcu quam commodo netus ut eu.", dateAdded: lastWeek, dateCompleted: Date.now, status: .hold),
            Project(title: "Create Workout App", briefDescription: "Workout app that captures training times, tracks workouts and journal entries for each workout", dateAdded: lastWeek, dateStarted: lastWeek, dateCompleted: Date.distantPast, status: .active)
        ]
    }
}
