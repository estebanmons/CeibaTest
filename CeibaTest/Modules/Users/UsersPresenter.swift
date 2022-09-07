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
}

// MARK: - Extensions -
extension UsersPresenter: UsersPresenterInterface { }
