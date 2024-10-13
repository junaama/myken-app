//
//  HeaderView.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("MyKen")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue)
        .foregroundColor(.white)
    }
}
#Preview {
    HeaderView()
}
