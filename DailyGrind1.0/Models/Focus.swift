//
//  Focus.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/25/24.
//

import SwiftUI
import SwiftData

@Model
class Focus {
    var name: String
    var color: String
    var projects: [Project]?
    
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    
    var hexColor: Color {
        Color(hex: self.color) ?? .red
    }
}

