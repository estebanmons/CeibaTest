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
    
    private func requestServiceGetUsers(completionHandler: @escaping (UsersResult) -> Void) {
        self.usersRepository.requestGetUsers { [unowned self] result in
            switch result {
            case .success(let data):
                var users = [UserModel]()
                data.forEach { user in
                    users.append(UserModel(email: user.email, id: user.id, name: user.name, phone: user.phone))
                }
                self.coreDataManager.saveData(users: users) { success in
                    completionHandler(.success(users))
                }
            case .error:
                completionHandler(.error)
            }
        }
    }
}

// MARK: - Extensions -
extension UsersInteractor: UsersInteractorInterface {
    
    var coreDataManager: CoreDataManager { CoreDataManager.sharedInstance }
    
    func requestGetUsers(refreshData: Bool, completionHandler: @escaping (UsersResult) -> Void) {
        
        if refreshData {
            requestServiceGetUsers { result in
                switch result {
                case .success(let users):
                    completionHandler(.success(users))
                case .error:
                    completionHandler(.error)
                }
            }
        } else {
            coreDataManager.getStoredData { [unowned self] result in
                switch result {
                case .success(let users):
                    completionHandler(.success(users))
                case .error:
                    self.requestServiceGetUsers { result in
                        switch result {
                        case .success(let users):
                            completionHandler(.success(users))
                        case .error:
                            completionHandler(.error)
                        }
                    }
                }
            }
        }
    }
}
