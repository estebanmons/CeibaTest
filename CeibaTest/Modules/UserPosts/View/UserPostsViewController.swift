//
//  UserPostsViewController.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import UIKit

final class UserPostsViewController: UIViewController {
    
    var presenter: UserPostsPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

extension UserPostsViewController: UserPostsViewInterface { }
