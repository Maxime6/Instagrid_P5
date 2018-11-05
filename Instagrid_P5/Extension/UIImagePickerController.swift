//
//  UIImagePickerController.swift
//  Instagrid_P5
//
//  Created by Yves TANTER on 05/11/2018.
//  Copyright © 2018 Maxime Tanter. All rights reserved.
//

import UIKit

extension UIImagePickerController {
    open override var shouldAutorotate: Bool {
        return true
    }
    
    open override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
}
