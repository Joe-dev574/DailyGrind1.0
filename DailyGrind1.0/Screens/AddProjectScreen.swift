//
//  AddProjectScreen.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/22/24.
//

import SwiftUI

struct AddProjectScreen: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var briefDescription = ""
    var body: some View {
        NavigationStack {
            VStack{
                
                TextField("Project Title", text: $title)
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(7.5))
                    .font(.headline)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 15)
                    .padding(.vertical, 5)
                  
                TextField("Brief Description", text: $briefDescription)
                    .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(7.5))
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.horizontal, 15)
                .padding(.vertical,5)
            }
            .padding(.horizontal)
            Spacer()
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    ToolbarItem(placement: .principal) {
                        
                    HeaderView()
                    }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let newProject = Project(title: title, briefDescription: briefDescription)
                        context.insert(newProject)
                        dismiss()
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(title.isEmpty || briefDescription.isEmpty)
                }
            }
        }
    }
}
    

#Preview {
    AddProjectScreen()
}
