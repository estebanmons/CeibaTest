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
    case success([User])
    case error
}

protocol UsersWireframeInterface: WireframeInterface {
    func goToPosts(user: User)
}

protocol UsersViewInterface: ViewInterface {
    func reloadData()
}

protocol UsersPresenterInterface: PresenterInterface {
    var numberOfUsers: Int { get }
    func getUserModel(at row: Int) -> UserModel
    func goToPosts(idUser: Int)
}

protocol UsersInteractorInterface: InteractorInterface {
    func requestGetUsers(completionHandler: @escaping (UsersResult) -> Void)
}
