//
//  UserPostsViewController.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import UIKit

final class UserPostsViewController: UIViewController {
    
    // MARK: - Private properties -
    private lazy var userEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0)
        label.textColor = .systemGreen
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userPhoneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20.0)
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var postsTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Public properties -
    var presenter: UserPostsPresenterInterface!
    
    // MARK: - Life cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter.viewDidLoad()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        title = Constants.Posts.title
        addViews()
        setConstraints()
        setupTableView()
        setStyles()
    }
    
    private func addViews() {
        view.addSubview(userNameLabel)
        view.addSubview(userPhoneLabel)
        view.addSubview(userEmailLabel)
        view.addSubview(postsTableView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16.0),
            userNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            
            userPhoneLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8.0),
            userPhoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            userPhoneLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            
            userEmailLabel.topAnchor.constraint(equalTo: userPhoneLabel.bottomAnchor, constant: 8.0),
            userEmailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16.0),
            userEmailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16.0),
            
            postsTableView.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 16.0),
            postsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8.0),
            postsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8.0),
            postsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16.0)
            ])
    }
    
    
    private func setStyles() {
        userNameLabel.font = .boldSystemFont(ofSize: 20.0)
        userNameLabel.textColor = .systemGreen
        userPhoneLabel.font = .boldSystemFont(ofSize: 16.0)
        userPhoneLabel.textColor = .systemGray
        userEmailLabel.font = .boldSystemFont(ofSize: 16.0)
        userEmailLabel.textColor = .systemGray
    }
    private func setupTableView() {
        postsTableView.register(
            UINib(nibName: PostTableViewCell.cell, bundle: nil), forCellReuseIdentifier: PostTableViewCell.reuseIdentifier
        )
        postsTableView.dataSource = self
        postsTableView.delegate = self
    }
}

// MARK: - Extensions -
extension UserPostsViewController: UserPostsViewInterface {
    
    func setUserData(user: UserModel) {
        userNameLabel.text = user.name
        userPhoneLabel.text = user.phone
        userEmailLabel.text = user.email
    }
    
    func reloadData() {
        postsTableView.reloadData()
    }
}

// MARK: - Extensions -
extension UserPostsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfPosts
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PostTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setModelData(presenter.getPostModel(at: indexPath.row))
        return cell
    }
}
