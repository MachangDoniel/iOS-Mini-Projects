//
//  UserListView.swift
//  AyncAwaitSwiftUI
//
//  Created by Doniel Tripura on 10/3/25.
//

import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white.ignoresSafeArea()
                
                List(viewModel.users, id: \.id) { user in
                        
                    NavigationLink {
                        UserDetailView(user: user)
                    } label: {
                        HStack {
                            AsyncImage(url: URL(string: user.avatarURL ?? "")) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .clipShape(Circle())
                            } placeholder: {
                                Circle()
                                    .foregroundColor(.teal)
                            }
                            .frame(width: 50, height: 50)
                            
                            VStack(alignment: .leading) {
                                Text(user.login?.capitalized ?? "")
                                    .font(Font.headline)
                                Text(user.url ?? "")
                                    .font(Font.subheadline)
                            }
                        }
                    }
                }
                .navigationTitle("Users")
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.0, anchor: .center)
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                }
            }
                
        }
        .task {
            await viewModel.getUserList()
        }
        .alert(isPresented: $viewModel.shouldShowError) {
            return Alert(
                title: Text("Error!"),
                message: Text(viewModel.errorMessage ?? "Unknown Error")
            )
        }
    }
}

#Preview {
    UserListView()
}
