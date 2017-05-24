//
//  CustomSubjectCell.swift
//  study
//
//  Created by 西林咲音 on 2017/05/05.
//  Copyright © 2017年 西林咲音. All rights reserved.
//

import UIKit

class CustomSubjectCell: UITableViewCell {
    
    @IBOutlet var colorView: UIView!
    @IBOutlet var subjectLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorView.layer.cornerRadius = 12.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
