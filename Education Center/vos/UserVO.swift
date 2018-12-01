//
//  UserVO.swift
//  Education Center
//
//  Created by Ye Pyae Sone Tun on 11/30/18.
//  Copyright © 2018 PrimeYZ. All rights reserved.
//

import Foundation

class UserVO : NSObject{
    
    var id: String? = nil
    var name: String? = nil
    var email: String? = nil
    var imageUrl: String? = nil
    var phone: String? = nil
    var address: String? = nil
    var gender: String? = nil
    
    public static func parseToDictionary(user : UserVO) -> [String : Any] {
        
        let value = [
            "id" : user.id,
            "username" : user.name ?? "",
            "email" : user.email ?? "",
            "imageUrl" : user.imageUrl ?? "",
            "phone" : user.phone ?? "",
            "address" : user.address ?? "",
            "gender" : user.gender ?? ""
        ]
        
        return value
        
    }
    
    public static func parseToUserVO(json : [String : Any]) -> UserVO {
        
        let user = UserVO()
        user.id = json["id"] as! String
        user.name = json["username"] as? String
        user.phone = json["phone"] as? String
        user.email = json["email"] as? String
        user.address = json["imageUrl"] as? String
        user.gender = json["gender"] as? String
        return user
        
    }
    
}
