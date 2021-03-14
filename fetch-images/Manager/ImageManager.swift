//
//  ImageManager.swift
//  fetch-images
//
//  Created by Jirawat on 14/3/2564 BE.
//

import Foundation
import Kingfisher
import UIKit
class ImageManager {
    static func loadImage(_ imageView: UIImageView, _ url: String?) {
        guard let url = URL(string: url ?? "") else {
            imageView.image = UIImage(named: "warning")
            return
        }
        imageView.kf.setImage(with: url)
    }
}
