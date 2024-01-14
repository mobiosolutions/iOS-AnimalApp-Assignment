//
//  Utility.swift
//  
//
//  Created by Arvind on 26/12/17.
//  Copyright © 2017 Komal. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
//import YBPopupMenu
import Foundation
import MobileCoreServices
//import SVProgressHUD
import AVFoundation
import AVFAudio

// MARK:- RGB Color
func RGB(r:Float, g:Float, b:Float, a:Float) -> UIColor {
    
    let color = UIColor.init(red: CGFloat(r/255.0), green: CGFloat(g/255.0), blue: CGFloat(b/255.0), alpha: CGFloat(a))
    
    return color
}

// MARK:- TextField Placeholder Color
func textFieldPlaceholderColor() -> UIColor{
    
    let color = RGB(r: 209.0, g: 214.0, b: 227.0, a: 1.0)
    return color
}

func showNavigationBar(navigationCtrl:UINavigationController){
    
    navigationCtrl.setNavigationBarHidden(false, animated: true)
    navigationCtrl.navigationBar.tintColor = UIColor.white
    navigationCtrl.navigationBar.barTintColor = RGB(r: 229, g: 103, b: 65, a: 1)
    navigationCtrl.navigationBar.isTranslucent = false
    navigationCtrl.navigationBar.alpha = 1.0
    navigationCtrl.navigationBar.shadowImage = UIImage()
    navigationCtrl.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationCtrl.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white , NSAttributedString.Key.font: UIFont(name: fonts.medium, size: 21)!]
}
//MARK:- Get device size

enum iPhoneDevice: String {
    case iPhone4 = "iPhone4"
    case iPhone5 = "iPhone5"
    case iPhone6 = "iPhone6"
    case iPhone6P = "iPhone6P"
    case iPhoneX = "iPhoneX"
}

func getFromUserDefault(_ key: String) -> Any {
    if let value = UserDefaults.standard.object(forKey: key){
        return value
    }
    return ""
    
}

func iPhoneDeviceType()->(iPhoneDevice){
    
    if UIDevice().userInterfaceIdiom == .phone {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            print("iPhone 4 or 4S")
            return iPhoneDevice.iPhone4
        case 1136:
            print("iPhone 5 or 5S or 5C")
            return iPhoneDevice.iPhone5
        case 1334:
            print("iPhone 6/6S/7/8")
            return iPhoneDevice.iPhone6
        case 2208:
            print("iPhone 6+/6S+/7+/8+")
            return iPhoneDevice.iPhone6P
        case 2436:
            print("iPhone X")
            return iPhoneDevice.iPhoneX
        default:
            print("unknown")
        }
    }
    return iPhoneDevice.iPhone5
}



//MARK:- Corner Radius
func cornerRadius(button:UIButton,view:UIView,viewCornerRadius:CGFloat,ButtonCornerRadius:CGFloat){
    
    button.layer.cornerRadius = button.frame.size.height/2
    view.layer.cornerRadius = viewCornerRadius
    button.layer.cornerRadius = ButtonCornerRadius
    
}
//MARK:- Alert View

func showAlertWithButton(title: String ,message: String, delegate : UIViewController, btnTitle : String = "Ok" , callback: @escaping (Int) -> ()){
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let btn = UIAlertAction(title: btnTitle, style: .default) { (action) -> Void in
        
        callback(0)
    }
    
    alertController.addAction(btn);
    
    alertController.view.tintColor = UIColor.black
    
    //alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .gray
    
    delegate.present(alertController, animated: true, completion: nil)
}

func showAlertWithTitle(title: String,message: String, delegate : UIViewController, cancel : String = "OK", btnOk : String = ""){
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let btnOKAction = UIAlertAction(title: cancel, style: .default) { (action) -> Void in
        
    }
    alertController.addAction(btnOKAction)
    
    if(btnOk != ""){
        
        let btnOKAct = UIAlertAction(title: btnOk, style: .default) { (action) -> Void in
            
        }
        alertController.addAction(btnOKAct)
    }
    alertController.view.tintColor = UIColor.black
    
    delegate.present(alertController, animated: true, completion: nil)
}

func showAlertWithTwoButton(title: String ,message: String, delegate : UIViewController, leftButton : String = "Yes" , rightButton : String = "No", callback: @escaping (Int) -> ()){
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let btnLeftAction = UIAlertAction(title: leftButton, style: .default) { (action) -> Void in
        
        callback(0)
    }
    
    let btnRightAction = UIAlertAction(title: rightButton, style: .default) { (action) -> Void in
        callback(1)
    }
    
    alertController.addAction(btnLeftAction);
    alertController.addAction(btnRightAction);
    
    alertController.view.tintColor = UIColor.black
    
    //alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = .gray
    
    delegate.present(alertController, animated: true, completion: nil)
}

//MARK:- Action sheet

func actionViewControllerWithSelection(currentVC : UIViewController , title : String? , arrOptions : [String] , withCompletion completion:@escaping (Int) -> Void) {
    
    var titleStr : String? = nil
    if title?.count != 0{
        titleStr = title
    }
    let actionSheetController: UIAlertController = UIAlertController(title: titleStr, message: nil, preferredStyle: .actionSheet)
    
    actionSheetController.view.tintColor = .black
    
    let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { void in
        print("Cancel")
    }
    actionSheetController.addAction(cancelActionButton)
    
    for (index, str) in arrOptions.enumerated() {
        if(str.lowercased() == "logout" || str.lowercased() == "log out"){
            let tmp: UIAlertAction = UIAlertAction(title: str, style: .destructive)
            { void in
                completion(index)
            }
            actionSheetController.addAction(tmp)
        }else{
            let tmp: UIAlertAction = UIAlertAction(title: str, style: .default)
            { void in
                completion(index)
            }
            actionSheetController.addAction(tmp)
        }
        
    }
    currentVC.present(actionSheetController, animated: true, completion: nil)
    
}

