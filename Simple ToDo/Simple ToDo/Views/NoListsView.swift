//
//  NoListsView.swift
//  Simple ToDo
//
//  Created by Doniel Tripura on 8/9/25.
//

import SwiftUI

struct NoListsView: View {
    var secondaryAccentColor = Color("SecondaryAccentColor")
    @State var animate: Bool = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                Text("No Lists Yet!")
                    .font(.title)
                    .fontWeight(.semibold)
                Text("Start by creating a new list!")
                    .font(.headline)
                Text("I think you should click the add button to create your first list!")
                    .font(.footnote)
                    .padding(.bottom, 20)
                
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
        NoListsView()
            .navigationTitle("My Lists")
    }
    .environmentObject(ListViewModel())
}
