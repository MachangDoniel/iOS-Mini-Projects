//
//  Untitled.swift
//  AyncAwaitSwiftUI
//
//  Created by Doniel Tripura on 10/3/25.
//

import Foundation
import Combine
import SwiftUI


@MainActor
final class UserListViewModel: ObservableObject {
    
    @Published var users: [UserModel] = []
    @Published var isLoading = false
    @Published var shouldShowError = false
    @Published var errorMessage: String?
    
    func getUserList() async {
        isLoading = true
        do {
            let users = try await WebService.getUsersData()
            print(users)
            self.users = users
            self.isLoading = false
        } catch(let error) {
            print(error.localizedDescription)
            self.isLoading = false
            self.shouldShowError = true
            self.errorMessage = error.localizedDescription
        }
    }
}
