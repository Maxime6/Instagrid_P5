//
//  ViewController.swift
//  Instagrid_P5
//
//  Created by Maxime Tanter on 17/09/2018.
//  Copyright © 2018 Maxime Tanter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var layoutsButton: [UIButton]!
    @IBOutlet weak var topViewLeft: UIView!
    @IBOutlet weak var bottomViewLeft: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutSelectedAtLaunch()
    }
    
    // The layout selected when launching the app
    func layoutSelectedAtLaunch() {
        layoutsButton[1].isSelected = true
        topViewLeft.isHidden = false
        bottomViewLeft.isHidden = true
    }

    // When user selected a layout
    @IBAction func layoutButtonTaped(_ sender: UIButton) {
        layoutsButton.forEach { $0.isSelected = false }
        sender.isSelected = true
        switch sender.tag {
        case 0:
            topViewLeft.isHidden = true
            bottomViewLeft.isHidden = false
        case 1:
            bottomViewLeft.isHidden = true
            topViewLeft.isHidden = false
        case 2:
            topViewLeft.isHidden = false
            bottomViewLeft.isHidden = false
        default:
            break
        }
    }
    
    



}

