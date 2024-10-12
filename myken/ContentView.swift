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

struct User: Identifiable {
    let id = UUID()
    let username: String
    let fullName: String
    let profileImageName: String
}

struct UserRowView: View {
    let user: User
    let isSelected: Bool
    
    var body: some View {
        HStack {
            Image(user.profileImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.headline)
                Text(user.fullName)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(isSelected ? Color.black : Color.clear, lineWidth: 2)
        )
    }
}

struct ApparelItem: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let imageName: String
}

struct ApparelSelectionView: View {
    let image: UIImage
    let selectedUsername: String
    @State private var searchText = ""
    @State private var selectedApparel: ApparelItem?
    
    let apparelItems = [
        ApparelItem(name: "T-Shirt", category: "Tops", imageName: "tshirt"),
        ApparelItem(name: "Jeans", category: "Bottoms", imageName: "jeans"),
        ApparelItem(name: "Sweater", category: "Tops", imageName: "sweater"),
        ApparelItem(name: "Skirt", category: "Bottoms", imageName: "skirt"),
        ApparelItem(name: "Dress", category: "Tops", imageName: "dress"),
        // Add more apparel items as needed
    ]
    
    var filteredItems: [ApparelItem] {
        if searchText.isEmpty {
            return apparelItems
        } else {
            return apparelItems.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            TextField("Search apparel", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            List(filteredItems) { item in
                HStack {
                    Image(item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text(item.name)
                        Text(item.category)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    if selectedApparel?.id == item.id {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .onTapGesture {
                    selectedApparel = item
                }
            }
            
            NavigationLink(
                destination: UploadedImageView(image: image, selectedUsername: selectedUsername, apparelItem: selectedApparel),
                isActive: .constant(selectedApparel != nil)
            ) {
                EmptyView()
            }
        }
        .navigationTitle("Select Apparel")
    }
}

struct UploadedImageView: View {
    let image: UIImage
    let selectedUsername: String
    let apparelItem: ApparelItem?
    
    @State private var description: String = ""
    @State private var isPrivate: Bool = false
    @State private var showingShareConfirmation = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                Text("Uploaded by: \(selectedUsername)")
                    .font(.title2)
                
                if let apparelItem = apparelItem {
                    Text("Selected Apparel: \(apparelItem.name) (\(apparelItem.category))")
                        .font(.headline)
                }
                
                TextField("Add a description...", text: $description)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Toggle("Make post private", isOn: $isPrivate)
                    .padding(.horizontal)
                
                Spacer()
                
                Button(action: {
                    showingShareConfirmation = true
                }) {
                    Text("Share")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
        .navigationTitle("Uploaded Image")
        .alert(isPresented: $showingShareConfirmation) {
            Alert(
                title: Text("Confirm Share"),
                message: Text("Are you sure you want to share this post?"),
                primaryButton: .default(Text("Yes")) {
                    // Add sharing logic here
                    print("Sharing post...")
                    print("Description: \(description)")
                    print("Is Private: \(isPrivate)")
                    print("Apparel: \(apparelItem?.name ?? "None")")
                },
                secondaryButton: .cancel()
            )
        }
    }
}

struct EditView: View {
    let users = [
        User(username: "john_doe", fullName: "John Doe", profileImageName: "profile1"),
        User(username: "jane_smith", fullName: "Jane Smith", profileImageName: "profile2"),
        User(username: "bob_johnson", fullName: "Bob Johnson", profileImageName: "profile3"),
        // Add more users as needed
    ]
    
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingUploadedImage = false
    @State private var selectedUser: User?
    
    var body: some View {
        VStack {
            // User list in the top half
            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(users) { user in
                        UserRowView(user: user, isSelected: user.id == selectedUser?.id)
                            .onTapGesture {
                                selectedUser = user
                            }
                    }
                }
                .padding(.vertical)
            }
            .frame(height: UIScreen.main.bounds.height * 0.4)
            
            Spacer()
            
            // Image upload button in the bottom half
            Button(action: {
                showingImagePicker = true
            }) {
                Text("Upload Image from Gallery")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            if let selectedImage = selectedImage {
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                
                NavigationLink(
                    destination: ApparelSelectionView(image: selectedImage, selectedUsername: selectedUser?.username ?? "Unknown"),
                    isActive: $showingUploadedImage
                ) {
                    Button(action: {
                        showingUploadedImage = true
                    }) {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding()
                    .disabled(selectedUser == nil)
                }
            }
        }
        .navigationTitle("Edit")
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $selectedImage)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            parent.presentationMode.wrappedValue.dismiss()
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
            
            // Edit tab
            NavigationView {
                EditView()
            }
            .tabItem {
                Image(systemName: "square.and.pencil")
                Text("Edit")
            }
            
            // Settings tab
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