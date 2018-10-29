//
//  UIView.swift
//  Instagrid_P5
//
//  Created by Yves TANTER on 16/10/2018.
//  Copyright © 2018 Maxime Tanter. All rights reserved.
//

import UIKit

extension UIView {
    
    func snapshot() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return img
        
    }
    
}
