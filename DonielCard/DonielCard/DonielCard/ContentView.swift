//
//  ContentView.swift
//  DonielCard
//
//  Created by Doniel Tripura on 26/7/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(UIColor(red: 0.15, green: 0.68, blue: 0.38, alpha: 1.00))
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("doniel")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(.circle)
                    .overlay(
                        Circle()
                            .stroke(Color(.white), lineWidth: 5)
                    )
                Text("Doniel Tripura")
                    .font(Font.custom("Pacifico-Regular", fixedSize: 40))
                    .bold()
                    .foregroundColor(.white)
                Text("iOS Developer")
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                Divider()
                InfoView(text: "+880 1893-097217", image: "phone.fill")
                InfoView(text: "donieltripura121@gmail.com", image: "envelope.fill")
            }
        }
        
    }
    
}

#Preview {
    ContentView()
}

