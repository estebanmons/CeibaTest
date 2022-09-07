//
//  UserTableViewCell.swift
//  CeibaTest
//
//  Created by Esteban Monsalve on 7/09/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userEmailImageView: UIImageView!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPhoneImageView: UIImageView!
    @IBOutlet weak var userPhoneLabel: UILabel!
    @IBOutlet weak var seePostsButton: UIButton!
    
    private var idUser: Int? = nil
    var delegate: UserTableViewCellInterface!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func setView() {
        userNameLabel.font = .boldSystemFont(ofSize: 20.0)
        userNameLabel.textColor = .systemGreen
        userPhoneLabel.font = .boldSystemFont(ofSize: 16.0)
        userPhoneLabel.textColor = .systemGray
        userEmailLabel.font = .boldSystemFont(ofSize: 16.0)
        userEmailLabel.textColor = .systemGray
        seePostsButton.setTitle(Constants.Users.seePosts, for: .normal)
        seePostsButton.setTitleColor(.systemGreen, for: .normal)
        
        userPhoneImageView.tintColor = .systemGreen
        if let phoneImage = UIImage(systemName: Constants.Users.phoneFillImage)?.withRenderingMode(.alwaysTemplate) {
            userPhoneImageView.image = phoneImage
        }
        
        userEmailImageView.tintColor = .systemGreen
        if let emailImage = UIImage(systemName: Constants.Users.emailFillImage)?.withRenderingMode(.alwaysTemplate) {
            userEmailImageView.image = emailImage
        }
    }
    
    func setModelData(_ model: UserModel) {
        idUser = model.id
        userNameLabel.text = model.name
        userPhoneLabel.text = model.phone
        userEmailLabel.text = model.email
    }
    
    
    @IBAction func seePostsAction(_ sender: Any) {
        guard let idUser = idUser else { return }
        delegate.goToPosts(idUser: idUser)
    }
}

extension UserTableViewCell {
    static let cell = String(describing: UserTableViewCell.self)
    static let reuseIdentifier = "userCell"
}

protocol UserTableViewCellInterface {
    func goToPosts(idUser: Int)
}
