//
//  HomeView.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import SwiftUI

struct HomeView: View {
    let posts: [Post]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(posts) { post in
                    PostView(post: post)
                }
            }
        }
        .navigationTitle("MYKEN")
    }
}
