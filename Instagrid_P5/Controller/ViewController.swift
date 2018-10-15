//
//  ViewController.swift
//  Instagrid_P5
//
//  Created by Maxime Tanter on 17/09/2018.
//  Copyright © 2018 Maxime Tanter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    var imageTag: Int?
    
    @IBOutlet var layoutsButton: [UIButton]!
    @IBOutlet weak var topViewLeft: UIView!
    @IBOutlet weak var bottomViewLeft: UIView!
    @IBOutlet var addPhotoButtons: [UIButton]!
    @IBOutlet var photoImageViews: [UIImageView]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
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
    
    // Choose an image when user tap on a + button
    @IBAction func chooseImage(_ sender: UIButton) {
        let tag = sender.tag
        imageTag = tag
        
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
        guard let tag = imageTag else { return }
        photoImageViews[tag].image = selectedImage
        addPhotoButtons[tag].isHidden = true
        
        // Tap Gesture
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }



}

