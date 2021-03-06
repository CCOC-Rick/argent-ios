//
//  AuthViewController.swift
//  argent-ios
//
//  Created by Sinan Ulkuatam on 2/9/16.
//  Copyright © 2016 Sinan Ulkuatam. All rights reserved.
//

import UIKit
import LTMorphingLabel
import Foundation
import TransitionTreasury
import TransitionAnimation
import FBSDKLoginKit
import Spring

class AuthViewController: UIPageViewController, UIPageViewControllerDelegate, LTMorphingLabelDelegate, ModalTransitionDelegate  {
    
    private var i = -1
    
    private var textArray2 = [
        "Welcome to " + APP_NAME,
        APP_NAME + "'e hoş geldiniz",
        "Bienvenue à " + APP_NAME,
        "歡迎銀色",
        "Bienvenidos a " + APP_NAME,
        "アージェントすることを歓迎",
        "Добро пожаловать в Серебряном",
        "Willkommen in " + APP_NAME,
        "은빛에 오신 것을 환영합니다",
        "Benvenuto a " + APP_NAME
    ]
    
    internal var tr_presentTransition: TRViewControllerTransitionDelegate?

    let lbl = SpringLabel()

    let lblDetail = SpringLabel()

    let lblSubtext = LTMorphingLabel(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 100.0))

    let imageView = SpringImageView()
    
    private var text: String {
        i = i >= textArray2.count - 1 ? 0 : i + 1
        return textArray2[i]
    }
    
