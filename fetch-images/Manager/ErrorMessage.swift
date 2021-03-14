//
//  ErrorMessage.swift
//  fetch-images
//
//  Created by Jirawat on 14/3/2564 BE.
//

import Foundation
enum APIStatus : String {
    case success = "success"
    case fail = "fail"
}


struct ErrorMessage : Error {
    var describe : String? = ""
    
    init(_ describe :String?) {
        if describe != nil {
             self.describe = describe
        }else{
            self.describe = APIStatus.fail.rawValue
        }
       
    }
    
    static func getError(error : Error)->String {
        guard let err = error as? ErrorMessage else{
            return  error.localizedDescription
        }
        return err.describe ?? ""
    }
}
