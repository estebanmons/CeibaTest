//
//  Post.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

// MARK: - Post
struct Post: Codable {
    let body: String
    let id: Int
    let title: String
    let userId: Int

    enum CodingKeys: String, CodingKey {
        case body
        case id
        case title
        case userId
    }
}
