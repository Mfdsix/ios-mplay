//
//  ContentView.swift
//  MPlay
//
//  Created by maputh on 20/02/25.
//

import SwiftUI

struct ContentView: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.black
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView {
            GameListView()
                .tabItem {
                    Label("Games", systemImage: "gamecontroller.fill")
                }
            
            FavoriteListView()
                .tabItem {
                    Label("Favorite", systemImage: "heart.fill")
                }
        }
        .accentColor(.orange)
        
    }
}
