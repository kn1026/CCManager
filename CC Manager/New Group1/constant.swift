//
//  constant.swift
//  CC Manager
//
//  Created by Khoi Nguyen on 4/15/18.
//  Copyright © 2018 Campus Connect LLC. All rights reserved.
//

import Foundation
import UIKit
import Cache



let googleMap_Key = "AIzaSyAAYuBDXTubo_qcayPX6og_MrWq9-iM_KE"
let googlePlace_key = "AIzaSyAAYuBDXTubo_qcayPX6og_MrWq9-iM_KE"

let checkr_key = "9fff2ef9b7167479110102a099c2d4175d36f775"
let uniList = ["Assumption", "Champlain College", "Clark University", "Holy Cross", "Keene State College", "Plymouth State University", "UMass Amherst", "University of Connecticut", "University of New Hampshire", "University of Rhode Island", "University of Vermont", "WPI", "Worcester State University", "Campus-connect-test"]


let Stripe_key = "pk_live_1AA3PY5adk3jGDL1Eo5Db3PZ"
var applicationKey = "fd466555-559c-447e-95a0-4cc5ffbf303c"
let stripe_test_key = "pk_test_9edrI9MoXrXoYp591KT93gxW"
let dpwd = "ooewiuroiweyuruwehrgwehfgdsjhf"

func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let size = image.size
    
    let widthRatio  = targetSize.width  / image.size.width
    let heightRatio = targetSize.height / image.size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
    }
    
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage!
    
}

public struct Cashable: Codable {    }


let diskConfig = DiskConfig(name: "Floppy")
let memoryConfig = MemoryConfig(expiry: .never, countLimit: 10, totalCostLimit: 10)


let InformationStorage = try? Storage(diskConfig: diskConfig, memoryConfig: memoryConfig)

func timeAgoSinceDate(_ date:Date, numericDates:Bool) -> String {
    let calendar = Calendar.current
    let now = Date()
    let earliest = (now as NSDate).earlierDate(date)
    let latest = (earliest == now) ? date : now
    let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
    
    if (components.year! >= 2) {
        return "\(String(describing: components.year)) years ago"
    } else if (components.year! >= 1){
        if (numericDates){
            return "1 year ago"
        } else {
            return "Last year"
        }
    } else if (components.month! >= 2) {
        return "\(components.month!) months ago"
    } else if (components.month! >= 1){
        if (numericDates){
            return "1 month ago"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1 week ago"
        } else {
            return "Last week"
        }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){
            return "1 day ago"
        } else {
            return "Yesterday"
        }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) hrs ago"
    } else if (components.hour! >= 1){
        if (numericDates){
            return "1 hr ago"
        } else {
            return "An hour ago"
        }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) mins ago"
    } else if (components.minute! >= 1){
        if (numericDates){
            return "1 min ago"
        } else {
            return "A min ago"
        }
    } else if (components.second! >= 3) {
        return "\(components.second!)s"
    } else {
        return "Just now"
    }
    
}
