//
//  ViewController.swift
//  Education Center
//
//  Created by Ye Pyae Sone Tun on 11/26/18.
//  Copyright © 2018 PrimeYZ. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    @IBOutlet weak var studentListTableView: UITableView!
    
    var studentList : [StudentVO] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.studentListTableView.delegate = self
        self.studentListTableView.dataSource = self
        
        self.studentListTableView.separatorStyle = .none
        self.studentListTableView.register(UINib(nibName: "StudentTableViewCell", bundle: nil), forCellReuseIdentifier: "StudentTableViewCell")
        
        getStudents()
    }
    
    func getStudents() {
        NetworkManager.shared.loadStudents(success: { (data) in
            
            self.studentList.removeAll()
            self.studentList.append(contentsOf: data)
            self.studentListTableView.reloadData()
            
        }, failure: {
            
        })
    }
    
    @IBAction func addNewStudent(_ sender: UIBarButtonItem) {
        let navigationViewController = self.storyboard?.instantiateViewController(withIdentifier: "StudentRegisterViewController") as! UINavigationController
        self.present(navigationViewController, animated: true, completion: nil)
    }
    
}

extension ViewController : UITableViewDelegate {
    
}

extension ViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "StudentTableViewCell", for: indexPath) as! StudentTableViewCell
        
        let student = self.studentList[indexPath.row]
        
        cell.lblStudentName.text = student.name ?? "Unknown Title"
        
        cell.lblGrade.text = student.gender ?? "Unknown"
        
        return cell
    }
    
}
