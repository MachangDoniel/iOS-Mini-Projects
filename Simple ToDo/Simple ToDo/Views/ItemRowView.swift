//
//  ItemRowView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 7/9/25.
//

import SwiftUI

struct ItemRowView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @State private var navigateToDetail = false
    
    let listId: String
    let item: ItemModel
    
    static let dateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: ItemDetailView(item: item),
                isActive: $navigateToDetail,
                label: { EmptyView() }
            )
            .hidden()
            
            HStack {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(item.isCompleted ? .green : .red)
                    .onTapGesture {
                        listViewModel.updateItem(inList: listId, item: item)
                    }
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.title)
                        .strikethrough(item.isCompleted, color: .primary)
                    
                    HStack(spacing: 8) {
                        if let urgency = item.urgency {
                            if urgency != UrgencyLevel.none {
                                Text(urgency.rawValue.capitalized)
                                    .font(.caption)
                                    .foregroundColor(urgencyColor(for: urgency))
                                    .fontWeight(.semibold)
                            }
                        }
                        
                        if item.urgency != nil && item.urgency != UrgencyLevel.none && item.time != nil {
                            Text("•")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        if let time = item.time {
                            Text(time, formatter: Self.dateTimeFormatter)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(.leading, 8)
                
                Spacer()
            }
            .padding(.vertical, 8)
        }
        .onTapGesture(count: 2) {
            navigateToDetail = true
        }
    }
}

func urgencyColor(for level: UrgencyLevel) -> Color {
    switch level {
    case .high:
        return .red
    case .medium:
        return .orange
    case .low:
        return .blue
    case .none:
        return .secondary
    }
}

#Preview("Item with All Details") {
    let mockListViewModel = ListViewModel()
    let mockList = ListModel(title: "Mock List")
    mockListViewModel.lists.append(mockList)

    let allDetailsItem = ItemModel(title: "Task with all details.", isCompleted: false, urgency: .high, time: Date())

    return ItemRowView(listId: mockList.id, item: allDetailsItem)
        .environmentObject(mockListViewModel)
}

#Preview("Item with Only Title") {
    let mockListViewModel = ListViewModel()
    let mockList = ListModel(title: "Mock List")
    mockListViewModel.lists.append(mockList)

    let titleOnlyItem = ItemModel(title: "A simple task.", isCompleted: false, urgency: nil, time: nil)

    return ItemRowView(listId: mockList.id, item: titleOnlyItem)
        .environmentObject(mockListViewModel)
}

#Preview("Item with Title & Time") {
    let mockListViewModel = ListViewModel()
    let mockList = ListModel(title: "Mock List")
    mockListViewModel.lists.append(mockList)

    let timeItem = ItemModel(title: "Go to the gym.", isCompleted: false, urgency: nil, time: Date(timeIntervalSinceNow: 3600))

    return ItemRowView(listId: mockList.id, item: timeItem)
        .environmentObject(mockListViewModel)
}

#Preview("Item with Title & Urgency") {
    let mockListViewModel = ListViewModel()
    let mockList = ListModel(title: "Mock List")
    mockListViewModel.lists.append(mockList)

    let urgencyItem = ItemModel(title: "Submit a report.", isCompleted: false, urgency: .high, time: nil)

    return ItemRowView(listId: mockList.id, item: urgencyItem)
        .environmentObject(mockListViewModel)
}
