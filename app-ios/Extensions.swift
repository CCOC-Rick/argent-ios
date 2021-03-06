//
//  Extensions.swift
//  app-ios
//
//  Created by Sinan Ulkuatam on 5/12/16.
//  Copyright © 2016 Sinan Ulkuatam. All rights reserved.
//

import Foundation
import Alamofire
import CWStatusBarNotification
import DynamicColor
import UIKit
import SCLAlertView
import LTMorphingLabel
import KeychainSwift

let globalNotification = CWStatusBarNotification()

public enum AlertType {
    case Success
    case Error
    case Info
    case Notice
    case Warning
    case Edit
    case Bitcoin
}

public func showAlert(type: AlertType, title: String, msg: String) {
    let appearance = SCLAlertView.SCLAppearance(
        showCircularIcon: true,
        fieldCornerRadius : 10,
        contentViewCornerRadius : 15,
        buttonCornerRadius: 10,
        kCircleIconHeight: 57,
        hideWhenBackgroundViewIsTapped: true
    )
    let alertView = SCLAlertView(appearance: appearance)
    switch type {
        case .Success:
            let alertViewIcon = UIImage(named: "ic_shiny_check") // Replace the IconImage text with the image name
            alertView.showSuccess(title, subTitle: msg, circleIconImage: alertViewIcon)
            break
        case .Error:
            let alertViewIcon = UIImage(named: "ic_shiny_error") // Replace the IconImage text with the image name
            alertView.showError(title, subTitle: msg, circleIconImage: alertViewIcon)
            break
        case .Info:
            let alertViewIcon = UIImage(named: "ic_shiny_bolt") // Replace the IconImage text with the image name
            alertView.showInfo(title, subTitle: msg, circleIconImage: alertViewIcon)
            break
        case .Notice:
            let alertViewIcon = UIImage(named: "ic_shiny_bolt") // Replace the IconImage text with the image name
            alertView.showNotice(title, subTitle: msg, circleIconImage: alertViewIcon)
            break
        case .Warning:
            let alertViewIcon = UIImage(named: "ic_shiny_alert") // Replace the IconImage text with the image name
            alertView.showWarning(title, subTitle: msg, circleIconImage: alertViewIcon)
            break
        case .Edit:
            let alertViewIcon = UIImage(named: "ic_shiny_bolt") // Replace the IconImage text with the image name
            alertView.showEdit(title, subTitle: msg, circleIconImage: alertViewIcon)
            break
        case .Bitcoin:
            let alertViewIcon = UIImage(named: "ic_shiny_bitcoin") // Replace the IconImage text with the image name
            alertView.showInfo(title, subTitle: msg, circleIconImage: alertViewIcon)
            break
    }
}

extension UIViewController {
    public func showSystemAlert(title: String, message: String, actionTitle: String) {
        let systemAlert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        systemAlert.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(systemAlert, animated: true, completion: nil)
    }
}

let headerAttrs: [String: AnyObject] = [
    NSForegroundColorAttributeName : UIColor.lightBlue(),
    NSFontAttributeName : UIFont(name: "SFUIText-Regular", size: 20)!
]

let bodyAttrs: [String: AnyObject] = [
    NSForegroundColorAttributeName : UIColor.lightBlue().colorWithAlphaComponent(0.5),
    NSFontAttributeName : UIFont(name: "SFUIText-Regular", size: 14)!
]

let calloutAttrs: [String: AnyObject] = [
    NSForegroundColorAttributeName : UIColor.lightBlue().colorWithAlphaComponent(0.85),
    NSFontAttributeName : UIFont(name: "SFUIText-Regular", size: 14)!,
    NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue
]

let inverseHeaderAttrs: [String: AnyObject] = [
    NSForegroundColorAttributeName : UIColor.whiteColor(),
    NSFontAttributeName : UIFont(name: "SFUIText-Regular", size: 20)!
]

let inverseBodyAttrs: [String: AnyObject] = [
    NSForegroundColorAttributeName : UIColor.whiteColor().colorWithAlphaComponent(0.5),
    NSFontAttributeName : UIFont(name: "SFUIText-Regular", size: 14)!
]

let inverseCalloutAttrs: [String: AnyObject] = [
    NSForegroundColorAttributeName : UIColor.whiteColor().colorWithAlphaComponent(0.85),
    NSFontAttributeName : UIFont(name: "SFUIText-Regular", size: 14)!,
    NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue
]

