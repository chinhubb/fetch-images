//
//  ListImagesTableViewCell.swift
//  fetch-images
//
//  Created by Jirawat on 15/3/2564 BE.
//

import UIKit

class ListImagesTableViewCell: UITableViewCell {
    static let identifier = "ListImagesTableViewCell"
    static let nib = UINib(nibName: ListImagesTableViewCell.identifier, bundle: nil)

    @IBOutlet var view: UIView!
    @IBOutlet var title: UILabel!
    @IBOutlet var pic: UIImageView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var voteCountLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

//        pic.clipsToBounds = false
//        view.clipsToBounds = true
    }

    func setCell(_ data: PhotoModel?) {
        guard let list = data else { return }
        title.text = list.name ?? ""
        ImageManager.loadImage(pic, list.imageURL?[0])
        descriptionLabel.text = list.description ?? ""
        voteCountLabel.text = "\(list.voteCount ?? 0)"
        
        
    }
}
