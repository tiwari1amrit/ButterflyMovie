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
    
    @State private var tabSelection = 0
    
    var body: some Scene {
        WindowGroup {
            
            TabView(selection: $tabSelection) {
                MovieSearchView()
                    .tabItem {
                        VStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    }
                    .tag(0)
                
                MovieFavoriteView(tabSelection: $tabSelection)
                    .tabItem {
                        VStack {
                            Image(systemName: "star")
                            Text("Favorite")
                        }
                    }
                    .tag(1)
            }
            .accentColor(.red)
            
            //                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