//    func changeText(sender: AnyObject) {
//        lblSubtext.text = text
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skipOnboarding(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("kDismissOnboardingNotification", object: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Border radius on uiview
        
        configureView()
    }
    
    func configureView() {
        
        // Test Facebook
//        let fbLoginButton = FBSDKLoginButton()
//        fbLoginButton.loginBehavior = .SystemAccount
//        fbLoginButton.center = self.view.center
//        self.view.addSubview(fbLoginButton)

        // Set up paging
        dataSource = self
        delegate = self
        
        setViewControllers([getStepOne()], direction: .Forward, animated: false, completion: nil)
        
        view.backgroundColor = UIColor.whiteColor()
        
        // screen width and height:
        let screen = UIScreen.mainScreen().bounds
        let screenWidth = screen.size.width
        let screenHeight = screen.size.height
        
        // UI
        let loginButton = UIButton(frame: CGRect(x: 15, y: screenHeight-60-28, width: screenWidth-30, height: 60.0))
        loginButton.setBackgroundColor(UIColor.whiteColor(), forState: .Normal)
        loginButton.setBackgroundColor(UIColor.whiteColor(), forState: .Highlighted)
        loginButton.tintColor = UIColor.darkBlue()
        loginButton.setTitleColor(UIColor.darkBlue(), forState: .Normal)
        loginButton.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        loginButton.titleLabel?.font = UIFont(name: "SFUIText-Regular", size: 15)!
        loginButton.setAttributedTitle(adjustAttributedString("Login", spacing: 1, fontName: "SFUIText-Regular", fontSize: 14, fontColor: UIColor.darkBlue(), lineSpacing: 0.0, alignment: .Center), forState: .Normal)
        loginButton.setAttributedTitle(adjustAttributedString("Login", spacing: 1, fontName: "SFUIText-Regular", fontSize: 14, fontColor: UIColor.lightBlue(), lineSpacing: 0.0, alignment: .Center), forState: .Highlighted)
        loginButton.layer.cornerRadius = 3
        loginButton.layer.borderWidth = 0
        loginButton.layer.borderColor = UIColor.darkBlue().CGColor
        loginButton.layer.masksToBounds = true
        loginButton.addTarget(self, action: #selector(AuthViewController.login(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(loginButton)
        
        let signupButton = UIButton(frame: CGRect(x: 15, y: screenHeight-60-88, width: screenWidth-30, height: 54.0))
        signupButton.setBackgroundColor(UIColor.pastelBlue(), forState: .Normal)
        signupButton.setBackgroundColor(UIColor.pastelBlue().darkerColor(), forState: .Highlighted)
        signupButton.setAttributedTitle(adjustAttributedString("Get Started", spacing: 1, fontName: "SFUIText-Regular", fontSize: 15, fontColor: UIColor.whiteColor(), lineSpacing: 0.0, alignment: .Center), forState: .Normal)
        signupButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signupButton.setTitleColor(UIColor.whiteColor().lighterColor(), forState: .Highlighted)
        signupButton.layer.cornerRadius = 5
        signupButton.layer.borderWidth = 1
        signupButton.layer.borderColor = UIColor.pastelBlue().CGColor
        signupButton.layer.masksToBounds = true
        signupButton.addTarget(self, action: #selector(AuthViewController.signup(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(signupButton)

//        // Set range of string length to exactly 8, the number of characters
//        lbl.frame = CGRect(x: 0, y: screenHeight*0.33, width: screenWidth, height: 40)
//        lbl.font = UIFont(name: "SFUIText-Regular", size: 23)
//        lbl.tag = 7578
//        lbl.textAlignment = NSTextAlignment.Center
//        lbl.textColor = UIColor.darkBlue()
//        lbl.adjustAttributedString(APP_NAME.uppercaseString, spacing: 8, fontName: "SFUIDisplay-Thin", fontSize: 17, fontColor: UIColor.darkBlue())
//        view.addSubview(lbl)
//        
//        _ = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(AuthViewController.changeText(_:)), userInfo: nil, repeats: true)

    }
    
    //Changing Status Bar
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // Set the ID in the storyboard in order to enable transition!
    func signup(sender:AnyObject!) {
        let viewController:UINavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("SignupNavigationController") as! UINavigationController
        
        self.presentViewController(viewController, animated: true, completion: nil)
    }
    
    // Set the ID in the storyboard in order to enable transition!
    func login(sender:AnyObject!) {
        let model = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("LoginViewController") as! LoginViewController
        
        self.presentViewController(model, animated: true, completion: nil)
    }

    // MARK: - Modal tt delegate
    
    func modalViewControllerDismiss(callbackData data: AnyObject? = nil) {
        tr_dismissViewController(completion: {
            print("Dismiss finished.")
        })
    }
    
    override func viewDidAppear(animated: Bool) { }
}

extension AuthViewController {
    
    func morphingDidStart(label: LTMorphingLabel) {
        
    }
    
    func morphingDidComplete(label: LTMorphingLabel) {
        
    }
    
    func morphingOnProgress(label: LTMorphingLabel, progress: Float) {
        
    }
    
}

extension AuthViewController {
    
    func getStepOne() -> AuthViewControllerStepOne {
        return storyboard!.instantiateViewControllerWithIdentifier("authStepOne") as! AuthViewControllerStepOne
    }
    
    func getStepTwo() -> AuthViewControllerStepTwo {
        return storyboard!.instantiateViewControllerWithIdentifier("authStepTwo") as! AuthViewControllerStepTwo
    }
    
    func getStepThree() -> AuthViewControllerStepThree {
        return storyboard!.instantiateViewControllerWithIdentifier("authStepThree") as! AuthViewControllerStepThree
    }
    
    func getStepFour() -> AuthViewControllerStepFour {
        return storyboard!.instantiateViewControllerWithIdentifier("authStepFour") as! AuthViewControllerStepFour
    }
    
}

extension AuthViewController: UIPageViewControllerDataSource {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(AuthViewControllerStepFour) {
            return getStepThree()
        } else if viewController.isKindOfClass(AuthViewControllerStepThree) {
            return getStepTwo()
        } else if viewController.isKindOfClass(AuthViewControllerStepTwo) {
            return getStepOne()
        } else if viewController.isKindOfClass(AuthViewControllerStepOne) {
            return nil
        } else if viewController.isKindOfClass(AuthViewController) {
            return nil
        } else {
            return nil
        }
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if viewController.isKindOfClass(AuthViewController) {
            return getStepOne()
        } else if viewController.isKindOfClass(AuthViewControllerStepOne) {
            return getStepTwo()
        } else if viewController.isKindOfClass(AuthViewControllerStepTwo) {
            return getStepThree()
        } else if viewController.isKindOfClass(AuthViewControllerStepThree) {
            return getStepFour()
        } else if viewController.isKindOfClass(AuthViewControllerStepThree) {
            return nil
        } else {
            return nil
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}

extension AuthViewController {
    override func viewWillDisappear(animated: Bool) {
        lblDetail.animation = "fadeInUp"
        lblDetail.duration = 3
        lblDetail.animateTo()
        
        lbl.animation = "fadeInUp"
        lbl.duration = 1
        lbl.animateTo()
        
        imageView.animation = "fadeInUp"
        imageView.duration = 1
        imageView.animateTo()
    }
}