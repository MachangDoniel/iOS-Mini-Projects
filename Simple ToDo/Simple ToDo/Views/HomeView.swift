//
//  HomeView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 7/9/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ListView()
                    .navigationTitle("Your Lists 📝")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Lists", systemImage: "list.bullet")
            }
            .tag(0)
            
            NavigationView {
//                TimeView()
            }
            .tabItem {
                Label("Time", systemImage: "clock")
            }
            .tag(1)
            
            NavigationView {
                SettingsView()
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape")
            }
            .tag(2)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ListViewModel())
    }
}
