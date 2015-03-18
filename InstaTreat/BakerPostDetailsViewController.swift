//
//  BakerPostDetailsViewController.swift
//  InstaTreat
//
//  Created by Dhanu Agnihotri on 3/10/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class BakerPostDetailsViewController: UIViewController, UITextViewDelegate {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBOutlet var PriceLabel: UITextField!
    @IBOutlet var quantityLabel: UITextField!
    @IBOutlet var descriptionTextView: UITextView!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var item :Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionTextView?.delegate = self

        self.datePicker.datePickerMode = UIDatePickerMode.DateAndTime
        let currentDate = NSDate()
        self.datePicker.minimumDate = currentDate  //Set the current date/time as a minimum
        self.datePicker.date = currentDate 

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewShouldBeginEditing(aTextView: UITextView) -> Bool
    {
        if aTextView == self.descriptionTextView
        {
            self.descriptionTextView.text = ""
        }
        return true
    }

    func getDeliveryDate() -> NSString
    {
        let dateFormatter = NSDateFormatter()
        
        var theDateFormat = NSDateFormatterStyle.ShortStyle
        let theTimeFormat = NSDateFormatterStyle.ShortStyle
        
        dateFormatter.dateStyle = theDateFormat
        dateFormatter.timeStyle = theTimeFormat
        
        var dateCalculated = dateFormatter.stringFromDate(self.datePicker.date)
        println("Delivery Window " + dateCalculated)
        
        return dateCalculated
    }
  
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if self.descriptionTextView.text != nil
        {
            self.item.description = self.descriptionTextView.text
        }
        if let number: NSString = self.PriceLabel.text {
            self.item.price = number.floatValue
        }
        if let number = self.quantityLabel.text?.toInt() {
            self.item.quantity = number
        }
        self.item.deliveryTime = getDeliveryDate()
        
        //Confirm that the title and atleast one image is present before adding details
        if self.item.price==0 || self.item.quantity==0 || self.item.description.utf16Count==0
        {
            let actionSheetController: UIAlertController = UIAlertController(title: "Missing Information", message: "Please add all fields and try again", preferredStyle: .Alert)
            let nextAction: UIAlertAction = UIAlertAction(title: "OK", style: .Default) { action -> Void in
            }
            actionSheetController.addAction(nextAction)
            
            //Present the AlertController
            self.presentViewController(actionSheetController, animated: true, completion: nil)
        }
        else
        {
            if let dc = segue.destinationViewController as? BakerPostFinalViewController {
            dc.item = self.item
            }
        }
    }
    
}
