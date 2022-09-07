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
}
