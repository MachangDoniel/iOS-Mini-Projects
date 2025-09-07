//
//  ItemRowView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 7/9/25.
//

import SwiftUI

struct ItemRowView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    let listId: String
    let item: ItemModel
    
    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
                .onTapGesture {
                    listViewModel.updateItem(inList: listId, item: item)
                }
            Text(item.title)
                .foregroundColor(.primary)
                .strikethrough(item.isCompleted, color: .primary)
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview("Completed Item") {
    let mockListViewModel = ListViewModel()
    let mockList = ListModel(title: "Mock List")
    mockListViewModel.lists.append(mockList)
    
    let completedItem = ItemModel(title: "Completed to-do item!", isCompleted: true)
    
    return ItemRowView(listId: mockList.id, item: completedItem)
        .environmentObject(mockListViewModel)
}

#Preview("Incomplete Item") {
    let mockListViewModel = ListViewModel()
    let mockList = ListModel(title: "Mock List")
    mockListViewModel.lists.append(mockList)
    
    let incompleteItem = ItemModel(title: "Incomplete to-do item.", isCompleted: false)
    
    return ItemRowView(listId: mockList.id, item: incompleteItem)
        .environmentObject(mockListViewModel)
}

//#Preview("Completed Item", traits: .sizeThatFitsLayout) {
//    let mockListViewModel = ListViewModel()
//    let mockList = ListModel(title: "Mock List")
//    mockListViewModel.lists.append(mockList)
//    
//    let completedItem = ItemModel(title: "Completed to-do item!", isCompleted: true)
//    
//    return ItemRowView(listId: mockList.id, item: completedItem)
//        .environmentObject(mockListViewModel)
//}
//
//#Preview("Incomplete Item", traits: .sizeThatFitsLayout) {
//    let mockListViewModel = ListViewModel()
//    let mockList = ListModel(title: "Mock List")
//    mockListViewModel.lists.append(mockList)
//    
//    let incompleteItem = ItemModel(title: "Incomplete to-do item.", isCompleted: false)
//    
//    return ItemRowView(listId: mockList.id, item: incompleteItem)
//        .environmentObject(mockListViewModel)
//}
