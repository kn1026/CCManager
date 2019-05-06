//
//  ReportCell.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 5/1/19.
//  Copyright © 2019 Campus Connect LLC. All rights reserved.
//

import UIKit
import MGSwipeTableCell


class ReportCell: MGSwipeTableCell {

    @IBOutlet weak var NameLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    
    
    var info: ReportModel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    func configureCell(_ Information: ReportModel) {
        
        self.info = Information
        
        NameLbl.text = info.Name!
        titleLbl.text = info.Title!
        contentLbl.text = info.Content!
        
        
        
        let time = info.TimeStamp as? TimeInterval
        let date = Date(timeIntervalSince1970: time!/1000)
        
        timeLbl.text = timeAgoSinceDate(date, numericDates: true)

    }
    
    
}