extension String {
    func toBool() -> Bool? {
        switch self {
        case "True", "true", "yes", "1":
            return true
        case "False", "false", "no", "0":
            return false
        default:
            return nil
        }
    }
}

extension String {
    var parseJSONString: AnyObject? {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        if let jsonData = data {
            // Will return an object or nil if JSON decoding fails
            do {
                let message = try NSJSONSerialization.JSONObjectWithData(jsonData, options:.MutableContainers)
                if let jsonResult = message as? NSMutableArray {
                    print(jsonResult)
                    
                    return jsonResult //Will return the json array output
                }
                else {
                    return nil
                }
            }
            catch let error as NSError {
                print("An error occurred: \(error)")
                return nil
            }
        }
        else {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
}

extension UIImage{
    
    func alpha(value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        
        let ctx = UIGraphicsGetCurrentContext();
        let area = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height);
        
        CGContextScaleCTM(ctx, 1, -1);
        CGContextTranslateCTM(ctx, 0, -area.size.height);
        CGContextSetBlendMode(ctx, CGBlendMode.Multiply);
        CGContextSetAlpha(ctx, value);
        CGContextDrawImage(ctx, area, self.CGImage);
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
}


// Fix Push notification bug: _handleNonLaunchSpecificActions
extension UIApplication {
    func _handleNonLaunchSpecificActions(arg1: AnyObject, forScene arg2: AnyObject, withTransitionContext arg3: AnyObject, completion completionHandler: () -> Void) {
        //catching handleNonLaunchSpecificActions:forScene exception on app close
    }
}

extension UIColor {
    static func globalBackground() -> UIColor {
        return UIColor(rgba: "#fff")
    }
    static func bankCiti() -> UIColor {
        return UIColor(rgba: "#000066")
    }
    static func bankAmex() -> UIColor {
        return UIColor(rgba: "#11A0DD")
    }
    static func bankBofa() -> UIColor {
        return UIColor(rgba: "#D4001A")
    }
    static func bankCapone() -> UIColor {
        return UIColor(rgba: "#003C70")
    }
    static func bankChase() -> UIColor {
        return UIColor(rgba: "#0f5ba7")
    }
    static func bankFidelity() -> UIColor {
        return UIColor(rgba: "#6ec260")
    }
    static func bankNavy() -> UIColor {
        return UIColor(rgba: "#04427e")
    }
    static func bankPnc() -> UIColor {
        return UIColor(rgba: "#f48024")
    }
    static func bankSchwab() -> UIColor {
        return UIColor(rgba: "#009fdf")
    }
    static func bankSuntrust() -> UIColor {
        return UIColor(rgba: "#f36b2b")
    }
    static func bankTd() -> UIColor {
        return UIColor(rgba: "#2db357")
    }
    static func bankUs() -> UIColor {
        return UIColor(rgba: "#0c2074")
    }
    static func bankUsaa() -> UIColor {
        return UIColor(rgba: "#00365b")
    }
    static func bankWells() -> UIColor {
        return UIColor(rgba: "#bb0826")
    }
    static func bitcoinOrange() -> UIColor {
        return UIColor(rgba: "#FF9900")
    }
    static func alipayBlue() -> UIColor {
        return UIColor(rgba: "#1aa1e6")
    }
    static func paleBlue() -> UIColor {
        return UIColor(rgba: "#99b2c7")
    }
    static func darkestBlue() -> UIColor {
        return UIColor(rgba: "#020405")
    }
    static func deepBlue() -> UIColor {
        return UIColor(rgba: "#131d32")
    }
    static func mintGreen() -> UIColor {
        return UIColor(rgba: "#42d1ae")
    }
    static func seaBlue() -> UIColor {
        return UIColor(rgba: "#395e7b")
    }
    static func oceanBlue() -> UIColor {
        return UIColor(rgba: "#4a7da7")
    }
    static func pastelBlue() -> UIColor {
        return UIColor(rgba: "#497ea8")
    }
    static func pastelSkyBlue() -> UIColor {
        return UIColor(rgba: "#92cfff")
    }
    static func pastelYellow() -> UIColor {
        return UIColor(rgba: "#ffd377")
    }
    static func pastelLightBlue() -> UIColor {
        return UIColor(rgba: "#eef9ff")
    }
    static func pastelDarkBlue() -> UIColor {
        return UIColor(rgba: "#3d8fcf")
    }
    static func pastelRed() -> UIColor {
        return UIColor(rgba: "#f3b0ae")
    }
    static func pastelGreen() -> UIColor {
        return UIColor(rgba: "#b2ddc9")
    }
    static func pastelBlueGray() -> UIColor {
        return UIColor(rgba: "#d8e3ea")
    }
    static func brandGreen() -> UIColor {
        return UIColor(rgba: "#5dc4a6")
    }
    static func brandRed() -> UIColor {
        return UIColor(rgba: "#e84c4c")
    }
    static func offWhite() -> UIColor {
        return UIColor(rgba: "#f5f7fa")
    }
    static func iosBlue() -> UIColor {
        return UIColor(rgba: "#007aff")
    }
    static func mediumBlue() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#2c3441")
        } else {
            return UIColor(rgba: "#2c3441")
        }
    }
    static func darkBlue() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#141c29")
        } else {
            return UIColor(rgba: "#141c29")
        }
    }
    static func lightBlue() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#7b8999")
        } else {
            return UIColor(rgba: "#7b8999")
        }
    }
    static func skyBlue() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#00a1ff")
        } else {
            return UIColor(rgba: "#00a1ff")
        }
    }
    static func limeGreen() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#d8ff52")
        } else {
            return UIColor(rgba: "#d8ff52")
        }
    }
    static func slateBlue() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#2c3441")
        } else {
            return UIColor(rgba: "#2c3441")
        }
    }
    static func brandYellow() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#e5df1f")
        } else {
            return UIColor(rgba: "#e5df1f")
        }
    }
    static func neonBlue() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#1cd7ec")
        } else {
            return UIColor(rgba: "#1cd7ec").invertColor()
        }
    }
    static func neonGreen() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#23e839")
        } else {
            return UIColor(rgba: "#23e839").invertColor()
        }
    }
    static func neonYellow() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#edef1b")
        } else {
            return UIColor(rgba: "#edef1b").invertColor()
        }
    }
    static func neonOrange() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#f28225")
        } else {
            return UIColor(rgba: "#f28225").invertColor()
        }
    }
    static func neonPink() -> UIColor {
        if APP_THEME == "LIGHT" {
            return UIColor(rgba: "#fd0981")
        } else {
            return UIColor(rgba: "#fd0981").invertColor()
        }
    }
}