//MARK:- Network Rechablity
func connectedToInternet() -> Bool {
    
    
    let rechablity = Reachability()!
    if(rechablity.connection == .none){
        
        print("There is no internet connection")
        showTostMsg(msg: "There is no intenet connection")
        return false
    }
    print("Internet connection available")
    return true
    
}

//MARK:- Tost Message
func showTostMsg(msg: String){
    
    for view in (APP_DEL.window?.subviews)! {
        
        if(view is AMTost){
            view.removeFromSuperview()
        }
    }
    
    let array = Bundle.main.loadNibNamed("AMTost", owner: nil, options: nil)
    let amTost = array?.last as! AMTost
    amTost.aligment = TostAlignment.BottomAlign
    amTost.setMessageTitle(msg: msg)
    APP_DEL.window?.addSubview(amTost)
    APP_DEL.window?.bringSubviewToFront(amTost)
    amTost.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
    
}

//MARK: - Date Format
func stringToFormatedDateString(strDate: String) -> (String) {
    
    let newDate = stringToDate(strDate: strDate)
    let newFormatedDate = dateToString(date: newDate)
    return newFormatedDate
}

func stringToDateString(strDate: String) -> (String) {
    
    let newDate = shortStringToDate(strDate: strDate)
    let newFormatedDate = dateToString(date: newDate)
    return newFormatedDate
}
func shortStringToDate(strDate: String) -> (Date) {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: strDate)!
    return date
}

func stringToDate(strDate: String, format:String = eDateFormats.def.rawValue) -> (Date) {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//    dateFormatter.timeZone = TimeZone.current
    let date = dateFormatter.date(from: strDate)!
    return date
}

func getTimeStamp(strDate: String) -> (Double) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let date = dateFormatter.date(from: strDate)!
    let timestamp = date.timeIntervalSince1970
    
    print(timestamp)
    return timestamp
}

func dateToString(date: Date) -> (String) {
    let formatter = DateFormatter()
    // initially set the format based on your datepicker date
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    let myString = formatter.string(from: date)
    // convert your string to date
    let yourDate = formatter.date(from: myString)
    //then again set the date format whhich type of output you need
    formatter.dateFormat = "MMMM yyyy"
    // again convert your date to string
    let newDate = formatter.string(from: yourDate!)
    
    let anchorComponents = Calendar.current.component(.day, from: date)//Calendar.dateComponents([.day, .month, .year], from: date)
    
    var day = String(format: "%d", anchorComponents)//"\(anchorComponents)"
    switch (day) {
    case "1" , "21" , "31":
        day.append("st")
    case "2" , "22":
        day.append("nd")
    case "3" ,"23":
        day.append("rd")
    default:
        day.append("th")
    }
    return day + " " + newDate
    
}

//MARK:- Get Time Stamp
func getTimeStamp() -> (Double) {
    
    // Get the Unix timestamp
    let timestamp = NSDate().timeIntervalSince1970
    
    print(timestamp)
    return timestamp
}

func convertDateFormater(date: String, inputFormat : String, outputFormat: String) -> String
{
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = inputFormat
    let showDate = inputFormatter.date(from: date)
    inputFormatter.dateFormat = outputFormat
    if let date = showDate{
        let resultString = inputFormatter.string(from: date)
        return resultString
    }else{
        return ""
    }
}


func getElapsedTimeString(sourceDate:NSDate) -> String{
    
    let currentDate = Date();
    
    let formatForCheck = DateFormatter();
    formatForCheck.dateFormat = "yyyy-MM-dd"
    
    let units: Set<Calendar.Component> = [.day,.month,.year,.hour,.minute,.second]
    let components = NSCalendar.current.dateComponents(units, from: sourceDate as Date, to: currentDate as Date)
    
    if(components.year! > 0 || components.month! > 0 || components.day! > 1){
        return getStringForDate(date: sourceDate as Date?, destinationFormat: "dd/MM/yyyy hh:mm a")
        
    }else if(components.day! == 1 || formatForCheck.string(from: sourceDate as Date) != formatForCheck.string(from: currentDate)){
        return "Yesterday, \(getStringForDate(date: sourceDate as Date?, destinationFormat: "hh:mm a"))"
        
    }else{
        return "Today, \(getStringForDate(date: sourceDate as Date?, destinationFormat: "hh:mm a"))"
    }
    
}
func getStringForDate(date : Date!, destinationFormat : String) -> String{
    
    let dateFormatter = DateFormatter();
    dateFormatter.dateFormat = destinationFormat;
    //        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!;
    return dateFormatter.string(from: date! as Date)
}

func checkIfDateSameIgnoringTime(date1 : Date! , date2 : Date!) -> Bool{
    let date1Day = Calendar.current.component(.day, from: date1)
    let date1Year = Calendar.current.component(.year, from: date1)
    let date1Month = Calendar.current.component(.month, from: date1)
    
    let date2Day = Calendar.current.component(.day, from: date2)
    let date2Year = Calendar.current.component(.year, from: date2)
    let date2Month = Calendar.current.component(.month, from: date2)
    
    if (date1Day ==  date2Day && date1Year == date2Year && date1Month == date2Month){
        return true
    }
    else{
        return false
    }
}

//func stringToDate(str:String)-> Date{
//    let dateFormatter = DateFormatter()
//    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
//    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//    let date = dateFormatter.date(from: str)
//    return date ?? Date()
//}

//MARK:- No data found

