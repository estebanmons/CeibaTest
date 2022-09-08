//
//  PostTableViewCell.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets -
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    // MARK: - Life cycle -
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyles()
    }
    
    // MARK: - Private methods -
    private func setStyles() {
        contentView.backgroundColor = .systemGray6
        selectionStyle = .none
        postTitleLabel.font = .boldSystemFont(ofSize: 20.0)
        postTitleLabel.textColor = .black
        postBodyLabel.font = .systemFont(ofSize: 17.0)
        postBodyLabel.textColor = .gray
    }
    
    // MARK: - Public methods -
    func setModelData(_ model: PostModel) {
        postTitleLabel.text = model.title
        postBodyLabel.text = model.body
    }
}

extension PostTableViewCell {
    static let cell = String(describing: PostTableViewCell.self)
    static let reuseIdentifier = "postCell"
}
