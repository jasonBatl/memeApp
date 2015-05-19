//
//  MemeEditorViewController.swift
//  imagePicker
//
//  Created by Bronson, Jason on 4/6/15.
//  Copyright (c) 2015 Bronson, Jason. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIToolbarDelegate {

    @IBOutlet weak var imagePickerBox: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var shareBtnOutlet: UIBarButtonItem!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topToolBar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topText.delegate = self
        bottomText.delegate = self
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        topText.defaultTextAttributes = memeTextAttributes
        bottomText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = NSTextAlignment.Center
        bottomText.textAlignment = NSTextAlignment.Center
        
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        //enable keyboard
        subscribeToKeyboard()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //dismiss keyboard
        unsubscribeFromKeyboard()
        
    }

    @IBAction func pickAnImage(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        //Check to see if there is an image to pick
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerBox.image = image
            dismissViewControllerAnimated(true, completion:nil)
        }
        
        if let image = imagePickerBox.image {
            shareBtnOutlet.enabled = true
        }else{
            shareBtnOutlet.enabled = false
        }
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
      
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        topText.resignFirstResponder()
        bottomText.resignFirstResponder()
        
        return true
    }
    
    func subscribeToKeyboard(){
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func unsubscribeFromKeyboard() {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    
    func keyboardWillShow(notification: NSNotification) {
        
        if bottomText.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
        
   }
    
    func keyboardWillHide(notification: NSNotification) {
        
        view.frame.origin.y += getKeyboardHeight(notification)
        
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        if bottomText.editing {
            return keyboardSize.CGRectValue().height
        } else {
            return 0
        }
    }
    
    func save(){
        if imagePickerBox.image == nil {
            //if user doesn't pick an image and try to submit it. Give them an alert.
            let alertController = UIAlertController(title:"Opps",
            message:"You must pick an image before sharing",
            preferredStyle:UIAlertControllerStyle.Alert);
            
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default,handler:nil))
            
            presentViewController(alertController, animated: true, completion: nil)
            
           
        }else{
            var meme = Meme(top: topText.text!, bottom: bottomText.text!, pic: imagePickerBox.image!, memedImage: generatedMemedImage())
        
            let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.append(meme)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func generatedMemedImage() -> UIImage {
        // hide the toolbars
        topToolBar.hidden = true
        bottomToolBar.hidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //after the meme is generated show toolbars
        topToolBar.hidden = false
        bottomToolBar.hidden = false
        
        return memedImage
    }
    
    
    
    
    
    @IBAction func shareBtn(sender: UIBarButtonItem) {
        
        var finalImage = generatedMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [finalImage], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            activity, completed, items, error in
            if completed {
                self.save()
                
            }
        }
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func cancelBtn(sender: UIBarButtonItem) {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("SentMemesTableViewController") as! SentMemesTableViewController
        presentViewController(vc, animated: true, completion:nil)
        
    }
    
    

}

