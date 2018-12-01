//
//  DataModel.swift
//  Education Center
//
//  Created by Ye Pyae Sone Tun on 11/30/18.
//  Copyright © 2018 PrimeYZ. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DataModel {
    private init() {}
    
    static var shared : DataModel =  {
        return sharedDataModel
    }()
    
    private static var sharedDataModel: DataModel = {
        let dataModel = DataModel()
        return dataModel
    }()
    
    var user : UserVO? = nil
    
    func register(user : UserVO, success : @escaping () -> Void , failure : @escaping () -> Void) {
        
        NetworkManager.shared.registerUser(user: user, success: {
            success()
        }) {
            failure()
        }
    }
    
    
    func uploadImage(data : Data?, success : @escaping (String) -> Void, failure : @escaping () -> Void) {
        
        NetworkManager.shared.imageUpload(data: data, success: { (url) in
            success(url)
        }) {
            failure()
        }
        
    }
}
