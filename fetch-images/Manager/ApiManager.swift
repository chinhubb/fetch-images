//
//  ApiManager.swift
//  fetch-images
//
//  Created by Jirawat on 12/3/2564 BE.
//

import Alamofire
import AlamofireObjectMapper
import Foundation
import ObjectMapper
import RxSwift

class APImanager {
    static let DOMAIN = "https://api.500px.com/v1/"

//    static let FETCH_PHOTO = "photos?feature=popular&page=1"
      static let FETCH_PHOTO = "photos?feature=popular&"

    func printRequest(_ domain: String, _ apiname: String, _ parameter: [String: Any]?) {
        print("URL : \(domain)\(apiname) \nRequest : \(parameter ?? [:]) ")
    }

    func printResponse(_ statusCode: Int?, _ domain: String, _ apiname: String) {
        print("\(statusCode ?? 0)] '\(domain)\(apiname)'")
    }

    public func getData<T: ObjectMapperModel>(_ domain: String, _ method: HTTPMethod, _ parameter: [String: Any]?, header: [String: String] = [:]) -> Observable<T> {
        return Observable<T>.create { e in
            if InternetUtils.isConnect() {
                var header: [String: String] = [:]
                var newheader = header
                newheader["Content-Type"] = "application/json"
                let url = APImanager.DOMAIN + domain
                self.printRequest(APImanager.DOMAIN, domain, parameter)
                Alamofire.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: newheader).responseObject { (response: DataResponse<T>) in
                    self.printResponse(response.response?.statusCode, APImanager.DOMAIN, domain)
                    switch response.result {
                    case let .success(value):

                        e.onNext(value)
                    case let .failure(error):
                        e.onError(ErrorMessage(error.localizedDescription))
                    }
                }
            } else {
                e.onError(ErrorMessage("โปรดตรวจสอบการเชื่อมต่ออินเตอร์เน็ต"))
            }

            return Disposables.create()
        }
    }

    public func getData<T: ObjectMapperModel>(_ domain: String, _ method: HTTPMethod, _ parameter: [String: Any]?, header: [String: String] = [:]) -> Observable<[T]> {
        return Observable<[T]>.create { e in
            if InternetUtils.isConnect() {
                var header: [String: String] = [:]
                var newheader = header
                newheader["Content-Type"] = "application/json"
                let url = APImanager.DOMAIN + domain
                self.printRequest(APImanager.DOMAIN, domain, parameter)
                Alamofire.request(url, method: method, parameters: parameter, encoding: JSONEncoding.default, headers: newheader).responseArray { (response: DataResponse<[T]>) in
                    self.printResponse(response.response?.statusCode, APImanager.DOMAIN, domain)
                    switch response.result {
                    case let .success(value):

                        e.onNext(value)
                    case let .failure(error):
                        e.onError(ErrorMessage(error.localizedDescription))
                    }
                }
            } else {
                e.onError(ErrorMessage("โปรดตรวจสอบการเชื่อมต่ออินเตอร์เน็ต"))
            }

            return Disposables.create()
        }
    }
}
