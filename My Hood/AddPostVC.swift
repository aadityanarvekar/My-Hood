//
//  AddPostVC.swift
//  My Hood
//
//  Created by AADITYA NARVEKAR on 7/11/16.
//  Copyright © 2016 Aaditya Narvekar. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postTitleTxtFld: UITextField!
    @IBOutlet weak var postDescTxtField: UITextField!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var addPicBtn: UIButton!
    
    var imagePicker: UIImagePickerController = UIImagePickerController()
    
    var post: Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Adding rounded corners to image view
        postImage.layer.cornerRadius = postImage.frame.width / 2
        postImage.layer.masksToBounds = true
        
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func makePostBtnTapped(sender: AnyObject) {
        if let title = postTitleTxtFld.text, let desc = postDescTxtField.text, let img = postImage.image {
            if title.characters.count > 0 && desc.characters.count > 0 {
                postTitleTxtFld.text = title
                postDescTxtField.text = desc
                let imgPath = DataService.dataInstance.saveImageAndCreatePath(img)
                
                post = Post(title: title, desc: desc, imgPath: imgPath)
                DataService.dataInstance.addPost(post!)
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
            } else {
                // Title and/or description is empty
                displayErrorAlert("Post Contents", msg: "Enter post title and description.")
            }
        } else {
            // Image not selected
            displayErrorAlert("Post Image", msg: "Provide an image for the post")
            
        }
        
    }
    
    @IBAction func addPicBtnTapped(sender: AnyObject) {
        if let btn = sender as? UIButton {
            btn.setTitle("", forState: UIControlState.Normal)
        }
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    @IBAction func cancelBtnTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        if postImage.image == nil {
            addPicBtn.setTitle("+ Add Pic", forState: .Normal)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismissViewControllerAnimated(true, completion: nil)
        postImage.image = image
    }
    
    func displayErrorAlert(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Cancel, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
}
