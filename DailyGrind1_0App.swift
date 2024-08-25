//
//  DailyGrind1_0App.swift
//  DailyGrind1.0
//
//  Created by Joseph DeWeese on 8/20/24.
//

import SwiftUI
import SwiftData

@main
struct DailyGrind1_0App: App {
    let container: ModelContainer
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(container)
    }
    
    init() {
        let schema = Schema([Project.self])
        let config = ModelConfiguration("DailyGrind", schema: schema)
        do {
            container = try ModelContainer(for: schema, configurations: config)
        } catch {
            fatalError("Could not configure the container")
        }
//        let config = ModelConfiguration(url: URL.documentsDirectory.appending(path: "MyBooks.store"))
//        do {
//            container = try ModelContainer(for: Book.self, configurations: config)
//        } catch {
//            fatalError("Could not configure the container")
//        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
//        print(URL.documentsDirectory.path())
    }
}
