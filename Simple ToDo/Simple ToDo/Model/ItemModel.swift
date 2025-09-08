//
//  ItemModel.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 6/9/25.
//

import Foundation

enum UrgencyLevel: String, Codable, CaseIterable {
    case none
    case low
    case medium
    case high
    
    var capitalizedString: String {
        return self.rawValue.capitalized
    }
}

// Immutable Struct
struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    let urgency: UrgencyLevel?
    let time: Date?
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, urgency: UrgencyLevel? = nil, time: Date? = nil) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.urgency = urgency ?? UrgencyLevel.none
        self.time = time
    }
    
    func updateCompletion() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, urgency: urgency, time: time)
    }
}
