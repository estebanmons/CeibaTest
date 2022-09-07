//
//  UserPostsRepository.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

final class UserPostsRepository {
    
    // MARK: - Private properties -
    private lazy var apiManager = APIManager()
    
    func requestGetPosts(by userId: Int, completionHandler: @escaping (PostsResult) -> Void) {
        apiManager.request(parameters: EmptyRequest(), endpoint: .getUserPosts(id: userId)) { (result: Result<[Post]>) in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .error:
                completionHandler(.error)
            }
        }
    }
}
