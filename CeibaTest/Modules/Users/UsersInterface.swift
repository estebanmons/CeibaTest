//
//  UsersInterface.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

struct UserModel {
    let email: String
    let id: Int
    let name: String
    let phone: String
}

enum UsersResult {
    case success([UserModel])
    case error
}

enum UsersRepositoryResult {
    case success([User])
    case error
}

protocol UsersWireframeInterface: WireframeInterface {
    func goToPosts(user: UserModel)
    func initLoader()
    func endLoader()
}

protocol UsersViewInterface: ViewInterface {
    func reloadData()
}

protocol UsersPresenterInterface: PresenterInterface {
    var numberOfUsers: Int { get }
    func getUserModel(at row: Int) -> UserModel
    func goToPosts(idUser: Int)
    func searchUsers(with query: String)
    func refreshData()
}

protocol UsersInteractorInterface: InteractorInterface {
    var coreDataManager: CoreDataManager { get }
    func requestGetUsers(refreshData: Bool, completionHandler: @escaping (UsersResult) -> Void)
}