func showNoDataFoundMessage(strMessage: String, In view: UIView, atYPositionDeltaFromCenter: Int, withFontName font: UIFont)
{
    let yPosDeltaFromCenter = CGFloat(atYPositionDeltaFromCenter)
    
    
    let noDataFoundView: UIView = UIView(frame: CGRect(x: 15, y: yPosDeltaFromCenter, width: view.frame.size.width - 30, height: view.frame.size.height - yPosDeltaFromCenter))
    
    
    noDataFoundView.tag = -9999
    //nomatchesView.backgroundColor = [UIColor clearColor];
    let matchesLabel: UILabel = UILabel(frame: noDataFoundView.frame)
    matchesLabel.font = font
    matchesLabel.numberOfLines = 0
    matchesLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    matchesLabel.shadowColor = UIColor.lightGray
    matchesLabel.textColor = UIColor.lightGray
    matchesLabel.shadowOffset = CGSize(width: 0, height: 0)
    matchesLabel.backgroundColor = UIColor.clear
    matchesLabel.textAlignment = .center
    //Here is the text for when there are no results
    matchesLabel.text = strMessage
    noDataFoundView.addSubview(matchesLabel)
    
    if(view  is UITableView) {
        let tblView: UITableView = (view as! UITableView)
        tblView.backgroundView = noDataFoundView
    }
    else
    {
        if(view is UICollectionView)
        {
            let colView: UICollectionView = (view as! UICollectionView)
            colView.backgroundView = noDataFoundView
        }
    }
}
func removeNoDataFoundViewFrom(view: UIView) {
    
    if(view is UITableView)
    {
        let tblView: UITableView = (view as! UITableView)
        let noDataFoundView: UIView? = tblView.backgroundView?.viewWithTag(-9999)
        if noDataFoundView != nil {
            tblView.backgroundView = nil
        }
    }
    else {
        if(view is UICollectionView) {
            let colView: UICollectionView = (view as! UICollectionView)
            let noDataFoundView: UIView? = colView.backgroundView?.viewWithTag(-9999)
            if noDataFoundView != nil {
                colView.backgroundView = nil
            }
        }
    }
}

//MARK:- Loading
func showLoader(inView view:UIView) {
    
    let viewProgress = UIView(frame: view.bounds)
    viewProgress.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    let indicator = UIActivityIndicatorView(frame: viewProgress.bounds)
    indicator.style = UIActivityIndicatorView.Style.medium
    indicator.hidesWhenStopped = true
    indicator.startAnimating()
    viewProgress.addSubview(indicator)
    viewProgress.tag = -9999
    view.addSubview(viewProgress)
}
func hideLoader() {
    
    if let window = UIApplication.shared.delegate?.window {
        hideLoader(inView: window!)
    }
}

func hideLoader(inView view:UIView) {
    let viewProgress = view.viewWithTag(-9999)
    if (viewProgress != nil) {
        viewProgress?.removeFromSuperview()
    }
}


//MARK: - Load More Activity
func loadActivityIndicator(v: UIView) -> (UIActivityIndicatorView){
    let activityLoader: UIActivityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    let height: CGFloat = v.frame.size.height-30
    // Position Activity Indicator in the center of the main view
    activityLoader.center = CGPoint(x: screenWidth/2, y:height)
    activityLoader.tintColor = UIColor.black
    activityLoader.color = UIColor.black
    
    // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
    activityLoader.hidesWhenStopped = true
    
    // Call stopAnimating() when need to stop activity indicator
    activityLoader.stopAnimating()
    
    v.superview?.addSubview(activityLoader)
    
    return activityLoader
    
}

func showActivityIndicator(tag: Int, view: UIView) -> (UIActivityIndicatorView) {
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
    activityIndicator.alpha = 1.0
    activityIndicator.tag = tag
    activityIndicator.color = UIColor.black
    view.addSubview(activityIndicator)
    DispatchQueue.main.async {
        activityIndicator.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
    }
    activityIndicator.startAnimating()
    return activityIndicator
}


func isInternetAvailable() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = flags.contains(.reachable)
    let needsConnection = flags.contains(.connectionRequired)
    return (isReachable && !needsConnection)
}


func changeStatusBarColor(view:UIView,color:UIColor){
    
    let color = UIColor(red: 76/255.0, green: 130/255.0, blue: 216/255.0, alpha: 1.0)
    if #available(iOS 13.0, *) {
        let app = UIApplication.shared
        let statusBarHeight: CGFloat = app.statusBarFrame.size.height
        
        let statusbarView = UIView()
        statusbarView.backgroundColor = color
        view.addSubview(statusbarView)
        
        statusbarView.translatesAutoresizingMaskIntoConstraints = false
        statusbarView.heightAnchor
            .constraint(equalToConstant: statusBarHeight).isActive = true
        statusbarView.widthAnchor
            .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
        statusbarView.topAnchor
            .constraint(equalTo: view.topAnchor).isActive = true
        statusbarView.centerXAnchor
            .constraint(equalTo: view.centerXAnchor).isActive = true
        
    }else {
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = color
    }
}

//profile image
func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
    let size = image.size
    
    let widthRatio  = targetSize.width  / size.width
    let heightRatio = targetSize.height / size.height
    
    // Figure out what our orientation is, and use that to form the rectangle
    var newSize: CGSize
    if(widthRatio > heightRatio) {
        newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
    } else {
        newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
    }
    // This is the rect that we've calculated out and this is what is actually used below
    let rect = CGRect(origin: .zero, size: newSize)
    
    // Actually do the resizing to the rect using the ImageContext stuff
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    image.draw(in: rect)
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return newImage
}


func scaleAnimation(btn:UIButton){
    UIView.animate(withDuration: 0.2,
                   animations: {
        btn.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
    },
                   completion: { _ in
        btn.isSelected = !btn.isSelected
        UIView.animate(withDuration: 0.2) {
            btn.transform = CGAffineTransform.identity
        }
    })
}

// for 2 multi color text attribited string
//func multiColorFontStringFor2(str1:String,str2:String,str1FontSize:CGFloat,str2FontSize:CGFloat,str1Color:UIColor,str2Color:UIColor,str1Font:String,str2Font:String,str1BgColor:UIColor = color_white,str2BgColor:UIColor = color_white,lineSpacing:CGFloat)-> NSMutableAttributedString {
//
//    let attrs1 = [NSAttributedString.Key.font : UIFont(name: str1Font, size: CGFloat(str1FontSize))!, NSAttributedString.Key.foregroundColor : str1Color] as [AnyHashable : Any]
//
//    let attrs2 = [NSAttributedString.Key.font : UIFont(name: str2Font,  size: CGFloat(str2FontSize))!, NSAttributedString.Key.foregroundColor : str2Color] as [AnyHashable : Any]
//
//    let attributedString1 = NSMutableAttributedString(string:str1, attributes:attrs1 as? [NSAttributedString.Key : Any])
//
//    let attributedString2 = NSMutableAttributedString(string:str2, attributes:attrs2 as? [NSAttributedString.Key : Any])
//
//    attributedString1.addAttribute(NSAttributedString.Key.backgroundColor, value: str1BgColor, range: NSMakeRange(0, attributedString1.length))
//    attributedString2.addAttribute(NSAttributedString.Key.backgroundColor, value: str2BgColor, range: NSMakeRange(0, attributedString2.length))
//
//    attributedString1.append(attributedString2)
//
//    let paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.lineSpacing = lineSpacing
//
//    attributedString1.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString1.length))
//
//    return attributedString1
//}
// for 3 multi color text attribited string

