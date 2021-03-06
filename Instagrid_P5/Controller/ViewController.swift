//
//  ViewController.swift
//  Instagrid_P5
//
//  Created by Maxime Tanter on 17/09/2018.
//  Copyright © 2018 Maxime Tanter. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //======================
    // MARK: - Outlets
    //======================
    @IBOutlet var layoutsButton: [UIButton]!
    @IBOutlet weak var topViewLeft: UIView!
    @IBOutlet weak var bottomViewLeft: UIView!
    @IBOutlet var addPhotoButtons: [UIButton]!
    @IBOutlet var photoImageViews: [UIImageView]!
    @IBOutlet weak var gridView: UIView!
    
    //======================
    // MARK: - Properties
    //======================
    private let imagePicker = UIImagePickerController()
    private var imageTag: Int?
    private let gridViewBackgroundColor = [UIColor(red: 43/255, green: 101/255, blue: 148/255, alpha: 1), UIColor.red, UIColor.lightGray, UIColor.purple, UIColor.darkGray, UIColor.magenta]
    private var currentColorPosition = 0
    private var swipeGestureRecognizer: UISwipeGestureRecognizer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBehaviors()
    }
    
    // Set behaviors of the app
    private func setBehaviors() {
        imagePicker.delegate = self
        
        layoutSelectedAtLaunch()
        
        NotificationCenter.default.addObserver(self, selector: #selector(setUpSwipeDirection), name: UIDevice.orientationDidChangeNotification, object: nil)
        
        swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(startAnimation))
        guard let swipeGestureRecognizer = swipeGestureRecognizer else { return }
        gridView.addGestureRecognizer(swipeGestureRecognizer)
        
        gridView.backgroundColor = gridViewBackgroundColor[currentColorPosition]
    }
    
    //======================
    // MARK: - Swipe and Share Grid
    //======================
    
    // Check the swipe direction
    @objc func setUpSwipeDirection() {
        if UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight {
            swipeGestureRecognizer?.direction = .left
        } else {
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
    private func shareGrid() {
        guard let image = gridView.snapshot() else { return }
        let imageToShare = image
        let activityController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
        present(activityController, animated:  true, completion: nil)
        activityController.completionWithItemsHandler = { _, _, _, _ in
            self.animationsReturn()
        }
    }
    
    // The animations when gridView return to center
    private func animationsReturn() {
        UIView.animate(withDuration: 0.5) {
            self.gridView.transform = .identity
        }
    }

    //======================
    // MARK: - ShakeGesture
    //======================
    
    // Changed background color of gridView
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            changeGridViewColor()
        }
    }
    
    // Change the gridView backgroundcolor
    private func changeGridViewColor() {
        let randomNumber = Int.random(in: 0...gridViewBackgroundColor.count - 1)
        
        if !(randomNumber == currentColorPosition) {
            gridView.backgroundColor = gridViewBackgroundColor[randomNumber]
            currentColorPosition = randomNumber
        } else {
            if randomNumber == 0 {
                gridView.backgroundColor = gridViewBackgroundColor[randomNumber + 1]
                currentColorPosition = randomNumber + 1
            } else {
                gridView.backgroundColor = gridViewBackgroundColor[randomNumber - 1]
                currentColorPosition = randomNumber - 1
            }
        }
    }
    
    //======================
    // MARK: - Choose layout and photos
    //======================
    
    // The layout selected when launching the app
    private func layoutSelectedAtLaunch() {
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
    
    // Select new photo when user tap on a photo
    @objc func addNewPhoto(gesture: UITapGestureRecognizer) {
        imageTag = gesture.view?.tag
        openPhotoLibrary()
    }
    
    // Open the photo library
    private func openPhotoLibrary() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    // Place the selected photo in the view
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
    
    // User can cancelled the action of selected a photo
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

