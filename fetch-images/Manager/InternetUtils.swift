//
//  InternetUtils.swift
//  fetch-images
//
//  Created by Jirawat on 14/3/2564 BE.
//

import Foundation
import Reachability

protocol InternetUtilsDelegate {
    func isConnect()
    func notConnect()
}
class InternetUtils : NSObject{
    
    static let share = InternetUtils()
    
    let reachability : Reachability
    
    var delegate : InternetUtilsDelegate?
    
    override init() {
        reachability = try! Reachability()
    }
    static func isConnect() -> Bool{
        let reachability  = try! Reachability()
        
        switch reachability.connection  {
        case .cellular:
            return true
        case .wifi:
            return true
        case .none:
            return false
        default:
            return false
        }
    }
    
    @objc func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        print("reachability \(reachability.connection)")

        switch reachability.connection {
        case .cellular:
            self.delegate?.isConnect()
        case .wifi:
            self.delegate?.isConnect()
        case .none:
            self.delegate?.notConnect()
        default:
            self.delegate?.notConnect()
        }
        
    }
    
    
    
    func checkForReachability () {

        NotificationCenter.default.addObserver(self
            , selector: #selector(reachabilityChanged)
            , name: .reachabilityChanged
            , object: reachability)
        do{
            try self.reachability.startNotifier()
            
        }catch{
            print("not start notifier")
        }
        
    }
    
    func stopNotifier(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
}