//func multiColorFontStringFor3(_ str1:String,_ str2:String,_ str3:String,_ str1FontSize:Int,_ str2FontSize:Int,_ str3FontSize:Int,_ str1Color:UIColor,_ str2Color:UIColor,_ str3Color:UIColor,_ str1Font:String,_ str2Font:String,_ str3Font:String,_ lineSpacing:CGFloat)-> NSMutableAttributedString {
//
//    let attrs1 = [NSAttributedString.Key.font : UIFont(name: str1Font, size: CGFloat(str1FontSize))!, NSAttributedString.Key.foregroundColor : str1Color] as [AnyHashable : Any]
//
//    let attrs2 = [NSAttributedString.Key.font : UIFont(name: str2Font,  size: CGFloat(str2FontSize))!, NSAttributedString.Key.foregroundColor : str2Color] as [AnyHashable : Any]
//
//    let attrs3 = [NSAttributedString.Key.font : UIFont(name: str3Font,  size: CGFloat(str3FontSize))!, NSAttributedString.Key.foregroundColor : str3Color] as [AnyHashable : Any]
//
//    let attributedString1 = NSMutableAttributedString(string:str1, attributes:attrs1 as? [NSAttributedString.Key : Any])
//
//    let attributedString2 = NSMutableAttributedString(string:str2, attributes:attrs2 as? [NSAttributedString.Key : Any])
//
//    let attributedString3 = NSMutableAttributedString(string:str3, attributes:attrs3 as? [NSAttributedString.Key : Any])
//
//    attributedString1.append(attributedString2)
//    attributedString1.append(attributedString3)
//
//    let paragraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.lineSpacing = lineSpacing
//    attributedString1.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString1.length))
//
//    return attributedString1
//}

// function for header shadow

func viewShadow(view: UIView) {
    
    view.layer.masksToBounds = false
    view.layer.shadowRadius = 7
    view.layer.shadowOpacity = 0.5
    view.layer.shadowColor = UIColor.lightGray.cgColor
    view.layer.shadowOffset = CGSize(width: 0 , height:0)
}

func homeCardShadow(view:UIView){
    view.layer.masksToBounds = false
    view.layer.shadowRadius = 10
    view.layer.shadowOpacity = 0.1
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOffset = CGSize(width: 5 , height:0)
}

func headerShadow(view:UIView, shadowRadius:CGFloat = 1.5, shadowOpacity:Float = 0.2){
    
    view.layer.masksToBounds = false
    view.layer.shadowRadius = shadowRadius
    view.layer.shadowOpacity = shadowOpacity
    view.layer.shadowColor = UIColor.lightGray.cgColor
    view.layer.shadowOffset = CGSize(width: 0 , height:1)
}

//func headerShadowGroupDetail(view:UIView){
//
//    view.layer.masksToBounds = false
//    view.layer.shadowRadius = 6
//    view.layer.shadowOpacity = 0.8
//    view.layer.shadowColor = UIColor.lightGray.cgColor
//    view.layer.shadowOffset = CGSize(width: 0 , height:1)
//}

// top side shadow of bottom view
func bottomViewShadow(view:UIView){
    let shadowSize: CGFloat = 10
    let contactRect = CGRect(x: -shadowSize, y: 0, width: view.frame.size.width + shadowSize * 2, height: shadowSize)
    view.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
    
    view.layer.shadowOpacity = 0.2
    //    view.layer.shadowOffset = CGSize(width: 0, height: -4)
    view.layer.shadowRadius = 5
    view.layer.shadowColor = UIColor.gray.cgColor
}

// placeholder for textview
func textviewPlaceholder(txtView : UITextView , placeholderLabel: UILabel, placeholderText: String){
    //    placeholderLabel = UILabel()
    placeholderLabel.text = placeholderText
    placeholderLabel.font = UIFont(name:fonts.regular,size:17)
    placeholderLabel.sizeToFit()
    txtView.addSubview(placeholderLabel)
    placeholderLabel.frame.origin = CGPoint(x: 5, y: (txtView.font?.pointSize) ?? 10 / 2)
    placeholderLabel.textColor = UIColor.red
    placeholderLabel.isHidden = !txtView.text.isEmpty
}

//get labelHeight
func getLabelHeight(str:String,width:CGFloat,font:String,font_size:CGFloat,numberOfLines:Int,lineSpacing:CGFloat)->CGFloat{
    
    let label = UILabel(frame: CGRect.zero)
    label.text = str
    label.font = UIFont(name: font , size: font_size)
    label.numberOfLines = numberOfLines
    label.lineSpacing(spacingValue: lineSpacing)
    label.sizeToFit()
    
    let labelHeight = label.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
    
    return labelHeight
}

// custom corner radius on different edges
extension UIView{
    func roundCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){
        
        self.init()
        
        let path = CGMutablePath()
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }
        
        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }
        
        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }
        
        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        path.closeSubpath()
        cgPath = path
    }
}

// validate pan card
func validatePanCard(panCardNo: String) -> Bool{
    let panCardRegex = "[A-Z]{5}[0-9]{4}[A-Z]{1}"
    let panNumber = NSPredicate(format:"SELF MATCHES %@", panCardRegex)
    return panNumber.evaluate(with: panCardNo)
}

