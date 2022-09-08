//
//  PostTableViewCell.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postBodyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyles()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func setStyles() {
        contentView.backgroundColor = .systemGray6
        selectionStyle = .none
        postTitleLabel.font = .boldSystemFont(ofSize: 20.0)
        postTitleLabel.textColor = .black
        postBodyLabel.font = .systemFont(ofSize: 17.0)
        postBodyLabel.textColor = .gray
    }
    
    func setModelData(_ model: PostModel) {
        postTitleLabel.text = model.title
        postBodyLabel.text = model.body
    }
}

extension PostTableViewCell {
    static let cell = String(describing: PostTableViewCell.self)
    static let reuseIdentifier = "postCell"
}
