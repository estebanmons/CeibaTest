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
    
    private var allUsers = [UserModel]()
    private var resultUsers = [UserModel]()

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
    
    func getUsers(refreshData: Bool) {
        interactor.requestGetUsers(refreshData: refreshData) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let users):
                strongSelf.allUsers = users
                strongSelf.resultUsers = users
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
        resultUsers.count
    }
    
    func viewDidLoad() {
        getUsers(refreshData: false)
    }
    
    func getUserModel(at row: Int) -> UserModel {
        let user = resultUsers[row]
        return UserModel(email: user.email, id: user.id, name: user.name, phone: user.phone)
    }
    
    func goToPosts(idUser: Int) {
        guard let user = allUsers.first(where: {$0.id == idUser}) else { return }
        wireframe.goToPosts(user: UserModel(email: user.email, id: user.id, name: user.name, phone: user.phone))
    }
    
    func searchUsers(with query: String) {
        if query.isEmpty {
            resultUsers = allUsers
            view.reloadData()
        } else {
            resultUsers = allUsers.filter { $0.name.range(of: query, options: .caseInsensitive) != nil }
            view.reloadData()
        }
    }
    
    func refreshData() {
        getUsers(refreshData: true)
    }
}
