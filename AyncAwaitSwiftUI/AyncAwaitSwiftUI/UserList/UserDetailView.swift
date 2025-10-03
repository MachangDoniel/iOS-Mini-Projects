//
//  UserDetailView.swift
//  AyncAwaitSwiftUI
//
//  Created by Doniel Tripura on 10/3/25.
//


import SwiftUI

struct UserDetailView: View {
    let user: UserModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Avatar
                AsyncImage(url: URL(string: user.avatarURL ?? "")) { image in
                    image.resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 2))
                } placeholder: {
                    Circle().foregroundColor(.teal)
                }
                .frame(width: 120, height: 120)
                .padding(.top, 20)
                
                // Basic Info
                VStack(spacing: 5) {
                    Text(user.login ?? "Unknown")
                        .font(.title)
                        .bold()
                    
                    Text(user.type?.rawValue ?? "")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Divider()
                
                // Links Section
                VStack(alignment: .leading, spacing: 15) {
                    Text("Links")
                        .font(.headline)
                    
                    if let url = user.htmlURL {
                        NavigationLink("Profile", destination: LinkListView(title: "Profile", url: url))
                    }
                    if let url = user.reposURL {
                        NavigationLink("Repositories", destination: LinkListView(title: "Repositories", url: url))
                    }
                    if let url = user.followersURL {
                        NavigationLink("Followers", destination: LinkListView(title: "Followers", url: url))
                    }
                    if let url = user.followingURL {
                        NavigationLink("Following", destination: LinkListView(title: "Following", url: url))
                    }
                    if let url = user.gistsURL {
                        NavigationLink("Gists", destination: LinkListView(title: "Gists", url: url))
                    }
                    if let url = user.starredURL {
                        NavigationLink("Starred", destination: LinkListView(title: "Starred", url: url))
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
        }
        .navigationTitle(user.login ?? "User")
        .navigationBarTitleDisplayMode(.inline)
    }
}
