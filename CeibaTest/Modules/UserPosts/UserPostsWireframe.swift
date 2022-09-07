//
//  UserPostsWireframe.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

final class UserPostsWireframe: BaseWireframe {

    // MARK: - Module setup -
    init(user: User) {
        let moduleViewController = UserPostsViewController()
        super.init(viewController: moduleViewController)

        let interactor = UserPostsInteractor(userPostsRepository: UserPostsRepository())
        let presenter = UserPostsPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -
extension UserPostsWireframe: UserPostsWireframeInterface { }
