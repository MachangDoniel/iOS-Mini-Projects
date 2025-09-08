//
//  ItemView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 7/9/25.
//

import SwiftUI

struct ItemView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var isEditingTitle = false
    @State private var newTitle: String
    @State private var isListEditing = false
    @State private var selectedItem: ItemModel?
    @State private var isDetailActive = false
    
    let list: ListModel
    
    init(list: ListModel) {
        self.list = list
        _newTitle = State(initialValue: list.title)
    }
    
    var body: some View {
        Group {
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
                    .environment(\.editMode, isListEditing ? .constant(.active) : .constant(.inactive))
                }
            } else {
                Text("List not found.")
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                if isEditingTitle {
                    TextField("Edit Title", text: $newTitle)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                } else {
                    Text(list.title)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditingTitle ? "Done" : "Edit") {
                    if isEditingTitle {
                        if !newTitle.isEmpty {
                            listViewModel.updateListTitle(id: list.id, newTitle: newTitle)
                        }
                    }
                    isEditingTitle.toggle()
                    isListEditing.toggle()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        
        .overlay(alignment: .bottomTrailing) {
            NavigationLink(destination: AddItemView(listId: list.id)) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.accentColor)
                    .shadow(radius: 5)
            }
            .padding(20)
        }
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
