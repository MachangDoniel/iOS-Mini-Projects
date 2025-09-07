//
//  ListViewModel.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 7/9/25.
//

import Foundation

/*
CRUD Operations are implemented here
*/

class ListViewModel: ObservableObject {
    @Published var lists: [ListModel] = [] {
        didSet {
            saveLists()
        }
    }
    let listsKey = "lists_key"
    init() {
        getLists()
    }
    
    func getLists() {
        guard
            let data = UserDefaults.standard.data(forKey: listsKey),
            let savedLists = try? JSONDecoder().decode([ListModel].self, from: data)
         else { return }
        
        self.lists = savedLists
    }
    
    func addList(title: String) {
        let newList = ListModel(title: title)
        lists.append(newList)
    }
    
    func deleteList(at indexSet: IndexSet) {
        lists.remove(atOffsets: indexSet)
    }
    
    func moveList(fromOffsets: IndexSet, toOffset: Int) {
        lists.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func addItem(toList listId: String, title: String) {
        guard let index = lists.firstIndex(where: { $0.id == listId}) else { return }
        let newItem = ItemModel(title: title, isCompleted: false)
        lists[index].items.append(newItem)
    }
    
    func deleteItem(fromList listId: String, at indexSet: IndexSet) {
        guard let index = lists.firstIndex(where: { $0.id == listId }) else { return }
        lists[index].items.remove(atOffsets: indexSet)
    }
    
    func moveItem(fromList listId: String, fromOffsets: IndexSet, toOffset: Int) {
        guard let index = lists.firstIndex(where: { $0.id == listId }) else { return }
        lists[index].items.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func updateItem(inList listId: String, item: ItemModel) {
        if let listIndex = lists.firstIndex(where: { $0.id == listId}),
           let itemIndex = lists[listIndex].items.firstIndex(where: {$0.id == item.id}) {
            lists[listIndex].items[itemIndex] = item.updateCompletion()
        }
    }
    
    func saveLists() {
        if let encodedData = try? JSONEncoder().encode(lists) {
            UserDefaults.standard.set(encodedData, forKey: listsKey)
        }
    }
}
