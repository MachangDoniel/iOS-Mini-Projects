//
//  ListRowView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 6/9/25.
//

import SwiftUI

struct ListRowView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    let list: ListModel

    var body: some View {
        HStack {
            Text(list.title)
                .fontWeight(.bold)
            Spacer()
//            Image(systemName: "chevron.right")
//                            .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview() {
    let mockList = ListModel(title: "My Shopping List", items: [])
    let mockListViewModel = ListViewModel()
    
    ListRowView(list: mockList)
        .environmentObject(mockListViewModel)
}

//#Preview(traits: .sizeThatFitsLayout) {
//    let mockList = ListModel(title: "My Shopping List", items: [])
//    let mockListViewModel = ListViewModel()
//    
//    ListRowView(list: mockList)
//        .environmentObject(mockListViewModel)
//}
