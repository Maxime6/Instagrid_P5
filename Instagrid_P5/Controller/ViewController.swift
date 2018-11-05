//
//  ViewController.swift
//  Instagrid_P5
//
//  Created by Maxime Tanter on 17/09/2018.
//  Copyright © 2018 Maxime Tanter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var layoutsButton: [UIButton]!
    @IBOutlet weak var topViewLeft: UIView!
    @IBOutlet weak var bottomViewLeft: UIView!
    @IBOutlet var addPhotoButtons: [UIButton]!
    @IBOutlet var photoImageViews: [UIImageView]!
    @IBOutlet weak var gridView: UIView!
    
    let imagePicker = UIImagePickerController()
    var imageTag: Int?
    let gridViewBackgroundColor = [UIColor.red, UIColor.lightGray, UIColor.purple, UIColor.cyan]
    
    var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        layoutSelectedAtLaunch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSwipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(startAnimation))
        guard let swipeGestureRecognizer = swipeGestureRecognizer else { return }
        gridView.addGestureRecognizer(swipeGestureRecognizer)
    }
    
    @objc func setUpSwipeDirection() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            print("Set up swipe left")
            swipeGestureRecognizer?.direction = .left
        } else {
            print("set up swipe up")
            swipeGestureRecognizer?.direction = .up
        }
    }
    
    // SwipeGesture Animations
    @objc func startAnimation() {
        if swipeGestureRecognizer?.direction == .left {
            UIView.animate(withDuration: 0.4, animations: {
                self.gridView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
            }) { (_) in
                self.shareGrid()
            }
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.gridView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.height)
            }) { (_) in
                self.shareGrid()
            }
        }
    }
    
    // Share the Image
    func shareGrid() {
        guard let image = gridView.snapshot() else { return }
        let imageToShare = image
        let activityController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        present(activityController, animated:  true, completion: nil)
        activityController.completionWithItemsHandler = { _, _, _, _ in
            self.animationsReturn()
        }
    }
    
    func animationsReturn() {
        UIView.animate(withDuration: 0.5) {
            self.gridView.transform = .identity
        }
    }

    
    // Changed background color of gridView
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            let currentColor = gridView.backgroundColor
            var randomColor = gridViewBackgroundColor.randomElement()
            if randomColor == currentColor {
                randomColor = gridViewBackgroundColor.randomElement()
            } else {
                gridView.backgroundColor = randomColor
            }
        }
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
        
        openPhotoLibrary()
        
    }
    
    @objc func addNewPhoto(gesture: UITapGestureRecognizer) {
        imageTag = gesture.view?.tag
        openPhotoLibrary()
    }
    
    func openPhotoLibrary() {
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
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(addNewPhoto(gesture:)))
        photoImageViews[tag].addGestureRecognizer(tapGestureRecognizer)
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    

}

