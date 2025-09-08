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
            let totalItemCount = list.items.count
            let completedItemCount = list.items.filter({ $0.isCompleted }).count
            let progress: Double = totalItemCount > 0 ? Double(completedItemCount) / Double(totalItemCount) : 0.0
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    .frame(width: 40, height: 40)
                Circle()
                    .trim(from: 0.0, to: CGFloat(progress))
                    .stroke(completedItemCount == totalItemCount && totalItemCount > 0 ? Color.green : Color.accentColor,
                            style: StrokeStyle(lineWidth: 1, lineCap: .square)
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: 40, height: 40)
                
                Text("\(completedItemCount)/\(totalItemCount)")
                    .font(.caption)
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
            }
            .animation(.easeOut, value: progress)
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
