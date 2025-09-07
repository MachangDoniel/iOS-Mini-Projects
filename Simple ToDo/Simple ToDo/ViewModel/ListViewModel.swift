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
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItem()
        }
    }
    let itemsKey = "items_key"
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
         else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(fromOffsets: IndexSet, toOffset: Int) {
        items.move(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
//        if let index = items.firstIndex { (existingItem) in
//            return existingItem.id == item.id
//        } {
//            // run this code
//        }
        
//        if let index = items.firstIndex(where: {$0.id == item.id}) {
//            items[index] = ItemModel(title: item.title, isCompleted: !item.isCompleted)
//        }
        
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItem() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