extension Float {
    func round(decimalPlace:Int)->Float{
        let format = NSString(format: "%%.%if", decimalPlace)
        let string = NSString(format: format, self)
        return Float(atof(string.UTF8String))
    }
}


extension NSMutableData {
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}

public func convertStringToDictionary(text: String) -> [String:AnyObject]? {
    if let data = text.dataUsingEncoding(NSUTF8StringEncoding) {
        do {
            return try NSJSONSerialization.JSONObjectWithData(data, options: []) as? [String:AnyObject]
        } catch let error as NSError {
            print(error)
        }
    }
    return nil
}


func addSubviewWithBounce(view: UIView, parentView: UIViewController, duration: NSTimeInterval) {
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001)
    parentView.view.addSubview(view)
    UIView.animateWithDuration(duration / 1.5, animations: {() -> Void in
        view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0)
        }, completion: {(finished: Bool) -> Void in
            UIView.animateWithDuration(duration / 2, animations: {() -> Void in
                }, completion: {(finished: Bool) -> Void in
                    UIView.animateWithDuration(duration / 2, animations: {() -> Void in
                        view.transform = CGAffineTransformIdentity
                    })
            })
    })
}


func addSubviewWithFade(view: UIView, parentView: UIViewController, duration: NSTimeInterval) {
    view.alpha = 0.0
    parentView.view.addSubview(view)
    UIView.animateWithDuration(duration, animations: {
        view.alpha = 1.0
    })
}


