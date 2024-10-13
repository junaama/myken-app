//
//  Models.swift
//  myken
//
//  Created by macbook on 10/12/24.
//

import Foundation
import SwiftUI

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

struct User: Identifiable {
    let id = UUID()
    let username: String
    let fullName: String
    let profileImageName: String
}

struct ApparelItem: Identifiable {
    let id = UUID()
    let name: String
    let category: String
    let imageName: String
}
