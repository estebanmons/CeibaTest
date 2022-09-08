//
//  ActivityIndicator.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 8/09/22.
//

import UIKit

class ActivityIndicator: UIViewController {

    // MARK: - Private properties -
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.color = .systemGreen
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: - Lifecycle -
    override func loadView() {
        super.loadView()
        addViews()
        setUpConstraint()
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
    }
    
    // MARK: - Private methods -
    private func addViews() {
        view.addSubview(activityIndicator)
    }
    
    private func setUpConstraint() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    // MARK: - Public methods -
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
