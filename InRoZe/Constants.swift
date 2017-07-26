//
//  Constants.swift
//  InRoZe
//
//  Created by Erick Olibo on 26/07/2017.
//  Copyright © 2017 Erick Olibo. All rights reserved.
//

import Foundation
import UIKit

public struct Constants {
    
    // Inroze 9 + 2 colors (HEX string color)
    struct InrozeHexColor {
        
        // Logo colors
        static let petal = "#FFA700"
        static let sepal = "#D23900"
        
        // 9 senses (inroze v1.0) colors
        static let one = "#4D4F83"
        static let two = "#640F6C"
        static let three = "#BE3C26"
        static let four = "#484848"
        static let five = "#BB4E82"
        static let six = "#855146"
        static let seven = "#F67F00"
        static let eight = "#E43539"
        static let nine = "#028C01"
    }
    
    // Inroze 9 + 2 colors (UIColor)
    struct InrozeColor {
    
        // Logo colors
        static let petal = UIColor.changeHexStringToColor(InrozeHexColor.petal)
        static let sepal = UIColor.changeHexStringToColor(InrozeHexColor.sepal)
        
        // 9 senses (inroze v1.0) colors
        static let one = UIColor.changeHexStringToColor(InrozeHexColor.one)
        static let two = UIColor.changeHexStringToColor(InrozeHexColor.two)
        static let three = UIColor.changeHexStringToColor(InrozeHexColor.three)
        static let four = UIColor.changeHexStringToColor(InrozeHexColor.four)
        static let five = UIColor.changeHexStringToColor(InrozeHexColor.five)
        static let six = UIColor.changeHexStringToColor(InrozeHexColor.six)
        static let seven = UIColor.changeHexStringToColor(InrozeHexColor.seven)
        static let eight = UIColor.changeHexStringToColor(InrozeHexColor.eight)
        static let nine = UIColor.changeHexStringToColor(InrozeHexColor.nine)
        
        
    }
    
    
}
