//
//  ProjectCardView.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/24/24.
//

import SwiftUI
import SwiftData

struct ProjectCardView: View {
    @Environment(\.modelContext) private var context
    @Query private var projects: [Project]
    let project: Project
    
    var body: some View {
        ZStack {
            Color.clear
            HStack {
                HStack(alignment: .center){
                    project.icon
                        .resizable()
                        .frame(width: 35, height: 35)
                        .foregroundStyle(.launchAccent)
                    VStack(alignment: .leading){
                        Text(project.title)
                            .lineLimit(1)
                            .font(.title3)
                            .foregroundStyle(.launchAccent)
                            .cornerRadius(10)
                            .fontWeight(.bold)
                           
                        Text(project.briefDescription)
                            .foregroundStyle(.secondaryText)
                            .multilineTextAlignment(.leading)
                            .lineLimit(5)
                            .cornerRadius(10)
                            .font(.system(size: 14))
                            .padding(.horizontal)
                            .padding(.bottom, 5)
                    }
                }
                Spacer()
            }
            .padding(5)
            .padding(.horizontal, 2)
            .background {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.gray).opacity(0.1)
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
