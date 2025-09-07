//
//  NoItemsView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 7/9/25.
//

import SwiftUI

struct NoItemsView: View {
    let listId: String?
    var secondaryAccentColor = Color("SecondaryAccentColor")
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("No \(listId != nil ? "Items" : "Lists") Yet!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text(listId != nil ? "Be more productive and add some todos! 🥳" : "Start by creating a new list!")
                    .font(.headline)
                Text(listId != nil ? "Are you a productive person? I think you should click the add button and add a bunch of items to your todo list!" : "I think you should click the add button to create your first list!")
                    .font(.footnote)
                    .padding(.bottom, 20)
                
                if let id = listId {
                    NavigationLink(
                        destination: AddItemView(listId: id),
                        label: {
                            Text("Add Items😎")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(animate ? secondaryAccentColor : .accentColor)
                                .cornerRadius(10)
                        })
                } else {
                    NavigationLink(
                        destination: AddListView(),
                        label: {
                            Text("Add List😎")
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(animate ? secondaryAccentColor : .accentColor)
                                .cornerRadius(10)
                        })
                }
            }
            .multilineTextAlignment(.center)
            .padding(40)
            .onAppear(perform: addAnimation)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func addAnimation () {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
}

#Preview("No Lists") {
    NavigationView {
        NoItemsView(listId: nil)
            .navigationTitle("My Lists")
    }
    .environmentObject(ListViewModel())
}


#Preview("No Items in List") {
    NavigationView {
        NoItemsView(listId: "1234")
            .navigationTitle("Groceries")
    }
    .environmentObject(ListViewModel())
}
