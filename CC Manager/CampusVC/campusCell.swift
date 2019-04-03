//
//  campusCell.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 5/31/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import UIKit
import Cache
import Alamofire
import AlamofireImage

class campusCell: UITableViewCell {

    
    
    @IBOutlet weak var uniName: UILabel!
    @IBOutlet weak var campusImg: UIImageView!
    var info: CampusModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ Information: CampusModel) {
        
        self.info = Information
        
        
        uniName.text = self.info.Name
        if info.Url != "" {
            
            if let ownerImageCached = try? InformationStorage?.object(ofType: ImageWrapper.self, forKey: info.Url).image {
                
                
                
                campusImg.image = ownerImageCached
                
                
            } else {
                
                
                Alamofire.request(info.Url!).responseImage { response in
                    
                    if let image = response.result.value {
                        
                        let wrapper = ImageWrapper(image: image)
                        try? InformationStorage?.setObject(wrapper, forKey: self.info.Url)
                        self.campusImg.image = image
                        
                    }
                    
                }
                
                
                
                
                
            }
            
        } else {
            campusImg.image = UIImage(named: "test")
        }
        
        
    }

}
