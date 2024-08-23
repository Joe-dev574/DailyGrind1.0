//
//  TabModel.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/20/24.
//

import SwiftUI

/// App Tab's
enum Tab: String, CaseIterable {
    case grind = "Grind"
    case projects = "Projects"
    case objectives = "Objectives"
    case notes = "Notes"
  
    
    
    var systemImage: String {
        switch self {
        case .grind:
            return "mug.fill"
        case .projects:
            return "location.north.circle"
        case .objectives:
            return "checkmark.circle"
        case .notes:
            return "square.and.pencil.circle"
       
        }
    }
    
    var index: Int {
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}