func addSubviewWithShadow(color: UIColor, radius: CGFloat, offsetX: CGFloat, offsetY: CGFloat, opacity: Float, parentView: UIViewController, childView: UIView) {
    childView.alpha = 0.0
    parentView.view.addSubview(childView)
    UIView.animateWithDuration(1.0, animations: {
        let containerLayer: CALayer = CALayer()
        containerLayer.shadowColor = color.CGColor
        containerLayer.shadowRadius = radius
        containerLayer.shadowOffset = CGSizeMake(offsetX, offsetY)
        containerLayer.shadowOpacity = opacity
        childView.layer.masksToBounds = true
        containerLayer.addSublayer(childView.layer)
        parentView.view.layer.addSublayer(containerLayer)
        childView.alpha = 1.0
    })
}

func addSubviewText(view: UIView, parentView: UIViewController, text: UILabel, frame: CGRect, str: NSAttributedString) {
    view.alpha = 0.0
    parentView.view.addSubview(view)
    UIView.animateWithDuration(1.0, animations: {
        view.alpha = 1.0
        text.attributedText = str
        view.addSubview(text)
    })
}

func showGlobalNotification(message: String, duration: NSTimeInterval, inStyle: CWNotificationAnimationStyle, outStyle: CWNotificationAnimationStyle, notificationStyle: CWNotificationStyle, color: UIColor) {
    globalNotification.notificationLabelBackgroundColor = color
    globalNotification.notificationAnimationInStyle = inStyle
    globalNotification.notificationAnimationOutStyle = outStyle
    globalNotification.notificationStyle = notificationStyle
    globalNotification.displayNotificationWithMessage(message, forDuration: duration)
}

func formatCurrency(amount: String, fontName: String, superSize: CGFloat, fontSize: CGFloat, offsetSymbol: Int, offsetCents: Int) -> NSAttributedString {
    let formatter = NSNumberFormatter()
    formatter.numberStyle = .CurrencyStyle
    let r = amount.startIndex..<amount.endIndex
    let x = amount.substringWithRange(r)
    let amt = formatter.stringFromNumber(Float(x)!/100)
    let font:UIFont? = UIFont(name: fontName, size: fontSize)
    let attString:NSMutableAttributedString = NSMutableAttributedString(string: amt!, attributes: [
        NSFontAttributeName:font!
    ])
    
    let locale = NSLocale.currentLocale().objectForKey(NSLocaleCountryCode) as! String
    if locale == "US" {
        let fontSuper:UIFont? = UIFont(name: fontName, size: superSize)
        if Float(x) < 0 {
            attString.setAttributes([NSFontAttributeName:fontSuper!,NSBaselineOffsetAttributeName:offsetSymbol], range: NSRange(location:1,length:1))
            attString.setAttributes([NSFontAttributeName:fontSuper!,NSBaselineOffsetAttributeName:offsetCents], range: NSRange(location:(amt?.characters.count)!-2,length:2))
        } else {
            attString.setAttributes([NSFontAttributeName:fontSuper!,NSBaselineOffsetAttributeName:offsetSymbol], range: NSRange(location:0,length:1))
            attString.setAttributes([NSFontAttributeName:fontSuper!,NSBaselineOffsetAttributeName:offsetCents], range: NSRange(location:(amt?.characters.count)!-2,length:2))
        }
        
        return attString
        
    } else {
        
    }
    
    return attString
}

func currencyStringFromNumber(number: Double) -> String {
    let formatter = NSNumberFormatter()
    formatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
    formatter.currencyCode = NSLocale.currentLocale().displayNameForKey(NSLocaleCurrencySymbol, value: NSLocaleCurrencyCode)
    return formatter.stringFromNumber(number)!
}

func decimalWithString(formatter: NSNumberFormatter, string: String) -> NSDecimalNumber {
    formatter.generatesDecimalNumbers = true
    return formatter.numberFromString(string) as? NSDecimalNumber ?? 0
}

func addActivityIndicatorButton(indicator: UIActivityIndicatorView, button: UIButton, color: UIActivityIndicatorViewStyle) {
    let indicator: UIActivityIndicatorView = indicator
    let halfButtonHeight: CGFloat = button.bounds.size.height / 2
    let buttonWidth: CGFloat = button.bounds.size.width
    indicator.activityIndicatorViewStyle = color
    indicator.center = CGPointMake(buttonWidth - halfButtonHeight, halfButtonHeight)
    button.addSubview(indicator)
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    let _ = Timeout(2) {
        indicator.hidden = true
        indicator.stopAnimating()
    }
}

