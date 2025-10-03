//
//  LinkListView.swift
//  AyncAwaitSwiftUI
//
//  Created by Doniel Tripura on 10/3/25.
//

import SwiftUI

struct LinkListView: View {
    let title: String
    let url: String
    
    var body: some View {
        VStack {
            Text("\(title) Page")
                .font(.largeTitle)
                .padding()
            
            Text("API Endpoint:")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            NavigationLink {
                if let link = URL(string: url) {
                    WebView(url: link)
                        .navigationTitle(title)
                        .navigationBarTitleDisplayMode(.inline)
                } else {
                    Text("Invalid URL")
                }
            } label: {
                Text(url)
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .padding(.top, 4)
            }
            
            Spacer()
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
