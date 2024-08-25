//
//  ProjectsListScreen.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/20/24.
//

import SwiftUI
import SwiftData

enum SortOrder: String, Identifiable, CaseIterable {
    case status, title, briefDescription
    
    var id: Self {
        self
    }
}


struct ProjectsListScreen: View {
    @State private var createNewProject = false
    @State private var sortOrder = SortOrder.status
    @State private var filter = ""
    var body: some View {
        ZStack {
            NavigationStack {
                ProjectList(sortOrder: sortOrder, filterString: filter).cornerRadius(10.0)
                    .padding(.horizontal, 4)
              //     .searchable(text: $filter, prompt: Text("Search with title or description"))
                  
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HeaderView()
                        }
                        ToolbarItem(placement: .topBarTrailing){
                            Button {
                                createNewProject = true
                            }label: {
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                            }
                        }
                    }
                    .sheet(isPresented: $createNewProject) {
                        AddProjectScreen()
                            .presentationDetents([.height(350)])
                    }
            }
           
           
        }
            
        }
    }



#Preview {
    let preview = Preview(Project.self)
    preview.addExamples(Project.sampleProjects)
    return ProjectsListScreen()
        .modelContainer(preview.container)
}


