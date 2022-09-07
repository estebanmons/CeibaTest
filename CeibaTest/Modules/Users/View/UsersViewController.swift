//
//  ViewController.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 6/09/22.
//

import UIKit

final class UsersViewController: UIViewController {
    
    // MARK: - Private properties -
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        refreshControl.tintColor = .systemGreen
        return refreshControl
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Public properties -
    var presenter: UsersPresenterInterface!
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = Constants.Users.title
        addViews()
        setConstraints()
        setupTableView()
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8.0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.register(
            UINib(nibName: UserTableViewCell.cell, bundle: nil), forCellReuseIdentifier: UserTableViewCell.reuseIdentifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addSubview(refreshControl)
    }
    
    @objc private func handleRefreshControl() {
        
    }
}

// MARK: - Extensions -
extension UsersViewController: UsersViewInterface {
    
    func reloadData() {
        tableView.reloadData()
    }
}

// MARK: - Extensions -
extension UsersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfUsers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: UserTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? UserTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setModelData(presenter.getUserModel(at: indexPath.row))
        cell.delegate = self
        return cell
    }
}

extension UsersViewController: UserTableViewCellInterface {
    
    func goToPosts(idUser: Int) {
        presenter.goToPosts(idUser: idUser)
    }
}
