//
//  UsersRepository.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

final class UsersRepository {
    
    // MARK: - Private properties -
    private lazy var apiManager = APIManager()
    
    func requestGetUsers(completionHandler: @escaping (UsersResult) -> Void) {
        apiManager.request(parameters: EmptyRequest(), endpoint: .getUsers) { (result: Result<[User]>) in
            switch result {
            case .success(let data):
                completionHandler(.success(data))
            case .error:
                completionHandler(.error)
            }
        }
    }
}
