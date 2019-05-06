//
//  ReportDetailVC.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 5/1/19.
//  Copyright © 2019 Campus Connect LLC. All rights reserved.
//

import UIKit

class ReportDetailVC: UIViewController {

    @IBOutlet weak var TimeLbl: UILabel!
    @IBOutlet weak var ContentLbl: UILabel!
    @IBOutlet weak var TitleLbl: UILabel!
    @IBOutlet weak var NameLbl: UILabel!
    @IBOutlet weak var EmailLbl: UILabel!
    
    
    var name: String?
    var titles: String?
    var content: String?
    var email: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        

        
        NameLbl.text = name
        TitleLbl.text = titles
        ContentLbl.text = content
        EmailLbl.text = "<\(email!)>"
        
        
    }
    

    @IBAction func back1BtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func back2BtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}
