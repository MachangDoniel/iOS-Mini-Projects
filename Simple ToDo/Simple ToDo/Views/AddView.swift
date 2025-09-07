//
//  AddView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 6/9/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                TextField("Enter an Item", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(.black.opacity(0.1))
                    .cornerRadius(10)
                
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .frame(height: 50)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                        .background(.accent)
                        .cornerRadius(10)
                })
                
            }
            .navigationTitle("Add an Item 🖋️")
            .alert(isPresented: $showAlert, content: getAlert)
        }
        .padding(10)
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        } else {
            
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "ToDo Item must be at least 3 characters long😊"
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
        AddView()
    }
    .environmentObject(ListViewModel())
}