func validateGSTNumber(gstNo:String) -> Bool {
    let gstRegex = "^[0-9]{2}[A-Za-z]{5}[0-9]{4}[A-Za-z]{1}[1-9A-Za-z]{1}Z[0-9A-Za-z]{1}"
    let string = NSPredicate(format:"SELF MATCHES %@", gstRegex)
    return string.evaluate(with: gstNo)
}

func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}

// MARK: - popupmenu  Implementation
//func openDropDownMenuCheck(_ sender: UIView,itemList:Array<Any>,itemWidth:CGFloat){
//    YBPopupMenu.showRely(on: sender, titles: itemList, icons: nil, menuWidth: itemWidth) { (popupMenu) in
//
//        //        popupMenu?.delegate =
//        popupMenu?.priorityDirection = YBPopupMenuPriorityDirection.top
//        popupMenu?.dismissOnSelected = true
//        popupMenu?.isShadowShowing = true
//        popupMenu?.layer.cornerRadius = 4 //0.07 * popupMenu!.bounds.size.width
//        popupMenu?.layer.shadowColor = UIColor.black.cgColor
//        popupMenu?.layer.shadowOpacity = 0.3
//        popupMenu?.layer.shadowOffset = .zero
//        popupMenu?.layer.shadowRadius = 3
//        popupMenu?.itemHeight = 43
//        popupMenu?.rectCorner = UIRectCorner(rawValue: UIRectCorner.bottomRight.rawValue | UIRectCorner.bottomLeft.rawValue | UIRectCorner.topLeft.rawValue | UIRectCorner.topRight.rawValue)
//        popupMenu?.maxVisibleCount = itemList.count
//        popupMenu?.textColor = color_gray_70
//        popupMenu?.font = UIFont(name: APP_FONT_Regular, size: 15)
//        popupMenu?.backColor = .white
//    }
//}

// call redirection
func openCallDialer(_ number:String){
    if let url = NSURL(string: ("tel:" + number)) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url as URL)
        }
    }
}

// Email redirection
func emailRedirection(emailID:String){
    
    if let url = URL(string: "mailto:\(emailID)") {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

// Safari redirection
func OpenBrowser(withUrl urlString:String){
    
    if let url = URL(string: "\(urlString)") {
        UIApplication.shared.open(url)
    }
}

//func print(_ items: Any...) {
////    #if DEBUG
//        Swift.print(items[0])
////    #endif
//}

//func todayYesterdayValue(dateStr: String) -> String?{
//
//    let calendar = Calendar.current
//
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"
//    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//
//    let date = dateFormatter.date(from: dateStr)
//    dateFormatter.timeZone = TimeZone.current
//    dateFormatter.dateFormat = "dd MMM yy"
//
//    if let date = date{
////        dateFormatter.timeZone = TimeZone.current
//        if calendar.isDateInYesterday(date){
//            return "Yesterday"
//        }
//        else if calendar.isDateInToday(date){
////            dateFormatter.dateFormat = "dd MMM yy"
//            return "Today"
//        }
//        else{
//            dateFormatter.dateFormat = "dd MMM yy, hh:mm aa"
//            return dateFormatter.string(from: date)
//        }
//    }
//    return nil
//}


//func todayYesterday(dateStr: String) -> String?{
//
//    let calendar = Calendar.current
//
//    let dateFormatter = DateFormatter()
//    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"
//    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//
//    if let date = dateFormatter.date(from: dateStr) {
//        dateFormatter.timeZone = TimeZone.current
//        if calendar.isDateInYesterday(date){
//            dateFormatter.dateFormat = "hh:mm aa"
//            return "Yesterday, \(dateFormatter.string(from: date))"
//        }
//        else if calendar.isDateInToday(date){
//            dateFormatter.dateFormat = "hh:mm aa"
//            return "Today, \(dateFormatter.string(from: date))"
//        }
//        else{
//            dateFormatter.dateFormat = "dd MMM yy, hh:mm aa"
//            return dateFormatter.string(from: date)
//        }
//    }
//    return nil
//}

func todayYesterdayFunc(dateStr: String) -> String?{
    let calendar = Calendar.current
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = eDateFormats.def.rawValue//"yyyy-MM-dd'T'hh:mm:ss.SSS'Z'"//"yyyy-MM-dd'T'HH:mm:ss.S'Z'"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    if let date = dateFormatter.date(from: dateStr) {
        dateFormatter.timeZone = TimeZone.current
        if calendar.isDateInYesterday(date){
            dateFormatter.dateFormat = "hh:mm aa"
            return "Yesterday, \(dateFormatter.string(from: date))"
        }
        else if calendar.isDateInToday(date){
            dateFormatter.dateFormat = "hh:mm aa"
            return "Today, \(dateFormatter.string(from: date))"
        }
        else{
            dateFormatter.dateFormat = "dd MMM yyyy"//dd MMM yyyy, hh:mm aa
            return dateFormatter.string(from: date)
        }
    }
    return nil
}

// get today yesterday from date
func dayDifference(from date : String)-> String?
{
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"//"yyyy-MM-dd'T'HH:mm:ss.S'Z'"
    //    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    //    dateFormatter.timeZone = TimeZone.current
    
    //    let dateInDate = dateFormatter.date(from:date)!
    //    dateFormatter.dateFormat = "hh:mm aa"
    //    dateFormatter.string(from: dateInDate)
    
    
    let date = dateFormatter.date(from: date)
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "dd MMM yy"
    
    if let date = date{
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        else if calendar.isDateInToday(date) { return "Today" }
        else{
            dateFormatter.dateFormat = "dd MMM yy"
            return dateFormatter.string(from: date)
        }
    }
    return nil
    //    else if calendar.isDateInTomorrow(dateInDate) { return "Tomorrow" }
    //    else {
    //        let startOfNow = calendar.startOfDay(for: Date())
    //        let startOfTimeStamp = calendar.startOfDay(for: dateInDate)
    //        let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
    //        let day = components.day!
    //        if day < 1 { return "\(-day) days ago" }
    //        else { return "In \(day) days" }
    //    }
}

// time conversion from utc to local of date and time
func utcToLocalDateTime(dateStr: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"//"yyyy-MM-dd'T'HH:mm:ss.sss'Z'"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    if let date = dateFormatter.date(from: dateStr) {
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd MMM yy, hh:mm aa"
        
        return dateFormatter.string(from: date)
    }
    return nil
}

