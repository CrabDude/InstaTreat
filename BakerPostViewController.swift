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
    
    var PostItem : Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println("baker post view loaded")
        
//        var item = PFObject(className:"Items")
//        item["Title"] = "cookies"
//        item["Price"] = 2
//        item.saveInBackgroundWithBlock {
//            (success: Bool, error: NSError!) -> Void in
//            if (success) {
//                println("item saved")
//                // The object has been saved.
//            } else {
//                // There was a problem, check error.description
//            }
//        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func AddPhotoPressed(sender: AnyObject) {
        println("Add photo was pressed")
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera){
            println("Button capture")
            
            var imag = UIImagePickerController()
            imag.delegate = self
            imag.sourceType = UIImagePickerControllerSourceType.Camera;
            imag.mediaTypes = [kUTTypeImage]
            imag.allowsEditing = false
            
            self.presentViewController(imag, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        println("i've got an image");
        self.CameraImageView.image = image
        self.PostItem.images = UIImage(named: "cookie")
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        println("I got called before leaving");
        self.PostItem.images = UIImage(named: "cookie")

        if let dc = segue.destinationViewController as? BakerPostDetailsViewController {
            dc.postItem = self.PostItem!
        }
    }
}
