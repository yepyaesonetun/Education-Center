//
//  RegisterViewController.swift
//  Education Center
//
//  Created by Ye Pyae Sone Tun on 11/28/18.
//  Copyright © 2018 PrimeYZ. All rights reserved.
//

import UIKit
import DatePickerDialog

class StudentRegisterViewController: BaseViewController {
    @IBOutlet weak var ivProfileImage: UIImageView!
    @IBOutlet weak var tfUserName: ShadowTextField!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var tvFullAddress: CustomTextView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var mGender: String = "Male"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let onTap = UITapGestureRecognizer(target: self, action: #selector(onClickUploadStudentPhoto))
        uploadProfileImage.isUserInteractionEnabled = true
        uploadProfileImage.addGestureRecognizer(onTap)
        
        let onTapDOBLabel = UITapGestureRecognizer(target: self, action: #selector(onTapDOBChooserLabel))
        lblDOB.isUserInteractionEnabled = true
        lblDOB.addGestureRecognizer(onTapDOBLabel)
        
        /* Up Scroll while textField Focus */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        /* Keyboard hide show on touch outside of keyboard */
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    /* Up Scroll while textField Focus */
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /* Up Scroll while textField Focus */
    @objc func keyboardWillChange(notification : Notification) {
        
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification {
            //            view.frame.origin.y = -keyboardReact.height
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardReact.height, right: 0)
        } else {
            //            view.frame.origin.y = 0
            scrollView.contentInset = UIEdgeInsets.zero
            
        }
        
        scrollView.scrollIndicatorInsets = scrollView.contentInset
        
    }
    
    /* Keyboard hide show on touch outside of keyboard */
    @objc func didTapView() {
        self.view.endEditing(true)
    }
    
    @IBOutlet weak var uploadProfileImage: UIImageView!
    
    @objc func onClickUploadStudentPhoto() {
        self.chooseUpload(imagePickerControllerDelegate: self)
    }
    
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mGender = "Male"
        case 1:
            mGender = "Female"
        default:
            mGender = "Male"
        }
    }
    @IBAction func registerStudent(_ sender: Any) {
        let student = StudentVO()
        student.name = tfUserName.text!
        student.township = "tf.text!"
        student.gender = mGender
        student.dateOfBirth = lblDOB.text
        student.fullAddress = tvFullAddress.text
        
        NetworkManager.shared.addNewStudent(student: student, success: {self.dismiss(animated: true, completion: nil)}, failure: {})
    }
    
  
    @objc func onTapDOBChooserLabel(){
        DatePickerDialog().show("Date of Birth", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", datePickerMode: .date) {
            (date) -> Void in
            if let dt = date {
                let formatter = DateFormatter()
                formatter.dateFormat = "MM/dd/yyyy"
                self.lblDOB.text = formatter.string(from: dt)
            }
        }
    }
}

extension StudentRegisterViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        self.dismiss(animated: true, completion: nil)
        
        if let pickedImage = info[.editedImage] as? UIImage {
            
            DataModel.shared.uploadImage(data: pickedImage.pngData(), success: { (url) in
                
                self.ivProfileImage.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "person_placeholder"))
                print("UUUU \(url)")
                
            }) {
                self.showAlertDialog(inputMessage: "Error.")
            }
            
        }
    }
    
}
