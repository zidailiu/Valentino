//
//  VLModels.swift
//  Valentino
//
//  Created by Liu John on 2022-03-17.
//

import Foundation

enum Gender {
    case male, female, other
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCount
}

struct UserCount {
    let followers: Int
    let following: Int
}


struct FeedCellModel {
    let username: String
    let userID: String
    let userPhotoURL: URL
    let gender: Gender
    let birthDate: Date
    let description: String
}

