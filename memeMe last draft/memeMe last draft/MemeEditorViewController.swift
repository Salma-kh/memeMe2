//
//  MemeEditorViewController.swift
//  memeMe last draft
//
//  Created by salma apple on 11/24/18.
//  Copyright © 2018 Udacity. All rights reserved.
//
import Foundation
import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    //set the iboutlets
    @IBOutlet weak var NavBar: UIToolbar!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        //disabled cameraButton when app is run on devices without a camera
//        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        //Setting the attributes for texts field
        setattributes(textField: topText)
        setattributes(textField: bottomText)
//     set dalegate for text
        topText.delegate = self
        bottomText.delegate = self
//        disable share button
        shareButton.isEnabled = false
    }
    //    Make the text field blank when user start typing
    func textFieldDidBeginEditing(_ topField: UITextField) {
        if topField.text=="TOP" || topField.text=="BOTTOM" {
            topField.text = ""
        }
    }
    
    //function to the return button
    func textFieldShouldReturn(_ topField: UITextField) -> Bool {
        topField.resignFirstResponder()
        return true;
        
    }
    // text attributes
    let textattributes:[NSAttributedString.Key: Any] = [
    NSAttributedString.Key.foregroundColor: UIColor.white,
    NSAttributedString.Key.strokeColor: UIColor.black,
    NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 40)!,
    NSAttributedString.Key.strokeWidth: -2]

    func setattributes(textField: UITextField)
    {
        textField.defaultTextAttributes = textattributes
        textField.textAlignment = .center
        textField.backgroundColor = UIColor.clear
        textField.borderStyle = UITextField.BorderStyle.none
    }
    
    func chooseImageFromCameraOrPhoto(sourceType: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = sourceType
        present(pickerController, animated:true, completion:nil)
    }
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
         chooseImageFromCameraOrPhoto(sourceType: .camera)
    }

 // pick image from album
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        chooseImageFromCameraOrPhoto(sourceType: .photoLibrary)
    }
    //image settings
    func imagePickerController(_ image: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            shareButton.isEnabled = true
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButton(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)

    }
    //nav and tool bar status
    func configureBars(_ isHidden: Bool) {
        toolBar.isHidden = isHidden
        NavBar.isHidden = isHidden
    }

    // method to create the meme
    func createMeme() -> UIImage {
        
        //to hide toolbar and navigation bar
        configureBars(true)

        //Combining the image and the text fields
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //show the toolbar and navigation bar
        configureBars(false)
        return memeImage
    }
    
    //Save the meme
    func save() {
      
        meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imageView.image!,selectedImage: createMeme())
        print("mem is saved")
        //Add it to memes array on AppDelegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        if let meme = meme{
            appDelegate.memes.append(meme)
        }
    }
    
    // create share meme function
    @IBAction func shareMeme(_ sender: AnyObject) {
        let memedImage = createMeme()
        let controller2 = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        controller2.completionWithItemsHandler = {
            (_,completed: Bool,_,_)->Void
            in if completed{
                self.save()
                _ = self.navigationController?.popToRootViewController(animated: true)
            } else{ print("image is  not saved")}
        }
        
        //present the shareMeme
        self.present(controller2, animated: true, completion: nil)
    }

  override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow), name: UIWindow.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide), name:  UIWindow.keyboardWillHideNotification , object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name:  UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name:  UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
     @objc func keyboardWillShow(_ notification:Notification) {
        if bottomText.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
    }
    
}


