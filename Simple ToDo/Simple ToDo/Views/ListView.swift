//
//  ListView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 6/9/25.
//

import SwiftUI

struct ListView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            if listViewModel.lists.isEmpty {
                NoListsView()
            } else {
                List {
                    ForEach(listViewModel.lists) { list in
                        NavigationLink(destination: ItemView(list: list)) {
                            ListRowView(list: list)
                        }
                    }
                    .onDelete(perform: listViewModel.deleteList)
                    .onMove(perform: listViewModel.moveList)
                }
                .listStyle(.plain)
            }
            NavigationLink(destination: AddListView()) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.accentColor)
                    .shadow(radius: 5)
            }
            .padding(20)
        }
        .transition(AnyTransition.opacity.animation(.easeIn))
        .navigationTitle("My Lists 📝")
        .navigationBarItems(
            trailing: EditButton()
        )
//        .navigationBarItems(trailing: NavigationLink(destination: SettingsView()) {
//            Image(systemName: "gearshape")
//                .font(.title2)
//                .foregroundColor(.accentColor)
//        })
    }
}

//struct NoListsView: View {
//    var body: some View {
//        Text("No lists yet!\nTap the + button to add your first one.")
//            .font(.title2)
//            .foregroundColor(.secondary)
//            .multilineTextAlignment(.center)
//            .padding(50)
//    }
//}

#Preview {
    return NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel())
}


