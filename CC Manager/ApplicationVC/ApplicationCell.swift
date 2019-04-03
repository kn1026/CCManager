//
//  ApplicationCell.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 4/15/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import UIKit
import Firebase

class ApplicationCell: UITableViewCell {

    @IBOutlet weak var timeTick: UIImageView!
    @IBOutlet weak var screenTick: UIImageView!
    @IBOutlet weak var profileTick: UIImageView!
    
    @IBOutlet weak var avatarImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var campusLbl: UILabel!
    
    @IBOutlet weak var timeLbl: UILabel!
    
    var info: applicationModel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }



    
    func configureCell(_ Information: applicationModel) {
        
        self.info = Information
        
        nameLbl.text = info.user_name!
        campusLbl.text = info.campus!
        
        
        
        let time = info.TimeStamp as? TimeInterval
        let date = Date(timeIntervalSince1970: time!/1000)
        
        timeLbl.text = timeAgoSinceDate(date, numericDates: true)
        
        Database.database().reference().child("Campus-Connect").child("check-r").child(info.userUID).child("Create_Profile").observeSingleEvent(of: .value, with: { (profile) in
            
            if profile.exists() {
                
                Database.database().reference().child("Campus-Connect").child("check-r").child(self.info.userUID).child("Screening_candidate").observeSingleEvent(of: .value, with: { (screening) in
                    
                    if screening.exists() {
                        
                        
                        
                        
                        self.profileTick.isHidden = false
                        self.screenTick.isHidden = false
                        
                        
                        self.timeTick.isHidden = true
                        
                        
                        if profile.exists() {
                            
                            
                            if let pf = profile.value as? Dictionary<String, AnyObject> {
                                
                                if let timeStamp = pf["Timestamp"] as? Double  {
                                    
                                    
                                    
                                    let timestamps = Double(NSDate().timeIntervalSince1970 * 1000)
                                    let change = timestamps - timeStamp
                                    
                                    if change > 86400 {
                                        
                                        self.timeTick.isHidden = false
                                        
                                    } else {
                                        
                                        self.timeTick.isHidden = true
                                        
                                    }
                                    
                                    
                                }
                            }
                            
                        }
                        
                        
                    } else {
                        
                        
                        
                        
                        self.profileTick.isHidden = false
                        self.screenTick.isHidden = true
                        self.timeTick.isHidden = true
                        
                    }
                    
                    
                })
                
                
            } else {
                
                
                self.profileTick.isHidden = true
                self.screenTick.isHidden = true
                self.timeTick.isHidden = true
            }
            
        })
    }

}
