//
//  EditProjectScreen.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/24/24.
//

import SwiftUI

struct EditProjectScreen: View {
    @Environment(\.dismiss) private var dismiss
    let project: Project
    @State private var status = Status.planning
    @State private var title = ""
    @State private var briefDescription = ""
    @State private var dateAdded = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateCompleted = Date.distantPast
    @State private var firstView = true
    
    
    var body: some View {
        Form {
            VStack{
                Section(header: Text("Project Details").font(.title3)) {
                
                        Picker("Status", selection: $status) {
                            ForEach(Status.allCases) { status in
                                Text(status.descr).tag(status)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle()) // This gives a more compact look
                }
                    Section{
                        datePickerView(for: "Added", date: $dateAdded)
                        if status != .planning {
                            datePickerView(for: "Started", date: $dateStarted, minDate: dateAdded)
                        }
                        if status == .completed {
                            datePickerView(for: "Completed", date: $dateCompleted, minDate: dateStarted)
                        }
                    }
                    
                    if status == .active || status == .completed {
                        LabeledContent {
                            DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                        } label: {
                            Text("Start Date")
                        }
                    }
                    if status == .hold || status == .planning {
                        LabeledContent {
                            DatePicker("", selection: $dateStarted, in: dateAdded..., displayedComponents: .date)
                        } label: {
                            Text("Start Date")
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
            .navigationTitle(title)
                .onChange(of: status) {  oldValue, newValue in
                    if !firstView {
                        if newValue == .hold {
                            dateStarted = Date.distantPast
                            dateCompleted = Date.distantFuture
                        }else if newValue == .planning {
                            dateStarted = Date.distantPast
                            dateCompleted = Date.distantFuture
                        }else if newValue == .completed && oldValue == .active {
                            // from completed to inProgress
                            dateCompleted = Date.distantPast
                        } else if newValue == .active && oldValue == .planning {
                            // Book has been started
                            dateStarted = Date.now
                            dateCompleted = Date.distantFuture
                        } else if newValue == .completed && oldValue == .planning {
                            // Forgot to start book
                            dateCompleted = Date.now
                            dateStarted = dateAdded
                        } else {
                            // completed
                            dateCompleted = Date.now
                        }
                        firstView = false
                    }
                }
                LabeledContent {
                            TextField("Enter Title", text: $title)
                        .textFieldStyle(.roundedBorder)
                        } label: {
                            Text("Title").foregroundStyle(.secondary).fontWeight(.bold).padding(.horizontal)
                        }
                        .padding(.horizontal)
            VStack{
                Text("Brief Description").foregroundStyle(.secondary).fontWeight(.bold)
                TextEditor( text: $briefDescription)
            }
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
                .padding()
                .textFieldStyle(.roundedBorder)
                .toolbar {
                    if changed {
                        Button("Save") {
                            project.status = status.rawValue
                            project.title = title
                            project.briefDescription = briefDescription
                            project.dateAdded = dateAdded
                            project.dateStarted = dateStarted
                            project.dateCompleted = dateCompleted
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
                }
                var changed: Bool {
                    status != Status(rawValue: project.status)!
                    || title != project.title
                    || briefDescription != project.briefDescription
                    || dateAdded != project.dateAdded
                    || dateStarted != project.dateStarted
                    || dateCompleted != project.dateCompleted
                }
           
            }
       
        }
    }

@ViewBuilder
func datePickerView(for label: String, date: Binding<Date>, minDate: Date = Date.distantPast) -> some View {
    LabeledContent {
        DatePicker("", selection: date, in: minDate..., displayedComponents: .date)
    } label: {
        Text("Date \(label)")
    }
}
