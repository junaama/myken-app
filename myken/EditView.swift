//
//  EditView.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import SwiftUI

import SwiftUI

struct EditView: View {
    let users = [
        User(username: "john_doe", fullName: "John Doe", profileImageName: "profile1"),
        User(username: "jane_smith", fullName: "Jane Smith", profileImageName: "profile2"),
        User(username: "bob_johnson", fullName: "Bob Johnson", profileImageName: "profile3"),
    ]
    
    @State private var selectedImage: UIImage?
    @State private var showingImagePicker = false
    @State private var showingUploadedImage = false
    @State private var selectedUser: User?
    
    var body: some View {
        VStack {
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

#Preview {
    EditView()
}
