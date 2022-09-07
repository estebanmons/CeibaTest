//
//  UsersInteractor.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

final class UsersInteractor {
    
    var usersRepository: UsersRepository
    
    init(usersRepository: UsersRepository) {
        self.usersRepository = usersRepository
    }
}

// MARK: - Extensions -
extension UsersInteractor: UsersInteractorInterface {
    
    func requestGetUsers(completionHandler: @escaping (UsersResult) -> Void) {
        usersRepository.requestGetUsers { result in
            switch result {
            case .success(let users):
                completionHandler(.success(users))
            case .error:
                completionHandler(.error)
            }
        }
    }
}
