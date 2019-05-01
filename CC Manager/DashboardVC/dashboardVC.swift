//
//  dashboardVC.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 5/28/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import UIKit
import Firebase
import Cache

class dashboardVC: UIViewController {

    
    @IBOutlet weak var driverCount: UILabel!
    @IBOutlet weak var userCount: UILabel!
    @IBOutlet weak var blurView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var reportCountLbl: UILabel!
    @IBOutlet weak var applicationCountLbl: UILabel!
    @IBOutlet weak var request_Count: UILabel!
    
    @IBOutlet weak var campusBtn: UIButton!
    @IBOutlet weak var reportBtn: UIButton!
    @IBOutlet weak var applicationBtn: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var usertopConstraint: NSLayoutConstraint!
    @IBOutlet weak var userleadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var drivertopConstraint: NSLayoutConstraint!
    @IBOutlet weak var driverTrailConstraint: NSLayoutConstraint!
    @IBOutlet weak var triptrailConstraint: NSLayoutConstraint!
    @IBOutlet weak var tripbottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var requestLeadConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alignBtn()
        
        usertopConstraint.constant = self.containerView.frame.height * (91 / 328)
        userleadingConstraint.constant = self.containerView.frame.width * (33 / 230)
        drivertopConstraint.constant = self.containerView.frame.height * (91 / 328)
        driverTrailConstraint.constant = self.containerView.frame.width * (35 / 230)
        triptrailConstraint.constant = self.containerView.frame.width * (35 / 230)
        //tripbottomConstraint.constant = self.containerView.frame.height * (  / 328)
        requestLeadConstraint.constant = self.containerView.frame.width * (33 / 230)
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard Auth.auth().currentUser != nil else {
            
            self.performSegue(withIdentifier: "GoBackToSignInVC", sender: nil)
            
            return
            
            
        }
        
        
        countDriver()
        countUser()
        request_Counts()
        //check_test_status()
        
        
        
    }
    
    

    
    func alignBtn() {
        
        
        applicationBtn.contentHorizontalAlignment = .left
        reportBtn.contentHorizontalAlignment = .left
        campusBtn.contentHorizontalAlignment = .left
        
        
    }

    @IBAction func menuBtnPressed(_ sender: Any) {
        
        blurView.isHidden =  false
        menuView.isHidden = false
        countApplication()
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        
        if let touch = touches.first! as UITouch? {
            let touchedtPoint = touch.location(in: self.view)
            
            
            if self.menuView.frame.contains(touchedtPoint){
                
                
                
            } else {
                
                if blurView.isHidden == false {
                    
                    blurView.isHidden =  true
                    menuView.isHidden = true
                    
                }
                
            }
            
            
            
        }
        
        
    }
    @IBAction func signOutBtnPressed(_ sender: Any) {
        
        try! Auth.auth().signOut()
        
        try? InformationStorage?.removeAll()

        self.performSegue(withIdentifier: "GoBackToSignInVC", sender: nil)
        
        
    }
    @IBAction func applicationBtnPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "moveToApplicationVC", sender: nil)
        
    }
    
    @IBAction func reportBtnPressed(_ sender: Any) {
        
        
    }
    
    @IBAction func campusBtnPressed(_ sender: Any) {
        
        self.performSegue(withIdentifier: "moveToCampusVC", sender: nil)
        
    }
    

    
    func request_Counts() {
        
        Database.database().reference().child("Campus-Connect").child("Trip_request_Count").observeSingleEvent(of: .value, with: { (DriverData) in
            
            if DriverData.exists() {
                
                
                self.request_Count.isHidden = false
                self.request_Count.text = "\(DriverData.childrenCount)"
                
            } else {
                
                
                self.request_Count.isHidden = true
                
            }
            
            
            
            
        })
        
    }
    
    
    func countApplication() {
        
        
        Database.database().reference().child("Campus-Connect").child("Application_Request").child("New").observeSingleEvent(of: .value, with: { (DriverData) in
            
            if DriverData.exists() {
                
                
                 self.applicationCountLbl.isHidden = false
                self.applicationCountLbl.text = "\(DriverData.childrenCount)"
                
            } else {
                
                
                self.applicationCountLbl.isHidden = true
                
            }

            
            
            
        })
        
        
    }
    @IBAction func send_noti_driver(_ sender: Any) {
        
        Database.database().reference().child("Campus-Connect").child("Request_noti").removeValue()
        
        Database.database().reference().child("Campus-Connect").child("Request_noti").child("sdkjhf7823642").setValue(["sdkjhf7823642":"sdkjhf7823642"])
        
        
    }
    
    func countDriver() {
        
        
        Database.database().reference().child("Campus-Connect").child("Driver_Info").observe( .value, with: { (DriverData) in
            
            if DriverData.exists() {
  
                Database.database().reference().child("Campus-Connect").child("Driver_coordinator").observeSingleEvent(of: .value, with: { (Driver) in
                    
                    if Driver.exists() {
                        
                        
                        
                        
                        self.driverCount.isHidden = false
                        self.driverCount.text = "\(DriverData.childrenCount)/\(Driver.childrenCount)"
                        
                    } else {
                        
                        
                        self.driverCount.isHidden = false
                        self.driverCount.text = "\(DriverData.childrenCount)/0"
                        
                        
                    }
                    
                    
                    
                    
                })
                
                
            } else {
                
                
                self.driverCount.isHidden = true
                
            }
            
            
            
            
        })
        
        
    }
    
    func countUser() {
        
        
        Database.database().reference().child("Campus-Connect").child("User").observe( .value, with: { (UserData) in
            
            if UserData.exists() {
                
                
                
                self.userCount.text = "\(UserData.childrenCount)"
                
            } else {
                
                
                self.userCount.text = "0"
                
            }
            
            
            
            
        })
        
        
    }
    
    
}
