//
//  UsersPresenter.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

final class UsersPresenter {

    // MARK: - Private properties -
    private unowned let view: UsersViewInterface
    private let interactor: UsersInteractorInterface
    private let wireframe: UsersWireframeInterface
    
    private var allUsers = [User]()

    // MARK: - Lifecycle -
    init(
        view: UsersViewInterface,
        interactor: UsersInteractorInterface,
        wireframe: UsersWireframeInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func getUsers() {
        interactor.requestGetUsers { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let users):
                strongSelf.allUsers = users
                strongSelf.view.reloadData()
            case .error:
                print("Error")
            }
        }
    }
}

// MARK: - Extensions -
extension UsersPresenter: UsersPresenterInterface {
    
    var numberOfUsers: Int {
        allUsers.count
    }
    
    func viewDidLoad() {
        getUsers()
    }
    
    func getUserModel(at row: Int) -> UserModel {
        let user = allUsers[row]
        return UserModel(email: user.email, id: user.id, name: user.name, phone: user.phone)
    }
    
    func goToPosts(idUser: Int) {
        guard let user = allUsers.first(where: {$0.id == idUser}) else { return }
        wireframe.goToPosts(user: user)
    }
}
