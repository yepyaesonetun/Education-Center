//
//  AccountRegisterViewController.swift
//  Education Center
//
//  Created by Ye Pyae Sone Tun on 11/29/18.
//  Copyright © 2018 PrimeYZ. All rights reserved.
//

import UIKit
import SDWebImage

import Firebase
import FirebaseAuth

class AccountRegisterViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var ivAccountProfile: UIImageView!
    @IBOutlet weak var lblAccoutDisplayName: UILabel!
    @IBOutlet weak var lblAccoutEmailAddress: UILabel!
    @IBOutlet weak var segmentedControll: UISegmentedControl!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfTownship: UITextField!
    
    var accountDisplayName: String = ""
    var accountEmailAddress: String = ""
    var accountProfileImageUrl: URL!
    var mGender: String = "Male"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /* Up Scroll while textField Focus */
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       
        /* Keyboard hide show on touch outside of keyboard */
        let tapRecognizer = UITapGestureRecognizer()
        tapRecognizer.addTarget(self, action: #selector(didTapView))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
        
        ivAccountProfile.layer.cornerRadius = 50;
        
        lblAccoutDisplayName.text = accountDisplayName
        lblAccoutEmailAddress.text = accountEmailAddress
        ivAccountProfile.sd_setImage(with: accountProfileImageUrl, placeholderImage: UIImage(named: "person_placeholder"))
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
    
    @IBAction func indexChanged(_ sender: Any) {
        switch segmentedControll.selectedSegmentIndex {
        case 0:
            mGender = "Male"
        case 1:
            mGender = "Female"
        default:
            mGender = "Male"
        }
    }
    
    @IBAction func btnContinueRegisterAccount(_ sender: Any) {
        let user = UserVO()
        user.id = Auth.auth().currentUser?.uid
        user.name = lblAccoutDisplayName.text!
        user.email = lblAccoutEmailAddress.text!
        user.phone = tfPhoneNumber.text!
        user.address = tfTownship.text!
        user.imageUrl = String(accountProfileImageUrl.absoluteString)
        user.gender = mGender
        
        DataModel.shared.register(user: user, success: {self.dismiss(animated: true, completion: nil)}, failure: {})
    }
    
}
