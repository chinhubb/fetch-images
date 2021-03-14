//
//  PageModel.swift
//  fetch-images
//
//  Created by Jirawat on 14/3/2564 BE.
//

import Foundation
import ObjectMapper
class PageModel: ObjectMapperModel {
    var currentPage: Int? = 0
    var totalPage: Int? = 0
    var totalItems: Int? = 0
    var feature: String? = ""
    var photos: [PhotoModel]? = []

    override func mapping(map: Map) {
        super.mapping(map: map)
        currentPage <- map["current_page"]
        totalPage <- map["total_pages"]
        totalItems <- map["total_items"]
        feature <- map["feature"]
        photos <- map["photos"]
    }
}
