//
//  FocusView.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/25/24.
//

import SwiftData
import SwiftUI

struct FocusListView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @Bindable var project: Project
    @Query(sort: \Focus.name) var focusList: [Focus]
    @State private var newFocus = false
    var body: some View {
        NavigationStack {
            Group {
                if focusList.isEmpty {
                    ContentUnavailableView {
                        Image(systemName: "bookmark.fill")
                            .font(.largeTitle)
                    } description: {
                        Text("You need to create some focus first.")
                    } actions: {
                        Button("Create Focus") {
                            newFocus.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List {
                        ForEach(focusList) { focus in
                            HStack {
                                if let projectFocusList = project.focusList {
                                    if projectFocusList.isEmpty {
                                        Button {
                                            addRemove(focus)
                                        } label: {
                                            Image(systemName: "circle")
                                        }
                                        .foregroundStyle(focus.hexColor)
                                    } else {
                                        Button {
                                            addRemove(focus)
                                        } label: {
                                            Image(systemName: projectFocusList.contains(focus) ? "circle.fill" : "circle")
                                        }
                                        .foregroundStyle(focus.hexColor)
                                    }
                                }
                                Text(focus.name)
                            }
                        }
                        .onDelete(perform: { indexSet in
                            indexSet.forEach { index in
                                if let projectFocusList = project.focusList,
                                   projectFocusList.contains(focusList[index]),
                                   let projectFocusIndex = projectFocusList.firstIndex(where: {$0.id == focusList[index].id}) {
                                    project.focusList?.remove(at: projectFocusIndex)
                                }
                                context.delete(focusList[index])
                            }
                        })
                        LabeledContent {
                            Button {
                                newFocus.toggle()
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }
                            .buttonStyle(.borderedProminent)
                        } label: {
                            Text("Create New Focus")
                                .font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(project.title)
            .sheet(isPresented: $newFocus) {
                NewFocusView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func addRemove(_ focus: Focus) {
        if let projectFocusList = project.focusList {
            if projectFocusList.isEmpty {
                project.focusList?.append(focus)
            } else {
                if projectFocusList.contains(focus),
                   let index = projectFocusList.firstIndex(where: {$0.id == focus.id}) {
                    project.focusList?.remove(at: index)
                } else {
                    project.focusList?.append(focus)
                }
            }
        }
    }
}

#Preview {
    let preview = Preview(Project.self)
    let projects = Project.sampleProjects
    let focusList = Focus.sampleFocusList
    preview.addExamples(focusList)
    preview.addExamples(projects)
    projects[1].focusList?.append(focusList[0])
    return FocusListView(project: projects[1])
        .modelContainer(preview.container)
}
