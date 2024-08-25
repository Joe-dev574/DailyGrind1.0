//
//  EditProjectView.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/25/24.
//

import SwiftUI

struct EditProjectView: View {
    @Environment(\.dismiss) private var dismiss
    let project: Project
    @State private var status = Status.planning
   
    @State private var title = ""
    @State private var briefDescription = ""
    @State private var notes = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var firstView = true
    @State private var assignedTo = ""
    @State private var showFocusList = false
    
    var body: some View {
        
        Form{
        HStack {
            Picker("Status", selection: $status) {
                ForEach(Status.allCases) { status in
                    Text(status.descr).tag(status)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }.padding(.horizontal)
        //MARK: Date Group Box
            VStack(alignment: .leading) {
                GroupBox {
                    LabeledContent {
                        DatePicker("", selection: $dateAdded, displayedComponents: .date)
                    } label: {
                        Text("Date Added")
                    }
                    if status == .active || status == .completed {
                        LabeledContent {
                            DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                        } label: {
                            Text("Date Started")
                        }
                    }
                    if status == .completed {
                        LabeledContent {
                            DatePicker("", selection: $dateCompleted, in: dateStarted..., displayedComponents: .date)
                        } label: {
                            Text("Date Completed")
                        }
                    }
                }
                .foregroundStyle(.secondary)
                .onChange(of: status) { oldValue, newValue in
                    if !firstView {
                        if newValue == .planning {
                            dateStarted = Date.distantPast
                            dateCompleted = Date.distantPast
                        } else if newValue == .active && oldValue == .completed {
                            // from completed to inProgress
                            dateCompleted = Date.distantPast
                        } else if newValue == .active && oldValue == .planning {
                            // Book has been started
                            dateStarted = Date.now
                        } else if newValue == .completed && oldValue == .active {
                            // Forgot to start project
                            dateCompleted = Date.now
                            dateStarted = dateAdded
                        } else {
                            // completed
                            dateCompleted = Date.now
                        }
                        firstView = false
                    }
                }
            }
            LabeledContent {
                TextField("", text: $title) .textFieldStyle(.roundedBorder)
            } label: {
                Text("Title").foregroundStyle(.secondary)
            }
                VStack{
                    Text("Brief Description")
                TextEditor( text: $briefDescription)
                    .frame(width: 300, height: 250)
                    .padding(.horizontal)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 3))
            }
        
            LabeledContent {
                TextField("", text: $assignedTo) .textFieldStyle(.roundedBorder)
            } label: {
                Text("Owner").foregroundStyle(.secondary).fontWeight(.bold)
            }
            if let focusList = project.focusList {
                ViewThatFits {
                    FocusListStackView(focusList: focusList)
                    ScrollView(.horizontal, showsIndicators: false) {
                        FocusListView(project: project)
                    }
                }
            }
            HStack {
                Button("Focus", systemImage: "target") {
                    showFocusList.toggle()
                }
                .sheet(isPresented: $showFocusList) {
                    FocusListView(project: project)
                }
                NavigationLink {
                    NotesListScreen()
                } label: {
                    let count = project.notes?.count ?? 0
                    Label("^[\(count) Notes](inflect: true)", systemImage: "bookmark.fill")
                }
            }
        .buttonStyle(.bordered)
        //  .frame(maxWidth: .infinity, alignment: .trailing)
        .padding(.horizontal, 2)
    }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if changed {
                Button("Update") {
                    project.status = status.rawValue
                    project.title = title
                    project.briefDescription = briefDescription
                    project.dateAdded = dateAdded
                    project.dateStarted = dateStarted
                    project.dateCompleted = dateCompleted
                    project.assignedTo = assignedTo
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .onAppear {
            status = Status(rawValue: project.status)!
            title = project.title
            briefDescription = project.briefDescription
            dateAdded = project.dateAdded
            dateStarted = project.dateStarted
            dateCompleted = project.dateCompleted
            assignedTo = project.assignedTo
        }
    }
    
    var changed: Bool {
        status != Status(rawValue: project.status)!
        || title != project.title
        || briefDescription != project.briefDescription
        || dateAdded != project.dateAdded
        || dateStarted != project.dateStarted
        || dateCompleted != project.dateCompleted
        || assignedTo != project.assignedTo
    }
}

#Preview {
    let preview = Preview(Project.self)
   return  NavigationStack {
       EditProjectView(project: Project.sampleProjects[4])
           .modelContainer(preview.container)
    }
}
