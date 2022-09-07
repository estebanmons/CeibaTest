//
//  UserPostsInteractor.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

final class UserPostsInteractor {
    
    var userPostsRepository: UserPostsRepository
    
    init(userPostsRepository: UserPostsRepository) {
        self.userPostsRepository = userPostsRepository
    }
}

// MARK: - Extensions -
extension UserPostsInteractor: UserPostsInteractorInterface {
    
    func getPosts(by userId: Int, completionHandler: @escaping (PostsResult) -> Void) {
        userPostsRepository.requestGetPosts(by: userId) { result in
            switch result {
            case .success(let posts):
                completionHandler(.success(posts))
            case .error:
                completionHandler(.error)
            }
        }
    }
}
