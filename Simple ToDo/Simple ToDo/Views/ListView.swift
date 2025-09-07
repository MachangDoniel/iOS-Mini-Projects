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
        ZStack {
            if listViewModel.lists.isEmpty {
                NoItemsView(listId: nil)
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
        }
        .transition(AnyTransition.opacity.animation(.easeIn))
        .navigationTitle("My Lists 📝")
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: AddListView())
        )
    }
}

#Preview {
    return NavigationView {
        ListView()
    }
    .environmentObject(ListViewModel())
}