// time conversion from utc to local of only date
func utcToLocalDate(dateStr: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.S'Z'"//"yyyy-MM-dd'T'HH:mm:ss.sss'Z'"
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    
    if let date = dateFormatter.date(from: dateStr) {
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "dd MMM yy"
        
        return dateFormatter.string(from: date)
    }
    return nil
}

// button touch effect
func setBtnTouchEffect(btn:UIButton, color:UIColor = UIColor.red){
    
    let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
    colorAnimation.fromValue = color.cgColor
    colorAnimation.duration = 0.3  // animation duration
    btn.layer.add(colorAnimation, forKey: "ColorPulse")
}

// circle view
func circularView1(to view:UIView){
    view.layer.cornerRadius = view.frame.size.width/2
}

// circle label
func circularLabel(label:UILabel){
    label.layer.cornerRadius = label.frame.size.width/2
    label.clipsToBounds = true
}

func setUserDafault(key: String, value: Any){
    UserDefaults.standard.set(value, forKey: key)
    UserDefaults.standard.synchronize()
}

// open url or userprofile
//func openUrl(url:URL){
//
//    let strUrl = url.absoluteString
//
//    if strUrl.contains("https://") || strUrl.contains("http://"){
//        let storyBoard: UIStoryboard = UIStoryboard(name: eStoryboardName.Webview.rawValue, bundle: nil)
//        let WebviewVC = storyBoard.instantiateViewController(withIdentifier: "WebviewVC") as! WebviewVC
//        WebviewVC.Url = "\(url)"
//        APP_DEL.navigationController.pushViewController(WebviewVC, animated: true)
//    }
//    else if !strUrl.contains("."){
//        let storyBoard: UIStoryboard = UIStoryboard(name: eStoryboardName.Profile.rawValue, bundle: nil)
//        let NextVC = storyBoard.instantiateViewController(withIdentifier: "UserProfileVC") as! UserProfileVC
//        //            print("__user id is:",userIdFromCreatedBy)
//        NextVC.userID = strUrl
//        NextVC.location_amplitude = "name-tagged"
//        APP_DEL.navigationController.pushViewController(NextVC, animated: true)
//    }
//    else{
//        let storyBoard: UIStoryboard = UIStoryboard(name: eStoryboardName.Webview.rawValue, bundle: nil)
//        let WebviewVC = storyBoard.instantiateViewController(withIdentifier: "WebviewVC") as! WebviewVC
//        WebviewVC.Url = "https://\(url)"
//        APP_DEL.navigationController.pushViewController(WebviewVC, animated: true)
//    }
//}


// filename and extension from string
extension String {
    
    func fileName() -> String {
        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
    }
    
    func fileExtension() -> String {
        return URL(fileURLWithPath: self).pathExtension
    }
}

//func formatDescription(description: String) -> NSAttributedString {
//    let matchedId = description.hashtagsId()
//    let matchedName = description.hashtagsName()
//
//    //        print("_________________data.post?.isReadmore__________", data.post?.isReadmore)
//
//    let actualString = description.convertHtmlToAttributedStringWithCSS(font: UIFont(name: APP_FONT_Regular , size: 17), csscolor: "#464646", lineheight: 4, csstextalign: "left")//4C82D8
//
//    let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.maximumLineHeight = 22.0
//    paragraphStyle.minimumLineHeight = 22.0
//
//    let attributedString = NSMutableAttributedString(string: actualString!.string , attributes: [
//        .font: UIFont(name: APP_FONT_Regular, size: 17)!,
//        .foregroundColor: color_gray_70, NSAttributedString.Key.paragraphStyle : paragraphStyle])
//
//    for (index, element) in matchedName.enumerated() {
//        let name = String(element.dropFirst(2)).trimmingCharacters(in: .whitespacesAndNewlines)
//        let id = String(matchedId[index].dropFirst(6))
//        let foundRange = attributedString.mutableString.range(of: name)
//        attributedString.addAttribute(NSAttributedString.Key.link, value: id, range: foundRange)
//        attributedString.addAttribute(.font, value: UIFont(name: APP_FONT_Regular, size: 17)!, range: foundRange)
//    }
//
//    //    if(description.count == 300 && description.hasSuffix("Readmore") && attributedString.string.count > 8){
//    //        let foundRange = NSRange(location: attributedString.string.count - 8, length: 8)
//    ////            let foundRange = attributedString.mutableString.range(of: "Readmore")
//    //        attributedString.addAttribute(.font, value: UIFont(name: APP_FONT_Regular, size: 17)!, range: foundRange)
//    //        attributedString.addAttribute(.foregroundColor, value: color_149, range: foundRange)
//    //    }
//
//    return attributedString
//}
//func formatDescriptionReadmore() -> NSAttributedString {
//
//    let paragraphStyle: NSMutableParagraphStyle = NSMutableParagraphStyle()
//    paragraphStyle.maximumLineHeight = 22.0
//    paragraphStyle.minimumLineHeight = 22.0
//
//    let readMore = NSMutableAttributedString(string: " ... Read More" , attributes: [
//        .font: UIFont(name: APP_FONT_Regular, size: 17)!,
//        .foregroundColor: color_gray_70, NSAttributedString.Key.paragraphStyle : paragraphStyle])
//    let foundRange = readMore.mutableString.range(of: "Read More")
//    readMore.addAttribute(.font, value: UIFont(name: APP_FONT_Regular, size: 17)!, range: foundRange)
//    readMore.addAttribute(.foregroundColor, value: color_149, range: foundRange)
//
//    return readMore
//}

// Convert time type minutes to seconds
func timeFormatted(_ totalSeconds: Int) -> String {
    let seconds: Int = totalSeconds % 60
    let minutes: Int = (totalSeconds / 60) % 60
    return String(format: "%02d:%02d", minutes, seconds)
}

