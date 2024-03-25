//
//  ButterflyMovieApp.swift
//  ButterflyMovie
//
//  Created by Amrit Tiwari on 25/3/2024.
//

import SwiftUI

@main
struct ButterflyMovieApp: App {
//    let persistenceController = PersistenceController.shared

    
    var body: some Scene {
        WindowGroup {
            
            TabView() {
                MovieSearchView()
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                }
                .tag(0)
            }
            .accentColor(.red)
            
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
