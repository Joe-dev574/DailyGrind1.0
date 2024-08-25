//
//  Color.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/25/24.
//

import SwiftUI

extension Color {

    init?(hex: String) {
        guard let uiColor = UIColor(hex: hex) else { return nil }
        self.init(uiColor: uiColor)
    }

    func toHexString(includeAlpha: Bool = false) -> String? {
        return UIColor(self).toHexString(includeAlpha: includeAlpha)
    }

}
