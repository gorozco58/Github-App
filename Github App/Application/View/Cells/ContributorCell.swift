//
//  ContributorCell.swift
//  Github App
//
//  Created by Giovanny Orozco Loaiza on 27/01/22.
//

import UIKit

class ContributorCell: UITableViewCell {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contributionsLabel: UILabel!
    
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

    func setupView(with contributor: Contributor) {
        pictureImageView.af.setImage(withURL: contributor.avatarURL)
        nameLabel.text = contributor.login
        contributionsLabel.text = LocalizedString.contributions.localizeWithFormat(arguments: "\(contributor.contributions)")
    }
}
