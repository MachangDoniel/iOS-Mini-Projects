//
//  InfoView.swift
//  DonielCard
//
//  Created by Doniel Tripura on 26/7/25.
//

import SwiftUI

struct InfoView: View {
    let text: String
    let image: String
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.white)
            .frame(height: 50.0)
            .overlay(
                HStack {
                    Image(systemName: image)
                        .foregroundColor(.green)
                    Text(text)
                }
            )
            .padding(.all)
    }
}


struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(text: "+880 1893-097217", image: "phone.fill")
            .previewLayout(.sizeThatFits)
    }
}

