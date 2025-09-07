//
//  ItemView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 7/9/25.
//

import SwiftUI

struct ItemView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    let list: ListModel
    
    var body: some View {
        ZStack (alignment: .bottomTrailing) {
            ZStack {
                if let listIndex = listViewModel.lists.firstIndex(where: { $0.id == list.id }) {
                    if listViewModel.lists[listIndex].items.isEmpty {
                        NoItemsView(listId: list.id)
                    } else {
                        List {
                            ForEach(listViewModel.lists[listIndex].items) { item in
                                ItemRowView(listId: list.id, item: item)
                            }
                            .onDelete(perform: { indexSet in
                                listViewModel.deleteItem(fromList: list.id, at: indexSet)
                            })
                            .onMove(perform: { fromOffsets, toOffset in
                                listViewModel.moveItem(fromList: list.id, fromOffsets: fromOffsets, toOffset: toOffset)
                            })
                        }
                        .listStyle(.plain)
                    }
                } else {
                    Text("List not found.")
                }
            }
            NavigationLink(destination: AddItemView(listId: list.id)) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.accentColor)
                    .shadow(radius: 5)
            }
            .padding(20)
        }
        .navigationTitle(list.title)
        .navigationBarItems(
            trailing: EditButton()
        )
    }
}

#Preview {
    let mockListViewModel = ListViewModel()
    
    let mockList = ListModel(title: "My Mock ToDos", items: [
        ItemModel(title: "Finish SwiftUI Project", isCompleted: false),
        ItemModel(title: "Go for a walk", isCompleted: true),
        ItemModel(title: "Buy groceries", isCompleted: false)
    ])
    
    mockListViewModel.lists.append(mockList)
    
    return NavigationView {
        ItemView(list: mockList)
    }
    .environmentObject(mockListViewModel)
}

#Preview("Empty List") {
    let emptyListViewModel = ListViewModel()
    let emptyList = ListModel(title: "Empty ToDos", items: [])
    emptyListViewModel.lists.append(emptyList)
    
    return NavigationView {
        ItemView(list: emptyList)
    }
    .environmentObject(emptyListViewModel)
}

#Preview("List Not Found") {
    let mockListViewModel = ListViewModel()
    let nonExistentList = ListModel(title: "Non-Existent", items: [])
    
    return NavigationView {
        ItemView(list: nonExistentList)
    }
    .environmentObject(mockListViewModel)
}
