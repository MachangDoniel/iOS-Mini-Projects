//
//  SelectedItemView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 8/9/25.
//

import SwiftUI

struct ItemDetailView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    @Environment(\.dismiss) var dismiss

    @State private var isEditing = false

    let item: ItemModel

    @State private var title: String
    @State private var isCompleted: Bool
    @State private var urgency: UrgencyLevel
    @State private var time: Date?

    init(item: ItemModel) {
        self.item = item
        _title = State(initialValue: item.title)
        _isCompleted = State(initialValue: item.isCompleted)
        _urgency = State(initialValue: item.urgency ?? UrgencyLevel.none)
        _time = State(initialValue: item.time)
    }

    var body: some View {
        Form {
            Section(header: Text("Task")) {
                if isEditing {
                    TextField("Title", text: $title)
                } else {
                    HStack {
                        Text("Title")
                        Spacer()
                        Text(title)
                            .foregroundColor(.secondary)
                    }
                }

                Toggle("Completed", isOn: $isCompleted)
                    .disabled(!isEditing)
            }

            Section(header: Text("Urgency")) {
                if isEditing {
                    Picker("Urgency", selection: $urgency) {
                        ForEach(UrgencyLevel.allCases, id: \.self) { level in
                            Text(level.rawValue.capitalized).tag(Optional(level))
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                } else {
                    HStack {
                        Text("Urgency")
                        Spacer()
                        Text(urgency.rawValue.capitalized)
                            .foregroundColor(urgencyColor(for: urgency))
                    }
                }
            }

            Section(header: Text("Due Date")) {
                if isEditing {
                    HStack {
                        DatePicker("Due", selection: Binding(
                            get: { time ?? Date() },
                            set: { time = $0 }
                        ), displayedComponents: [.date, .hourAndMinute])
                        .foregroundColor(.primary.opacity((time != nil) ? 1.0 : 0.2))

                        if time != nil {
                            Button(action: {
                                time = nil
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                } else {
                    HStack {
                        Text("Due")
                        Spacer()
                        Text(time != nil ? time!.formatted(date: .abbreviated, time: .shortened) : "None")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .navigationTitle(isEditing ? "Edit Task" : "Task Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isEditing ? "Save" : "Edit") {
                    if isEditing {
                        let updatedItem = ItemModel(
                            id: item.id,
                            title: title,
                            isCompleted: isCompleted,
                            urgency: urgency,
                            time: time
                        )
                        listViewModel.updateItemManually(updatedItem)
                    }
                    isEditing.toggle()
                }
            }
        }
    }
}



#Preview {
    let viewModel = ListViewModel()
    let mockItem = ItemModel(title: "Mock Task", isCompleted: false, urgency: .medium, time: Date())

    let mockList = ListModel(title: "Mock List", items: [mockItem])
    viewModel.lists.append(mockList)

    return NavigationView {
        ItemDetailView(item: mockItem)
            .environmentObject(viewModel)
    }
}

