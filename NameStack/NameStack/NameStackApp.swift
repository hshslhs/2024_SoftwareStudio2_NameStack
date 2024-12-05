//
//  NameStackApp.swift
//  NameStack
//
//  Created by 김세연 on 11/21/24.
//

import SwiftUI
import SwiftData


@main
struct NameStackApp: App {
    var nameStackModelContainer: ModelContainer = {
        let schema = Schema([Card.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false) //개발 과정에서는 isStoredInMemoryOnly를 true로
        do {
          return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
          fatalError("Could not create ModelContainer: \(error)")
        }
      }()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(nameStackModelContainer)
    }
}
