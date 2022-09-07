//
//  EndPoint.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

enum EndPoint {
    case getUsers
    case getUserPosts(id: Int)
    
    var path: String {
        switch self {
        case .getUsers:
            return baseURL + "users"
        case .getUserPosts(let id):
            return baseURL + "posts?userId=\(id)"
        }
    }
    
    var baseURL: String {
        return "https://jsonplaceholder.typicode.com/"
    }
}
