//
//  ApparelSelectionView.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import SwiftUI

import SwiftUI

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
