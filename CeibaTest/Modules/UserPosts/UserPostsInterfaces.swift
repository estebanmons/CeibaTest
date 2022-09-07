//
//  UserPostsInterfaces.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

struct PostModel {
    let title: String
    let body: String
}

enum PostsResult {
    case success([Post])
    case error
}

protocol UserPostsWireframeInterface: WireframeInterface { }

protocol UserPostsViewInterface: ViewInterface {
    func setUserData(user: UserModel)
    func reloadData()
}

protocol UserPostsPresenterInterface: PresenterInterface {
    var numberOfPosts: Int { get }
    func getPostModel(at row: Int) -> PostModel
}

protocol UserPostsInteractorInterface: InteractorInterface {
    func getPosts(by userId: Int, completionHandler: @escaping (PostsResult) -> Void)
}
