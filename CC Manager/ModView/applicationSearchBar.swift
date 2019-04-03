//
//  applicationSearchBar.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 5/29/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import UIKit

class applicationSearchBar: UISearchBar {

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        //layer.cornerRadius = frame.height / 2.75
        clipsToBounds = true
        
    }

}
