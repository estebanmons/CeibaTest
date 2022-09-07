//
//  UsersWireframe.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import Foundation

final class UsersWireframe: BaseWireframe {

    // MARK: - Module setup -
    init() {
        let moduleViewController = UsersViewController()
        super.init(viewController: moduleViewController)

        let interactor = UsersInteractor()
        let presenter = UsersPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -
extension UsersWireframe: UsersWireframeInterface { }
