//
//  ApiManager.swift
//  fetch-images
//
//  Created by Jirawat on 12/3/2564 BE.
//

import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper
import RxSwift


class APImanager {

    static let DOMAIN = "https://api.500px.com/v1/"
    
    static let FETCH_PHOTO = "photos?feature=popular&page=1"
  

    func printRequest(_ domain : String,_ apiname : String, _ parameter: [String:Any]? ){
           print("URL : \(domain)\(apiname) \nRequest : \(parameter ?? [:]) ")
       }
       
       func printResponse(_ statusCode : Int?,_ domain : String,_ apiname : String){
           print("\(statusCode ?? 0)] '\(domain)\(apiname)'")
       }
       
    
    public func getData<T : ObjectMapperModel>(_ domain : String,_ method: HTTPMethod, _ parameter: [String: Any]?, header: [String: String] = [:]) -> Observable<T>{
        return Observable<T>.create{ e in
            if InternetUtils.isConnect(){
                var header : [String:String]=[:]
                var newheader = header
                newheader ["Content-Type"] = "application/json"
                let url = APImanager.DOMAIN+domain
                self.printRequest(APImanager.DOMAIN,domain,parameter)
                Alamofire.request(url, method: method,parameters: parameter, encoding: JSONEncoding.default, headers: newheader).responseObject{(response : DataResponse<T>) in
                    self.printResponse(response.response?.statusCode,APImanager.DOMAIN,domain)
                    switch response.result{
                    case .success(let value):
                    
                        e.onNext(value)
                    case .failure(let error):
                        e.onError(ErrorMessage.init(error.localizedDescription))
                    }
                }
            }else{
                e.onError(ErrorMessage.init("โปรดตรวจสอบการเชื่อมต่ออินเตอร์เน็ตของคุณ"))
            }
            
        
              return Disposables.create()
        }
    }
    
    public func getData<T : ObjectMapperModel>(_ domain : String,_ method: HTTPMethod, _ parameter: [String: Any]?, header: [String: String] = [:]) -> Observable<[T]>{
        return Observable<[T]>.create{ e in
            if InternetUtils.isConnect(){
                var header : [String:String]=[:]
                var newheader = header
                newheader ["Content-Type"] = "application/json"
                let url = APImanager.DOMAIN+domain
                self.printRequest(APImanager.DOMAIN,domain,parameter)
                Alamofire.request(url, method: method,parameters: parameter, encoding: JSONEncoding.default, headers: newheader).responseArray{(response : DataResponse<[T]>) in
                    self.printResponse(response.response?.statusCode,APImanager.DOMAIN,domain)
                    switch response.result{
                    case .success(let value):
                        
                        e.onNext(value)
                    case .failure(let error):
                        e.onError(ErrorMessage.init(error.localizedDescription))
                    }
                }
            }else{
                e.onError(ErrorMessage.init("โปรดตรวจสอบการเชื่อมต่ออินเตอร์เน็ตของคุณ"))
            }
            
            
            return Disposables.create()
        }
    }
}

