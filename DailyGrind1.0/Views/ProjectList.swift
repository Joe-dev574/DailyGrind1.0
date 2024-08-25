//
//  ProjectListView.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/23/24.
//
import SwiftData
import SwiftUI

struct ProjectList: View {
    @Environment(\.modelContext) private var context
    @Query private var projects: [Project]
    @State var width = UIScreen.main.bounds.width
    @Namespace private var animation
    
    init(sortOrder: SortOrder, filterString: String) {
        let sortDescriptors: [SortDescriptor<Project>] = switch sortOrder {
        case .status:
            [SortDescriptor(\Project.status), SortDescriptor(\Project.title)]
        case .title:
            [SortDescriptor(\Project.title)]
        case .briefDescription:
            [SortDescriptor(\Project.briefDescription)]
        }
        
        let predicate = #Predicate<Project> { project in
            project.title.localizedStandardContains(filterString)
            || project.briefDescription.localizedStandardContains(filterString)
            || filterString.isEmpty
        }
        _projects = Query(filter: predicate, sort: sortDescriptors)
    }
    var body: some View {
        //MARK:  SCROLL VIEW
        GeometryReader {
            let size = $0.size
            ScrollView(.vertical, showsIndicators: false){
                VStack (spacing: 25){
                    ForEach(projects) { project in
                        NavigationLink{
                            EditProjectView(project: project)
                        }label:{
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
                                        
                                        if let focusList = project.focusList {
                                            ViewThatFits {
                                                FocusListStackView(focusList: focusList)
                                                ScrollView(.horizontal, showsIndicators: false) {
                                                    FocusListStackView(focusList: focusList)
                                                }
                                            }
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
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let project = projects[index]
                            context.delete(project)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Project.self)
    preview.addExamples(Project.sampleProjects)
    return NavigationStack {
        ProjectList(sortOrder: .status, filterString: "")
    }
        .modelContainer(preview.container)
}

/// Bottom Padding for last card to move up to the top
func bottomPadding(_ size: CGSize = .zero) -> CGFloat {
    let cardHeight: CGFloat = 220
    let scrollViewHeight: CGFloat = size.height
    
    return scrollViewHeight - cardHeight - 40
}

