//
//  PostDetailView.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import SwiftUI

struct PostDetailView: View {
    let post: Post
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Image(post.imageName)
                    .resizable()
                    .scaledToFit()
                
                Text(post.description)
                    .padding(.horizontal)
                
                HStack {
                    Text("\(post.likes) likes")
                    Text("•")
                    Text("\(post.comments) comments")
                }
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal)
                
                Divider()
                
                ForEach(0..<post.comments, id: \.self) { index in
                    Text("Comment \(index + 1)")
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Post Details")
    }
}
