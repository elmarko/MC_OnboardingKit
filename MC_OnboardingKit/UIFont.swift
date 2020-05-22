//
//  UIFont.swift
//  Community Assist
//
//  Created by Mark Cormack on 28/11/2019.
//  Copyright © 2019 Mark Cormack. All rights reserved.
//

import UIKit

public extension UIFont {
    static func preferredFont(for style: TextStyle, weight: Weight) -> UIFont {
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        return metrics.scaledFont(for: font)
    }
    
    static func preferredFont(for style: TextStyle, weight: Weight, maxSize: CGFloat) -> UIFont {
      // Get font descriptor
        
        let metrics = UIFontMetrics(forTextStyle: style)
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: style)
        let font1 = UIFont.systemFont(ofSize: desc.pointSize, weight: weight)
        let font2 = UIFont.systemFont(ofSize:maxSize, weight: weight)
        let x = metrics.scaledFont(for: font1).pointSize
        return x <= maxSize ? metrics.scaledFont(for: font1) : font2
    }
}
