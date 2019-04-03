//
//  Checkr-detailVC.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 10/22/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import UIKit
import Firebase
import Cache
import Alamofire
import AlamofireImage
import SwiftyJSON

class Checkr_detailVC: UIViewController {

    @IBOutlet weak var uidTxtField: UILabel!
    @IBOutlet weak var idTxtField: UILabel!
    @IBOutlet weak var ObjectTxtField: UILabel!
    @IBOutlet weak var UriTxtField: UILabel!
    @IBOutlet weak var StatusTxtField: UILabel!
    @IBOutlet weak var Created_at_TxtField: UILabel!
    @IBOutlet weak var Due_time_TxtField: UILabel!
    @IBOutlet weak var PackageTxtField: UILabel!
    @IBOutlet weak var Candidate_id_TxtField: UILabel!
    @IBOutlet weak var Ssn_trace_id_TxtField: UILabel!
    @IBOutlet weak var Sex_offender_search_id_TxtField: UILabel!
    @IBOutlet weak var National_criminal_search_id: UILabel!
    @IBOutlet weak var Global_watchlist_search_id_TxtField: UILabel!
    @IBOutlet weak var Terrorist_watchlist_search_id_TxtField: UILabel!
    @IBOutlet weak var Motor_vehicle_report_id_TxtField: UILabel!
    @IBOutlet weak var TimeStampTxtField: UILabel!
    
    
    
    var uid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let uid = self.uid {
            load_checkr_detail(uid: uid)
        }
        
        
    }
    
    
    func load_checkr_detail(uid: String) {
        
        Database.database().reference().child("Campus-Connect").child("check-r").child(uid).child("Screening_detail").observeSingleEvent(of: .value, with: { (DriverData) in
            
            if DriverData.exists() {
                
                if let Fdata = DriverData.value as? Dictionary<String, Any> {
                    
                    if let id = Fdata["id"] as? String, let object = Fdata["object"] as? String,  let uri = Fdata["uri"] as? String, let status = Fdata["status"] as? String, let created_at = Fdata["created_at"] as? String, let due_time = Fdata["due_time"] as? String, let package = Fdata["package"] as? String, let candidate_id = Fdata["candidate_id"] as? String, let global_watchlist_search_id = Fdata["global_watchlist_search_id"] as? String, let national_criminal_search_id = Fdata["national_criminal_search_id"] as? String, let sex_offender_search_id = Fdata["sex_offender_search_id"] as? String, let ssn_trace_id = Fdata["ssn_trace_id"] as? String, let terrorist_watchlist_search_id = Fdata["terrorist_watchlist_search_id"] as? String, let motor_vehicle_report_id = Fdata["motor_vehicle_report_id"] as? String
                        
                    {
                        
                        self.idTxtField.text = id
                        self.ObjectTxtField.text = object
                        self.UriTxtField.text = uri
                        self.StatusTxtField.text = status
                        self.Created_at_TxtField.text = created_at
                        self.Due_time_TxtField.text = due_time
                        self.PackageTxtField.text = package
                        self.Candidate_id_TxtField.text = candidate_id
                        self.Global_watchlist_search_id_TxtField.text = global_watchlist_search_id
                        self.National_criminal_search_id.text = national_criminal_search_id
                        self.Sex_offender_search_id_TxtField.text = sex_offender_search_id
                        self.Ssn_trace_id_TxtField.text = ssn_trace_id
                        self.Terrorist_watchlist_search_id_TxtField.text = terrorist_watchlist_search_id
                        self.Motor_vehicle_report_id_TxtField.text = motor_vehicle_report_id
                        self.uidTxtField.text = uid
                    } else {
                        print("err")
                    }
                    
                }
                
                
            }
            
            
        })
        
        
    }

    @IBAction func back1BtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back2BtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
