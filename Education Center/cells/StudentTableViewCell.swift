//
//  StudentTableViewCell.swift
//  Education Center
//
//  Created by Ye Pyae Sone Tun on 11/29/18.
//  Copyright © 2018 PrimeYZ. All rights reserved.
//

import UIKit

class StudentTableViewCell: UITableViewCell {
    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var ivStudent: UIImageView!
    @IBOutlet weak var lblGrade: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
