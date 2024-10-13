//
//  ShoppingDetailView.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import SwiftUI

import SwiftUI

struct ShoppingDetailView: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Image(post.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                
                Text(post.brandName)
                    .font(.title2)
                    .fontWeight(.bold)
                
                Text("$\(post.price, specifier: "%.2f")")
                    .font(.title3)
                    .foregroundColor(.green)
                
                Button(action: {
                    if let url = URL(string: post.buyLink) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Buy Now")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationTitle("Shop This Look")
    }
}
