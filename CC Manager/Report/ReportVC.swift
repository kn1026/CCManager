//
//  ReportVC.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 5/1/19.
//  Copyright © 2019 Campus Connect LLC. All rights reserved.
//

import UIKit
import Firebase
import MGSwipeTableCell

class ReportVC: UIViewController,UITableViewDelegate, UITableViewDataSource, MGSwipeTableCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var ReportList = [ReportModel]()
    
    
    var name: String?
    var titles: String?
    var content: String?
    var email: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        load_report()
        
        
    }
    
    func load_report() {
        
        
        
        DataService.instance.mainDataBaseRef.child("Report").queryOrdered(byChild: "Timestamp").queryLimited(toLast: 70).observeSingleEvent(of: .value, with: { ReportData in
            
            if ReportData.exists() {
                
                
                if let snap = ReportData.children.allObjects as? [DataSnapshot] {
                    
                    for item in snap {
                        if let postDict = item.value as? Dictionary<String, Any> {
                            
                        
                            let key = ReportData.key
                            let report = ReportModel(postKey: key, ReportModel: postDict)
                            
                            
                            
                            self.ReportList.insert(report, at: 0)
                            
                        }
                        
                    }
                    
                    self.tableView.reloadData()
                    
                }
                
                
                
            }
            
        })
        
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if ReportList.isEmpty != true {
            
            tableView.restore()
            return 1
        } else {
            
            tableView.setEmptyMessage("Don't have any report !!!")
            return 1
            
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return ReportList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        var data: ReportModel
        
        data = ReportList[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCell") as? ReportCell {
            
            if indexPath.row > 0 {
                
                let lineFrame = CGRect(x:20, y:0, width: Double(self.view.frame.width) - 42, height: 1)
                let line = UIView(frame: lineFrame)
                line.backgroundColor = UIColor.groupTableViewBackground
                cell.addSubview(line)
                
            }
            
            cell.delegate = self
            cell.configureCell(data)
            
            
            return cell
            
        } else {
            
            return ApplicationCell()
            
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let rp = ReportList[indexPath.row]
        
        
        name = rp.Name
        titles = rp.Title
        content = rp.Content
        email = rp.Email
        
        self.performSegue(withIdentifier: "moveToTripDetailVC", sender: nil)
        
    }
    
    
    func swipeTableCell(_ cell: MGSwipeTableCell, canSwipe direction: MGSwipeDirection) -> Bool {
        return true;
    }
    
    
    func swipeTableCell(_ cell: MGSwipeTableCell, swipeButtonsFor direction: MGSwipeDirection, swipeSettings: MGSwipeSettings, expansionSettings: MGSwipeExpansionSettings) -> [UIView]? {
        
        swipeSettings.transition = MGSwipeTransition.border;
        expansionSettings.buttonIndex = 0
        let resolveColor = UIColor(red: 147/255, green: 216/255, blue: 122/255, alpha: 1.0)
        let padding = 7
        if direction == MGSwipeDirection.rightToLeft {
            expansionSettings.fillOnTrigger = false;
            expansionSettings.threshold = 1.1
            
            
            let remove = MGSwipeButton(title: "Reply", backgroundColor: UIColor.lightGray, padding: padding,  callback: { (cell) -> Bool in
                
                
                
                self.ReplyAtIndexPath(self.tableView.indexPath(for: cell)!)
                
                return false; //don't autohide to improve delete animation
                
            });
            
            
            
            let defaults = MGSwipeButton(title: "Resolve", backgroundColor: resolveColor, padding: padding, callback: { (cell) -> Bool in
                
                
                //self.defaultAtIndexPath(self.tableView.indexPath(for: cell)!)
                
                return false; //autohide
                
            });
            
            return [defaults, remove]
        } else {
            
            return nil
        }
        
        
        
        
    }
    
    
    func ReplyAtIndexPath(_ path: IndexPath) {
        
        
        
        
        
        
        let rp = ReportList[path.row]
        
        name = rp.Name
        titles = rp.Title
        content = rp.Content
        email = rp.Email
        
        
        
        self.performSegue(withIdentifier: "moveToTripDetailVC", sender: nil)
        
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "moveToTripDetailVC"{
            if let destination = segue.destination as? ReportDetailVC
            {
               // destination.bounds = self.bounds
                
                destination.name = self.name
                destination.titles = self.titles
                destination.content = self.content
                destination.email = self.email
                
            }
        }
        
        
    }
    

    @IBAction func back1BtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func back2BtnPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
}
