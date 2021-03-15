//
//  DetailPictureCollectionViewCell.swift
//  fetch-images
//
//  Created by Jirawat on 14/3/2564 BE.
//

import UIKit

class DetailPictureCollectionViewCell: UICollectionViewCell, SkeletonDisplayable {
    static let identifier = "DetailPictureCollectionViewCell"
    static let nib = UINib(nibName: DetailPictureCollectionViewCell.identifier, bundle: nil)

    @IBOutlet var containerView: UIView!
    @IBOutlet var cardView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var DespHeightConstraint: NSLayoutConstraint!
    @IBOutlet var cardTop: NSLayoutConstraint!
    @IBOutlet var cardBottom: NSLayoutConstraint!
    @IBOutlet var cardLeading: NSLayoutConstraint!
    @IBOutlet var cardTrailling: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    func setCell(_ data: PhotoModel?) {
        guard let list = data else { return }
//        nameLabel.text = list.name ?? ""
//        ImageManager.loadImage(imageView, list.imageURL?[0])
    }
}