func addActivityIndicatorView(indicator: UIActivityIndicatorView, view: UIView, color: UIActivityIndicatorViewStyle) {
    let indicator: UIActivityIndicatorView = indicator
    let halfViewHeight: CGFloat = view.bounds.size.height / 2
    let halfViewWidth: CGFloat = view.bounds.size.width / 2
    indicator.activityIndicatorViewStyle = color
    indicator.center = CGPointMake(halfViewWidth, halfViewHeight)
    view.addSubview(indicator)
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    let _ = Timeout(2) {
        indicator.hidden = true
        indicator.stopAnimating()
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), color.CGColor)
        CGContextFillRect(UIGraphicsGetCurrentContext(), CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, forState: forState)
}}

// concatenate attributed strings
func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
    let result = NSMutableAttributedString()
    result.appendAttributedString(left)
    result.appendAttributedString(right)
    return result
}

func adjustAttributedString(text:String, spacing:CGFloat, fontName: String, fontSize: CGFloat, fontColor: UIColor, lineSpacing: CGFloat, alignment: NSTextAlignment) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: text)
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing // Whatever line spacing you want in points
    paragraphStyle.alignment = alignment

    attributedString.addAttributes([
        NSParagraphStyleAttributeName : paragraphStyle,
        NSFontAttributeName : UIFont(name: fontName, size: fontSize)!,
        NSForegroundColorAttributeName : fontColor
        ], range: NSMakeRange(0, text.characters.count))
    attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
    return attributedString
}

func adjustAttributedStringNoLineSpacing(text:String, spacing:CGFloat, fontName: String, fontSize: CGFloat, fontColor: UIColor) -> NSAttributedString {
    let attributedString = NSMutableAttributedString(string: text)
    
    attributedString.addAttributes([
        NSFontAttributeName : UIFont(name: fontName, size: fontSize)!,
        NSForegroundColorAttributeName : fontColor
        ], range: NSMakeRange(0, text.characters.count))
    attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
    return attributedString
}


extension UILabel {
    func adjustAttributedString(text:String, spacing:CGFloat, fontName: String, fontSize: CGFloat, fontColor: UIColor) {
        let attributedString = NSMutableAttributedString(string: text)
        attributedString.addAttributes([
            NSFontAttributeName : UIFont(name: fontName, size: fontSize)!,
            NSForegroundColorAttributeName : fontColor
        ], range: NSMakeRange(0, text.characters.count))
        attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
        self.attributedText = attributedString
    }
}

class SKTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 1, right: 20);
    
    override func textRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRectForBounds(bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}

class CenteredButton: UIButton {
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let rect = super.titleRectForContentRect(contentRect)
        
        return CGRectMake(0, CGRectGetHeight(contentRect) - CGRectGetHeight(rect)-12,
                          CGRectGetWidth(contentRect), CGRectGetHeight(rect))
    }
    
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let rect = super.imageRectForContentRect(contentRect)
        let titleRect = titleRectForContentRect(contentRect)
        
        return CGRectMake(CGRectGetWidth(contentRect)/2.0 - CGRectGetWidth(rect)/2.0,
                          (CGRectGetHeight(contentRect) - CGRectGetHeight(titleRect))/2.0 - CGRectGetHeight(rect)/2.0,
                          CGRectGetWidth(rect), CGRectGetHeight(rect))
    }
    
    override func intrinsicContentSize() -> CGSize {
        let size = super.intrinsicContentSize()
        
        if let image = imageView?.image
        {
            var labelHeight: CGFloat = 0.0
            
            if let size = titleLabel?.sizeThatFits(CGSizeMake(CGRectGetWidth(self.contentRectForBounds(self.bounds)), CGFloat.max))
            {
                labelHeight = size.height
            }
            
            return CGSizeMake(size.width, image.size.height + labelHeight)
        }
        
        return size
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        centerTitleLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        centerTitleLabel()
    }
    
    private func centerTitleLabel() {
        self.titleLabel?.textAlignment = .Center
    }
}

extension UIButton {
    func setImage(image: UIImage?, inFrame frame: CGRect?, forState state: UIControlState) {
        self.setImage(image, forState: state)
        
        if let frame = frame {
            self.imageEdgeInsets = UIEdgeInsets(
                top: frame.minY - self.frame.minY,
                left: frame.minX - self.frame.minX,
                bottom: self.frame.maxY - frame.maxY,
                right: self.frame.maxX - frame.maxX
            )
        }
    }
}