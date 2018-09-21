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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func standardLayout() {
        for layout in layoutsButton {
            layout.isEnabled = true
            layout.isHighlighted = false
        }
    }
    
    
    @IBAction func chooseLayout1() {
        standardLayout()
        
        layoutsButton[0].isSelected = true
        layoutsButton[0].isEnabled = false
        
    }
    
    @IBAction func chooseLayout2() {
        standardLayout()
        
        layoutsButton[1].isSelected = true
        layoutsButton[1].isEnabled = false
        
    }
    
    @IBAction func chooseLayout3() {
        standardLayout()
        
        layoutsButton[2].isSelected = true
        layoutsButton[2].isEnabled = false
        
    }
    



}

