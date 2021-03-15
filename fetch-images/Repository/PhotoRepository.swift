//
//  PhotoRepository.swift
//  fetch-images
//
//  Created by Jirawat on 14/3/2564 BE.
//

import Foundation
import RxCocoa
import RxSwift

class PhotoRepository {
    func getPhotoPopular() -> Observable<PageModel> {
        return APImanager().getData(APImanager.FETCH_PHOTO, .get, nil)
    }
    
    func getPhotoPopularByPage(_ page : String) -> Observable<PageModel> {
        return APImanager().getData(APImanager.FETCH_PHOTO + "page=\(page)" , .get, nil)
    }
}
