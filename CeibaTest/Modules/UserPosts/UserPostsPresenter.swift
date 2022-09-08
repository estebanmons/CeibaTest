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
    private let user: UserModel
    
    private var posts = [Post]()

    // MARK: - Lifecycle -
    init(
        view: UserPostsViewInterface,
        interactor: UserPostsInteractorInterface,
        wireframe: UserPostsWireframeInterface,
        user: UserModel
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.user = user
    }
    
    // MARK: - Private methods -
    private func getPosts() {
        wireframe.initActivityIndicator(animated: false)
        interactor.getPosts(by: user.id) { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.wireframe.endActivityIndicator(animated: false)
            switch result {
            case .success(let posts):
                strongSelf.posts = posts
                strongSelf.view.reloadData()
            case .error:
                print("Error")
            }
        }
    }
}

extension UserPostsPresenter: UserPostsPresenterInterface {
    
    var numberOfPosts: Int {
        return posts.count
    }
    
    func viewDidLoad() {
        view.setUserData(user: user)
        getPosts()
    }
    
    func getPostModel(at row: Int) -> PostModel {
        let post = posts[row]
        return PostModel(title: post.title, body: post.body)
    }
}
