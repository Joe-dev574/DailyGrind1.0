//
//  NewFocusView.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/25/24.
//

import SwiftData
import SwiftUI

struct NewFocusView: View {
    @State private var name = ""
    @State private var color = Color.green
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("name", text: $name)
                ColorPicker("Set the label color", selection: $color, supportsOpacity: false)
                Button("Create") {
                    let newFocus = Focus(name: name, color: color.toHexString()!)
                    context.insert(newFocus)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(name.isEmpty)
            }
            .padding()
            .navigationTitle("New Focus Tag")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NewFocusView()
}
