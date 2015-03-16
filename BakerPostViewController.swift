//
//  BakerPostViewController.swift
//  InstaTreat
//
//  Created by Dhanu Agnihotri on 3/9/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit
import MobileCoreServices

class BakerPostViewController: UIViewController, UINavigationControllerDelegate,  UIImagePickerControllerDelegate, ELCImagePickerControllerDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    @IBOutlet var CameraImageView: UIImageView!
    
    @IBOutlet var titleTextField: UITextField!
    
    
    var item = Item()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("baker post view loaded")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func AddPhotoPressed(sender: AnyObject) {
        
        var imagePicker = ELCImagePickerController()
        imagePicker.maximumImagesCount = 5
        imagePicker.imagePickerDelegate = self
        
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
        /*var vc = UIImagePickerController()
        vc.delegate = self
        //vc.sourceType = UIImagePickerControllerSourceType.Camera;
        //Show photolibrary for now so it works on the simulator
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        vc.allowsEditing = false
        self.presentViewController(vc, animated: true, completion: nil)*/
    }
    
    func elcImagePickerController(picker: ELCImagePickerController!, didFinishPickingMediaWithInfo info:[AnyObject]!) {
        
        println("controller executed.")
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if (info.count == 0) {
            return
        }
        for any in info {
            let dict = any as NSMutableDictionary
            let image = dict.objectForKey(UIImagePickerControllerOriginalImage) as UIImage
            self.item.images?.append(image)
        }
        
        //Fix this to show all selected images in a collection view
        self.CameraImageView.image =  self.item.images?[0]
    }
    
    func elcImagePickerControllerDidCancel(picker: ELCImagePickerController!) {
        println("controller executed cancel")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
//    func imagePickerController(picker: UIImagePickerController,
//        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
//            var originalImage = info[UIImagePickerControllerOriginalImage] as UIImage
//            self.CameraImageView.image = originalImage
//            self.dismissViewControllerAnimated(true, completion: nil)
//    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

//        if let image = self.CameraImageView.image {
//            self.item.images?.append(image)
//        }

        self.item.title = titleTextField.text
        //Confirm that the title and atleast one image is present before adding details 
        if self.item.images?.count==0 || self.item.title.utf16Count==0
        {
            let actionSheetController: UIAlertController = UIAlertController(title: "Missing Information", message: "Please add all fields and try again", preferredStyle: .Alert)
            let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            }
            actionSheetController.addAction(nextAction)
            
            //Present the AlertController
            self.presentViewController(actionSheetController, animated: true, completion: nil)
        }
        
        if let dc = segue.destinationViewController as? BakerPostDetailsViewController {
            dc.item = self.item
        }
    }
    @IBAction func logoutTapped(sender: AnyObject) {
        PFUser.logOut()
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController
        self.navigationController?.popToRootViewControllerAnimated(true)
        
    }
}
