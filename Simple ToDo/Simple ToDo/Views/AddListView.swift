//
//  AddListView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 6/9/25.
//

import SwiftUI

struct AddListView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter a List Title", text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 50)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(10)
            
            Button(action: saveButtonPressed, label: {
                Text("Save List".uppercased())
                    .frame(height: 50)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            })
        }
        .padding(10)
        .navigationTitle("Add a New List 📝")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addList(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "List title must be at least 3 characters long😊"
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}


#Preview {
    NavigationView {
        AddListView()
    }
    .environmentObject(ListViewModel())
}
