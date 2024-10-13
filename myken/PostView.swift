//
//  PostView.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import SwiftUI

struct PostView: View {
    let post: Post
    @State private var showingPostDetail = false
    @State private var showingShoppingDetail = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            GeometryReader { geometry in
                Image(post.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width * 0.75, height: geometry.size.width * 0.75)
                    .clipShape(Rectangle())
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .aspectRatio(1, contentMode: .fit)
            
            HStack {
                Text(post.description)
                Spacer()
                HStack {
                    NavigationLink(destination: ShoppingDetailView(post: post), isActive: $showingShoppingDetail) {
                        Image(systemName: "bag")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        showingShoppingDetail = true
                    })
                    
                    NavigationLink(destination: PostDetailView(post: post), isActive: $showingPostDetail) {
                        Image(systemName: "bubble.left")
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        showingPostDetail = true
                    })
                }
            }
            .padding(.horizontal)
            
            Divider()
        }
    }
}
