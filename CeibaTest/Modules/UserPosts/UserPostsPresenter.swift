//
//  UserPostsPresenter.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

final class UserPostsPresenter {

    // MARK: - Private properties -
    private unowned let view: UserPostsViewInterface
    private let interactor: UserPostsInteractorInterface
    private let wireframe: UserPostsWireframeInterface
    
    private var allUsers = [User]()

    // MARK: - Lifecycle -
    init(
        view: UserPostsViewInterface,
        interactor: UserPostsInteractorInterface,
        wireframe: UserPostsWireframeInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

extension UserPostsPresenter: UserPostsPresenterInterface { }
