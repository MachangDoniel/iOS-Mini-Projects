//
//  AddItemView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 7/9/25.
//

import SwiftUI

struct AddItemView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    let listId: String
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter an Item Title", text: $textFieldText)
                .padding(.horizontal)
                .frame(height: 50)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(10)
            
            Button(action: saveButtonPressed, label: {
                Text("Save Item".uppercased())
                    .frame(height: 50)
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .background(Color.accentColor)
                    .cornerRadius(10)
            })
        }
        .padding(10)
        .navigationTitle("Add an Item 🖋️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if textIsAppropriate() {
            listViewModel.addItem(toList: listId, title: textFieldText)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    func textIsAppropriate() -> Bool {
        if textFieldText.count < 3 {
            alertTitle = "ToDo item must be at least 3 characters long😊"
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
    let mockListViewModel = ListViewModel()
    let mockList = ListModel(title: "Mock List")
    mockListViewModel.lists.append(mockList)
    
    return NavigationView {
        AddItemView(listId: mockList.id)
    }
    .environmentObject(ListViewModel())
}
