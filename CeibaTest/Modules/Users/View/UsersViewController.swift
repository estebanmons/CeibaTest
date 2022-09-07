//
//  ViewController.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 6/09/22.
//

import UIKit

final class UsersViewController: UIViewController {
    
    // MARK: - Public properties -
    var presenter: UsersPresenterInterface!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}

// MARK: - Extensions -
extension UsersViewController: UsersViewInterface { }
