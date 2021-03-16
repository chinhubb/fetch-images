//
//  PhotoModel.swift
//  fetch-images
//
//  Created by Jirawat on 14/3/2564 BE.
//

import Foundation
import ObjectMapper
class PhotoModel: ObjectMapperModel {
    var name: String? = ""
    var description : String? = ""
    var imageURL : [ String ]?
    var voteCount : Int? = 0
    var width : Int? = 0
    var height : Int? = 0

    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        description <- map["description"]
        imageURL <- map["image_url"]
        voteCount <- map["positive_votes_count"]
        width <- map["width"]
        height <- map["height"]
    }
}
