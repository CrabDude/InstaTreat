//
//  SelectAddressViewController.swift
//  InstaTreat
//
//  Created by Ashar Rizqi on 3/22/15.
//  Copyright (c) 2015 Adam Crabtree. All rights reserved.
//

import UIKit

class SelectAddressViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gpaViewController = GooglePlacesAutocomplete(
            apiKey: "AIzaSyAgbg4DuvV80k6fhUiKzCqddOu8sk29Ess",
            placeType: .Address
        )
        
        gpaViewController.placeDelegate = self // Conforms to GooglePlacesAutocompleteDelegate
        
        presentViewController(gpaViewController, animated: true, completion: nil)
    }

}

extension SelectAddressViewController: GooglePlacesAutocompleteDelegate {
    func placeSelected(place: Place) {
        self.dismissViewControllerAnimated(true, completion: nil)
        println(place.description)
    }
    
    func placeViewClosed() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