// open webview

//func openWebview(_ url: String){
//
//    let storyBoard: UIStoryboard = UIStoryboard(name: eStoryboardName.Webview.rawValue, bundle: nil)
//    let WebviewVC = storyBoard.instantiateViewController(withIdentifier: "WebviewVC") as! WebviewVC
//    if url.contains("https://") || url.contains("http://"){
//        WebviewVC.Url = "\(url)"
//    }
//    else{
//        WebviewVC.Url = "https://\(url)"
//    }
//    APP_DEL.navigationController.pushViewController(WebviewVC, animated: true)
//}


func getMimeType(path: String) -> String {
    let url = NSURL(fileURLWithPath: path)
    let pathExtension = url.pathExtension
    
    if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension! as NSString, nil)?.takeRetainedValue() {
        if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
            return mimetype as String
        }
    }
    return "application/octet-stream"
}

// open safari browser
func openSafari(urlStr: String){
    if let url = URL(string: urlStr) {
        UIApplication.shared.open(url)
    }
}

// show svprogresshud loader
func startLoader(){
    
//    SVProgressHUD.setDefaultStyle(.dark)
//    SVProgressHUD.setDefaultMaskType(.custom)
//    SVProgressHUD.setBackgroundColor(.clear)
//    SVProgressHUD.show()
}

func stopLoader(){
    
//    SVProgressHUD.dismiss()
}

//extension UILabel {
func setHTMLFromString(htmlText: String) -> NSAttributedString {
    
    let modifiedFont = String(format:"<span style=\"font-family: 'Matter'; line-height:14pt ; font-weight:400; color: #727272 ; font-size: 14\">%@</span>", htmlText)
    //; font-weight:400
    //    ; font-style:italic
    
    let attrStr = try! NSAttributedString(
        data: modifiedFont.data(using: .unicode, allowLossyConversion: true)!,
        options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue],
        documentAttributes: nil)
    
    //        self.attributedText = attrStr
    return attrStr
}
//}


func multiColorFontStringFor2(s1:String,
                              s2:String,
                              s1FontSize:CGFloat = fSize.f14,
                              s2FontSize:CGFloat = fSize.f14,
                              s1Color:UIColor = Colors.fontBlack,
                              s2Color:UIColor = Colors.fontBlack,
                              s1Font:String = fonts.medium,
                              s2Font:String = fonts.medium,
                              lineSpacing:CGFloat = 4,
                              lineMultipleHeight: CGFloat = 0)-> NSMutableAttributedString {
    
    let attrs1 = [NSAttributedString.Key.font : UIFont(name: s1Font, size: CGFloat(s1FontSize))!, NSAttributedString.Key.foregroundColor : s1Color] as [AnyHashable : Any]
    
    let attrs2 = [NSAttributedString.Key.font : UIFont(name: s2Font,  size: CGFloat(s2FontSize))!, NSAttributedString.Key.foregroundColor : s2Color] as [AnyHashable : Any]
        
    let attributedString1 = NSMutableAttributedString(string:s1, attributes:attrs1 as? [NSAttributedString.Key : Any])
    
    let attributedString2 = NSMutableAttributedString(string:s2, attributes:attrs2 as? [NSAttributedString.Key : Any])
        
    attributedString1.append(attributedString2)
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    if lineMultipleHeight != 0{
        paragraphStyle.lineHeightMultiple = lineMultipleHeight
    }
    attributedString1.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString1.length))
    
    return attributedString1
}


func multiColorFontStringFor3(s1:String,
                              s2:String,
                              s3:String,
                              s1FontSize:CGFloat = fSize.f14,
                              s2FontSize:CGFloat = fSize.f14,
                              s3FontSize:CGFloat = fSize.f14,
                              s1Color:UIColor = Colors.orange,
                              s2Color:UIColor = Colors.orange,
                              s3Color:UIColor = Colors.orange,
                              s1Font:String = fonts.medium,
                              s2Font:String = fonts.medium,
                              s3Font:String = fonts.medium,
                              lineSpacing:CGFloat = 4)-> NSMutableAttributedString {
    
    let attrs1 = [NSAttributedString.Key.font : UIFont(name: s1Font, size: CGFloat(s1FontSize))!, NSAttributedString.Key.foregroundColor : s1Color] as [AnyHashable : Any]
    
    let attrs2 = [NSAttributedString.Key.font : UIFont(name: s2Font,  size: CGFloat(s2FontSize))!, NSAttributedString.Key.foregroundColor : s2Color] as [AnyHashable : Any]
    
    let attrs3 = [NSAttributedString.Key.font : UIFont(name: s3Font,  size: CGFloat(s3FontSize))!, NSAttributedString.Key.foregroundColor : s3Color] as [AnyHashable : Any]
    
    let attributedString1 = NSMutableAttributedString(string:s1, attributes:attrs1 as? [NSAttributedString.Key : Any])
    
    let attributedString2 = NSMutableAttributedString(string:s2, attributes:attrs2 as? [NSAttributedString.Key : Any])
    
    let attributedString3 = NSMutableAttributedString(string:s3, attributes:attrs3 as? [NSAttributedString.Key : Any])
    
    attributedString1.append(attributedString2)
    attributedString1.append(attributedString3)
    
    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    attributedString1.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString1.length))
    
    return attributedString1
}

//func returnFont(type: fonts = .medium, size: fSize = .f14) -> UIFont{
//    
//    return UIFont(name: type, size: size)
//}

func isRTL() -> Bool{
    
    if UIApplication.shared.userInterfaceLayoutDirection == UIUserInterfaceLayoutDirection.rightToLeft {
        return true
    }
    else{
        return false
    }
}

func getMinuteDifference(dateFormat: String = eDateFormats.def.rawValue, targetDate: String) -> Int{
    
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
    dateFormatter.dateFormat = dateFormat
    let targetDateString = targetDate

    if let targetDate = dateFormatter.date(from: targetDateString) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.minute], from: targetDate, to:Date() )

        if let minuteDifference = components.minute {
            print("Difference in minutes: \(minuteDifference)")
            return minuteDifference
            
        } else {
            print("Unable to calculate the difference in minutes.")
            return 0
        }
    } else {
        print("Invalid target date format.")
        return 0
    }
}

