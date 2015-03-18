//
//  ContainerViewController.swift
//  Tweetyness
//
//  Created by Ashar Rizqi on 2/26/15.
//  Copyright (c) 2015 Ashar Rizqi. All rights reserved.
//

import UIKit
import QuartzCore

class ContainerViewController: UIViewController, UIGestureRecognizerDelegate, SidePanelViewControllerDelegate {
    
    enum SlideOutState {
        case BothCollapsed
        case LeftPanelExpanded
    }
    
    var centerNavigationController: UIViewController!
    var centerViewController: UIViewController!
    var currentState: SlideOutState = .BothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .BothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }
    var leftViewController: SidePanelViewController?
    let centerPanelExpandedOffset: CGFloat = 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIStoryboard.containerViewController = self
        self.centerViewController = UIStoryboard.centerViewController
        self.centerNavigationController = self.centerViewController
//        self.centerNavigationController = UINavigationController(rootViewController: centerViewController)
        self.view.addSubview(centerNavigationController.view)
        self.addChildViewController(centerNavigationController)
        
        centerNavigationController.didMoveToParentViewController(self)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: CenterViewController delegate methods
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .LeftPanelExpanded)
        
        if notAlreadyExpanded {
            self.addLeftPanelViewController()
        }
        
        self.animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func collapseSidePanels() {
        switch (self.currentState) {
        case .LeftPanelExpanded:
            self.toggleLeftPanel()
        default:
            break
        }
    }
    
    func addLeftPanelViewController() {
        if (self.leftViewController == nil) {
            self.leftViewController = UIStoryboard.leftViewController()
            self.leftViewController!.menuItems = [
                MenuItem(title: "Payment", image: UIImage(named: "payment")),
                MenuItem(title: "Profile", image: UIImage(named: "profile"))
            ]
            
            self.addChildSidePanelController(self.leftViewController!)
        }
    }
    
    func addChildSidePanelController(sidePanelController: SidePanelViewController) {
        sidePanelController.delegate = self
        
        self.view.insertSubview(sidePanelController.view, atIndex: 0)
        
        self.addChildViewController(sidePanelController)
        sidePanelController.didMoveToParentViewController(self)
    }
    
    func animateLeftPanel(#shouldExpand: Bool) {
        if (shouldExpand) {
            currentState = .LeftPanelExpanded
            
            animateCenterPanelXPosition(targetPosition: CGRectGetWidth(centerNavigationController.view.frame) - centerPanelExpandedOffset)
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .BothCollapsed
                
                self.leftViewController!.view.removeFromSuperview()
                self.leftViewController = nil;
            }
        }
    }
    
    func animateCenterPanelXPosition(#targetPosition: CGFloat, completion: ((Bool) -> Void)! = nil) {
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .CurveEaseInOut, animations: {
            self.centerNavigationController.view.frame.origin.x = targetPosition
            }, completion: completion)
    }
    
    func showShadowForCenterViewController(shouldShowShadow: Bool) {
        if (shouldShowShadow) {
            centerNavigationController.view.layer.shadowOpacity = 0.8
        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    // MARK: Gesture recognizer
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        let gestureIsDraggingFromLeftToRight = (recognizer.velocityInView(view).x > 0)
        
        switch(recognizer.state) {
        case .Began:
            if (self.currentState == .BothCollapsed) {
                if (gestureIsDraggingFromLeftToRight) {
                    self.addLeftPanelViewController()
                }
                
                self.showShadowForCenterViewController(true)
            }
        case .Changed:
            recognizer.view!.center.x = recognizer.view!.center.x + recognizer.translationInView(view).x
            recognizer.setTranslation(CGPointZero, inView: view)
        case .Ended:
            if (self.leftViewController != nil) {
                // animate the side panel open or closed based on whether the view has moved more or less than halfway
                let hasMovedGreaterThanHalfway = recognizer.view!.center.x > view.bounds.size.width
                self.animateLeftPanel(shouldExpand: hasMovedGreaterThanHalfway)
            }
        default:
            break
        }
    }
    
    func menuItemSelected(menuItem: MenuItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        switch menuItem.title  {
        case "Payment":
            let vc = storyboard.instantiateViewControllerWithIdentifier("Payment") as UIViewController // EditPaymentViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            println("none")
        }
        
        self.collapseSidePanels()
    }
}

var _centerViewController: UIViewController!
var _containerViewController: UIViewController!
var _leftViewController: UIViewController!

extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func leftViewController() -> SidePanelViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("SidePanelViewController") as? SidePanelViewController
    }
    
    class var containerViewController: UIViewController {
        get {
            return _containerViewController
        }
        set(containerViewController) {
            _containerViewController = containerViewController
        }
    }
    
    class var centerViewController: UIViewController? {
        get {
            if _centerViewController == nil {
                if User.currentUser.isBaker {
                    _centerViewController =  AppHelper.storyboard.instantiateViewControllerWithIdentifier("BakerPostViewController") as? UITabBarController
                } else {
                    _centerViewController = AppHelper.storyboard.instantiateViewControllerWithIdentifier("StreamNavigationController") as? UINavigationController
                }
            }

            return _centerViewController
        }
        set(centerViewController) {
            _centerViewController = centerViewController
        }
    }
    
    class func logout() {
        User.logout()
        let vc = AppHelper.storyboard.instantiateViewControllerWithIdentifier("LoginViewController") as UIViewController
        self.containerViewController.view.window?.rootViewController = vc
        self.centerViewController = nil
    }
}
