//
//  RepositoryCell.swift
//  Github App
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import UIKit
import AlamofireImage

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        pictureImageView.layer.cornerRadius = pictureImageView.frame.height/2
        pictureImageView.layer.masksToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
    }

    func setupView(with repo: Repository) {
        pictureImageView.af.setImage(withURL: repo.owner.avatarURL)
        nameLabel.text = repo.name
        descriptionLabel.text = repo.description
        ownerLabel.text = LocalizedString.author.localizeWithFormat(arguments: repo.owner.login)
    }
}
