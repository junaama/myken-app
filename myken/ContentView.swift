//
//  ContentView.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Text("My App")
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

struct Post: Identifiable {
    let id = UUID()
    let imageName: String
    let description: String
    let likes: Int
    let comments: Int
    let brandName: String
    let price: Double
    let buyLink: String
}

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
                    // Open external link
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
                
                // Placeholder for comments
                ForEach(0..<post.comments, id: \.self) { index in
                    Text("Comment \(index + 1)")
                        .padding(.horizontal)
                }
            }
        }
        .navigationTitle("Post Details")
    }
}

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

struct ContentView: View {
    let posts = [
        Post(imageName: "men1", description: "Cool summer look", likes: 100, comments: 25, brandName: "Summer Breeze", price: 79.99, buyLink: "https://example.com/buy1"),
        Post(imageName: "men2", description: "Casual office wear", likes: 85, comments: 12, brandName: "Office Chic", price: 129.99, buyLink: "https://example.com/buy2"),
        Post(imageName: "men3", description: "Weekend getaway outfit", likes: 120, comments: 30, brandName: "Wanderlust", price: 99.99, buyLink: "https://example.com/buy3"),
        // Add more posts as needed
    ]
    
    var body: some View {
        TabView {
            // Home tab
            NavigationView {
                VStack(spacing: 0) {
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(posts) { post in
                                PostView(post: post)
                            }
                        }
                    }
                }
                .navigationTitle("My App")
            }
            .tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            // First tab: Square pencil icon
            VStack(spacing: 0) {
                HeaderView()
                Text("Edit View")
                    .frame(maxHeight: .infinity)
            }
            .tabItem {
                Image(systemName: "square.and.pencil")
                Text("Edit")
            }
            
            // Third tab: Gear settings icon
            VStack(spacing: 0) {
                HeaderView()
                Text("Settings View")
                    .frame(maxHeight: .infinity)
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            }
        }
    }
}

#Preview {
    ContentView()
}
