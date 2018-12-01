//
//  StudentVO.swift
//  Education Center
//
//  Created by Ye Pyae Sone Tun on 11/30/18.
//  Copyright © 2018 PrimeYZ. All rights reserved.
//

import Foundation
class StudentVO: NSObject {
    var id: String = UUID.init().uuidString
    var name: String? = nil
    var township: String? = nil
    var gender: String? = nil
    var dateOfBirth: String? = nil
    var fullAddress: String? = nil
    var profilePhotoUrl: String? = nil
    var registerDate : String? = String(Date().millisecondsSince1970)
    
    public static func parseToStudentVO (json: [String: AnyObject]) -> StudentVO {
        let studentVO = StudentVO()
        studentVO.id = json["id"] as! String
        studentVO.name = json["name"] as? String
        studentVO.township = json["township"] as? String
        studentVO.gender = json["gender"] as? String
        studentVO.dateOfBirth = json["dob"] as? String
        studentVO.fullAddress = json["fullAddress"] as? String
        studentVO.profilePhotoUrl = json["profilePhotoUrl"] as? String
        studentVO.registerDate = json["registerDate"] as? String
        return studentVO
    }
    
    public static func parseToDictionary(student: StudentVO) -> [String: AnyObject] {
        let value = [
            "id": student.id,
            "name" : student.name ?? "",
            "township" : student.township ?? "",
            "gender" : student.gender ?? "",
            "dob" : student.dateOfBirth ?? "",
            "fullAddress" : student.fullAddress ?? "",
            "profilePhotoUrl" : student.profilePhotoUrl,
            "registerDate" : Date().millisecondsSince1970
        ] as! [String : AnyObject]
        
        return value
    }
}
