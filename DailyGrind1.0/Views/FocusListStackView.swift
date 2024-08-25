//
//  FocusListStackView.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/25/24.
//

import SwiftUI

struct FocusListStackView: View {
    var focusList: [Focus]
    
    
    var body: some View {
        HStack{
            ForEach(focusList.sorted(using: KeyPathComparator(\Focus.name))) { focus in
                Text(focus.name)
                    .font(.callout)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5).fill(focus.hexColor))
            }
        }
    }
}

