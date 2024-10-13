//
//  UserRowView.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import SwiftUI

import SwiftUI

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