func openGoogleMaps(latitude: Double, longitude: Double) {
    
    if let url = URL(string: "comgooglemaps://?center=\(latitude),\(longitude)") {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // If Google Maps app is not installed, open in Safari
            let safariURL = URL(string: "https://www.google.com/maps/search/?api=1&query=\(latitude),\(longitude)")!
            UIApplication.shared.open(safariURL, options: [:], completionHandler: nil)
        }
    }
}

func PlaySound(of sound: eSounds = .bubble) {
    
    if let soundFilePath = Bundle.main.path(forResource: sound.rawValue, ofType: "mp3") {
        let soundFileURL = URL(fileURLWithPath: soundFilePath)
        
        do {
            var audioPlayer: AVAudioPlayer?
            
            // Initialize the AVAudioPlayer with the sound file URL
//            audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL)
            audioPlayer = try AVAudioPlayer.init(contentsOf: soundFileURL)
            audioPlayer?.prepareToPlay()
            
            // Play the sound
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    } else {
        print("Sound file not found.")
    }
}


func getDeviceUUID() -> String? {
    let identifier = UIDevice.current.identifierForVendor?.uuidString
    return identifier
}

func getDeviceOSVersion() -> String {
    let device = UIDevice.current
    let systemVersion = device.systemVersion
    return systemVersion
}

func getDeviceModel() -> String {
    let device = UIDevice.current
    let deviceModel = device.model
    return deviceModel
    
//    var systemInfo = utsname()
//    uname(&systemInfo)
//
//    let machineMirror = Mirror(reflecting: systemInfo.machine)
//    let machineIdentifier = machineMirror.children.reduce("") { identifier, element in
//        guard let value = element.value as? Int8, value != 0 else { return identifier }
//        return identifier + String(UnicodeScalar(UInt8(value)))
//    }
//
//    return machineIdentifier
}

// to get device model
public extension UIDevice {
    var identifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let modelCode = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                ptr in String.init(validatingUTF8: ptr)
            }
        }
        if modelCode == "x86_64" {
            if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                if let simMap = String(validatingUTF8: simModelCode) {
                    return simMap
                }
            }
        }
        return modelCode ?? "?unrecognized?"
    }
}
class WikiDevice {
    static func model(_ completion: @escaping ((String) -> ())){
        let unrecognized = "?unrecognized?"
        guard let wikiUrl=URL(string:"https://www.theiphonewiki.com//w/api.php?action=parse&format=json&page=Models") else { return completion(unrecognized) }
        var identifier: String {
            var systemInfo = utsname()
            uname(&systemInfo)
            let modelCode = withUnsafePointer(to: &systemInfo.machine) {
                $0.withMemoryRebound(to: CChar.self, capacity: 1) {
                    ptr in String.init(validatingUTF8: ptr)
                }
            }
            if modelCode == "x86_64" {
                if let simModelCode = ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] {
                    if let simMap = String(validatingUTF8: simModelCode) {
                        return simMap
                    }
                }
            }
            return modelCode ?? unrecognized
        }
        guard identifier != unrecognized else { return completion(unrecognized)}
        let request = URLRequest(url: wikiUrl)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do {
                guard let data = data,
                    let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode,
                    error == nil else { return completion(unrecognized) }
                guard let convertedString = String(data: data, encoding: String.Encoding.utf8) else { return completion(unrecognized) }
                var wikiTables = convertedString.components(separatedBy: "wikitable")
                wikiTables.removeFirst()
                var tables = [[String]]()
                wikiTables.enumerated().forEach{ index,table in
                    let rawRows = table.components(separatedBy: #"<tr>\n<td"#)
                    var counter = 0
                    var rows = [String]()
                    while counter < rawRows.count {
                        let rawRow = rawRows[counter]
                        if let subRowsNum = rawRow.components(separatedBy: #"rowspan=\""#).dropFirst().compactMap({ sub in
                            (sub.range(of: #"\">"#)?.lowerBound).flatMap { endRange in
                                String(sub[sub.startIndex ..< endRange])
                            }
                        }).first {
                            if let subRowsTot = Int(subRowsNum) {
                                var otherRows = ""
                                for i in counter..<counter+subRowsTot {
                                    otherRows += rawRows[i]
                                }
                                let row = rawRow + otherRows
                                rows.append(row)
                                counter += subRowsTot-1
                            }
                        } else {
                            rows.append(rawRows[counter])
                        }
                        counter += 1
                    }
                    tables.append(rows)
                }
                for table in tables {
                    if let rowIndex = table.firstIndex(where: {$0.lowercased().contains(identifier.lowercased())}) {
                        let rows = table[rowIndex].components(separatedBy: "<td>")
                        if rows.count>0 {
                            if rows[0].contains("title") { //hyperlink
                                if let (cleanedGen) = rows[0].components(separatedBy: #">"#).dropFirst().compactMap({ sub in
                                    (sub.range(of: "</")?.lowerBound).flatMap { endRange in
                                        String(sub[sub.startIndex ..< endRange]).replacingOccurrences(of: #"\n"#, with: "")
                                    }
                                }).first {
                                    completion(cleanedGen)
                                }
                            } else {
                                let raw = rows[0].replacingOccurrences(of: "<td>", with: "")
                                let cleanedGen = raw.replacingOccurrences(of: #"\n"#, with: "")
                                completion(cleanedGen)
                            }
                            return
                        }
                    }
                }
                completion(unrecognized)
            }
        }.resume()
    }
}

func openWhatsapp(_ number:String){
    // Check if WhatsApp is installed
    if let whatsappURL = URL(string: "https://wa.me/\(number)") {
        if UIApplication.shared.canOpenURL(whatsappURL) {
            // Open WhatsApp
            UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
        } else {
            // WhatsApp is not installed, handle accordingly
            print("WhatsApp is not installed on the device.")
        }
    }
}
