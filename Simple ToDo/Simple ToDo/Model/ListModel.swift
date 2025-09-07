//
//  ListModel.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 7/9/25.
//

import Foundation

struct ListModel: Identifiable, Codable {
    let id: String
    let title: String
    var items: [ItemModel]
    
    init(id: String = UUID().uuidString, title: String, items: [ItemModel] = []) {
        self.id = id
        self.title = title
        self.items = items
    }
}
