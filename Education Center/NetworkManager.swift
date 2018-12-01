//
//  NetworkManager.swift
//  Education Center
//
//  Created by Ye Pyae Sone Tun on 11/30/18.
//  Copyright © 2018 PrimeYZ. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseStorage

class NetworkManager {

    let rootRef : DatabaseReference!
    
    let storageRef = Storage.storage().reference().child("images")
    
    public init(){
        rootRef = Database.database().reference()
    }
    
    static var shared : NetworkManager = {
        return sharedNetworkManager
    }()
    
    private static var sharedNetworkManager : NetworkManager = {
        let networkManager = NetworkManager()
        return networkManager
    }()
    
    func registerUser(user: UserVO, success: @escaping () -> Void, failure : @escaping () -> Void) {
        rootRef.child("users").child(user.id!).setValue(UserVO.parseToDictionary(user: user))
        success()
    }

    func addNewStudent(student: StudentVO, success: @escaping () -> Void, failure: @escaping () -> Void)  {
        rootRef.child("students").child(student.id).setValue(StudentVO.parseToDictionary(student: student))
        success()
    }
    
    func loadStudents(success: @escaping ([StudentVO]) -> Void, failure: @escaping () -> Void){
        rootRef.child("students").observe(.value){(dataSnapshot) in
            if let students = dataSnapshot.children.allObjects as? [DataSnapshot] {
                
                var studentList : [StudentVO] = []
                
                for student in students {
                    
                    if let value = student.value as? [String : AnyObject] {
                        
                        studentList.append(StudentVO.parseToStudentVO(json: value))
                        
                    }
                    
                }
                
                success(studentList)
                
            }
        }
    }
    
    func imageUpload(data : Data?, success : @escaping (String) -> Void, failure : @escaping () -> Void) {
        
        if let imageData = data {
            
            let uploadImageRef = storageRef.child("\(Date().millisecondsSince1970).png")
            
            let uploadTask = uploadImageRef.putData(imageData, metadata: nil) { (metadata, error) in
                
                print(metadata ?? "NO METADATA")
                print(error ?? "NO ERROR")
                
                uploadImageRef.downloadURL(completion: { (url, error) in
                    
                    if let error = error {
                        print(error)
                    }
                    
                    if let url = url {
                        print(url.absoluteString)
                        success(url.absoluteString)
                    } else {
                        failure()
                    }
                    
                })
                
            }
            
            uploadTask.observe(.progress) { (snapshot) in
                print(snapshot.progress ?? "NO MORE PROGRESS")
            }
            
            uploadTask.resume()
            
        }
        
    }
    
}
