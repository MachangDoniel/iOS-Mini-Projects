//
//  ListRowView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 6/9/25.
//

import SwiftUI

struct ListRowView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    let item: ItemModel

    var body: some View {
        HStack {
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundStyle(item.isCompleted ? .green : .red)
                .onTapGesture {
                    withAnimation(.linear) {
                        listViewModel.updateItem(item: item)
                    }
                }
            Text(item.title)
            Spacer()
        }
        .padding(.vertical, 5)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}



//#Preview(traits: .sizeThatFitsLayout) {
//    var item1 = ItemModel(title: "First Item", isCompleted: true)
//    var item2 = ItemModel(title: "Second Item", isCompleted: false)
//
//    ListRowView(item: item1)
//    Divider()
//    ListRowView(item: item2)
//}
//
//#Preview("Completed", traits: .sizeThatFitsLayout) {
//    var item1 = ItemModel(title: "First Item", isCompleted: true)
//    Group {
//        ListRowView(item: item1)
//    }
//}
//
//#Preview("Not Completed", traits: .sizeThatFitsLayout) {
//    var item2 = ItemModel(title: "Second Item", isCompleted: false)
//    Group {
//        ListRowView(item: item2)
//    }
//}
