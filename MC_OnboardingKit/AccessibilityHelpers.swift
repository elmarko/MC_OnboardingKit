//
//  AccessibilityHelpers.swift
//  Community Assist
//
//  Created by Mark Cormack on 28/01/2020.
//  Copyright © 2020 Mark Cormack. All rights reserved.
//

import UIKit

class AccessibilityHelpers{
    
    
    /**
     
        Check if dynamic font size is isAccessibilityCategory
        
        - returns: true if isAccessibilityCategory
     
     */
    func isAccessibleLayout(for vc:UIViewController)->Bool{
        if vc.traitCollection.preferredContentSizeCategory.isAccessibilityCategory{
            return true
        }
        return false
    }
}
