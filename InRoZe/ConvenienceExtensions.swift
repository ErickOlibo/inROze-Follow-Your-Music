//
//  ConvenienceExtensions.swift
//  InRoZe
//
//  Created by Erick Olibo on 18/08/2017.
//  Copyright © 2017 Erick Olibo. All rights reserved.
//

import Foundation
import UIKit


// extension for type Dictionary
extension Dictionary {
    mutating func merge<K, V>(dict: [K: V]){
        for (k, v) in dict {
            self.updateValue(v as! Value, forKey: k as! Key)
        }
    }
}


// extension for the Date

extension Date {
    func split(this date: Date) -> (hour: String, day: String, num: String, month: String)
    {
        //let usercalendar = Calendar.current
        
        let newFormatter = DateFormatter()
        newFormatter.calendar = Calendar.current
        newFormatter.dateFormat = "d"
        let splitNum = newFormatter.string(from: date)
        newFormatter.dateFormat = "MMM"
        let splitMonth = newFormatter.string(from: date)
        newFormatter.dateFormat = "E"
        let splitDay = newFormatter.string(from: date)
        newFormatter.dateFormat = "HH:mm"
        let splitHours = newFormatter.string(from: date)
        
        return (splitHours, splitDay, splitNum, splitMonth)
    }
}


// Extension ot UIView to allow one-sided border on UIViews
// MrJAckdaw/UIView+Border

extension UIView {
    
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
}
