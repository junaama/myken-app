//
//  UploadedImageView.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import SwiftUI

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
