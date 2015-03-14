//
//  BakerPostViewController.swift
//  InstaTreat
//
//  Created by Dhanu Agnihotri on 3/9/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit
import MobileCoreServices

class BakerPostViewController: UIViewController, UINavigationControllerDelegate,  UIImagePickerControllerDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    @IBOutlet var CameraImageView: UIImageView!
    
    @IBOutlet var titleTextField: UITextField!
    
    
    var item = Item()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("baker post view loaded")
        
        //Just for testing purpose
//        if let img: UIImage = UIImage(named: "Cookie") {
//            self.CameraImageView.image = img
//        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func AddPhotoPressed(sender: AnyObject) {
        
        var vc = UIImagePickerController()
        vc.delegate = self
        //vc.sourceType = UIImagePickerControllerSourceType.Camera;
        //Show photolibrary for now so it works on the simulator
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        vc.allowsEditing = false
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
            var originalImage = info[UIImagePickerControllerOriginalImage] as UIImage
            self.CameraImageView.image = originalImage
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        if let image = UIImage(named: "Cookie") {
//            self.item.images?.append(image)
//        }
        if let image = self.CameraImageView.image {
            self.item.images?.append(image)
        }

        self.item.title = titleTextField.text

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
