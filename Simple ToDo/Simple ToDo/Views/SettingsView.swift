//
//  SettingsView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 7/9/25.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section(header: Text("General")) {
                NavigationLink("Appearance") {
                    Text("Appearance Settings") // Placeholder for a future screen
                }
                Button("Select Language") {
                    // Action to change language
                }
            }
            
            Section(header: Text("Account")) {
                Button("Sign In / Sign Up") {
                    // Action for sign in
                }
                Button("Log Out") {
                    // Action for log out
                }
                Button("Delete Account") {
                    // Action for account deletion
                }
            }
            
            Section(header: Text("Support")) {
                Button("Rate Us") {
                    // Action to open App Store review page
                }
                Button("Send Feedback") {
                    // Action to open a feedback form
                }
                Button("Recommend to a Friend") {
                    // Action to open share sheet
                }
            }
            
            Section(header: Text("Legal")) {
                NavigationLink("Privacy Policy") {
                    Text("Privacy Policy Content")
                }
                NavigationLink("Terms & Conditions") {
                    Text("Terms & Conditions Content")
                }
            }
        }
        .navigationTitle("Settings")
        .listStyle(.grouped)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
        }
    }
}
