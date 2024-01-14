//
//  Extensions.swift
//  
//
//  Created by  Mac on 08/01/21.
//  Copyright © 2021  Tech. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import MobileCoreServices
import Photos
import Alamofire
import SDWebImage


// set view line on selected tab bar item
extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineHeight: CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint(x: 0,y : 0), size: CGSize(width: size.width, height: lineHeight)))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

// loading indicator in center of imageview till image set out
extension UIImageView {
    func setImages(url:String,placeholderImage:String? = nil, contentMode: ContentMode = .scaleAspectFill){
        
        //        self.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage)
        //        self.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage, options: SDWebImageOptions.lowPriority)
        
        
        let activityInd = UIActivityIndicatorView()
        DispatchQueue.main.async {
            activityInd.center = CGPoint(x: self.frame.size.width  / 2,
                                         y: self.frame.size.height / 2)
        }
        activityInd.color = Colors.primary
        self.addSubview(activityInd)
        activityInd.startAnimating()
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: placeholderImage ?? ""), options: SDWebImageOptions.lowPriority) { _,_,_,_ in
            activityInd.stopAnimating()
            activityInd.removeFromSuperview()
        }
        
        self.contentMode = contentMode
    }
}

//line spacing
extension UITextView {
    
    func addHyperLinksToText(originalText: String, hyperLinks: [String: String]) {
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        for (hyperLink, urlString) in hyperLinks {
            let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
            let fullRange = NSRange(location: 0, length: attributedOriginalText.length)
            attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: fonts.regular, range: fullRange)
        }
        
        self.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.blue,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
        ]
        
        self.attributedText = attributedOriginalText
    }
    
    // MARK: - spacingValue is spacing that you need
    func lineSpacing(spacingValue: CGFloat = 4) {
        
        // MARK: - Check if there's any text
        guard let textString = text else { return }
        
        // MARK: - Create "NSMutableAttributedString" with your text
        let attributedString = NSMutableAttributedString(string: textString)
        
        // MARK: - Create instance of "NSMutableParagraphStyle"
        let paragraphStyle = NSMutableParagraphStyle()
        
        // MARK: - Actually adding spacing we need to ParagraphStyle
        paragraphStyle.lineSpacing = spacingValue
        paragraphStyle.lineHeightMultiple = 0.5
        
        // MARK: - Adding ParagraphStyle to your attributed String
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
                          ))
        
        // MARK: - Assign string that you've modified to current attributed Text
        attributedText = attributedString
    }
    
}

extension UIView {
    
    func cellShadow( shadowRadius: CGFloat = 3, shadowOpacity: Float = 0.1){
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height:1)
    }
    
    func cardShadow(shadowRadius: CGFloat = 10,
                       shadowOffsetWidth: Double = 5,
                       shadowColor: UIColor = UIColor.black) {
        //Remove previous shadow views
        superview?.viewWithTag(119900)?.removeFromSuperview()
        
        //Create new shadow view with frame
        let shadowView = UIView(frame: frame)
        shadowView.tag = 119900
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: 0)
        shadowView.layer.masksToBounds = false
        
        shadowView.layer.shadowOpacity = 0.1
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        shadowView.layer.rasterizationScale = UIScreen.main.scale
        shadowView.layer.shouldRasterize = true
        
        superview?.insertSubview(shadowView, belowSubview: self)
    }
    
    func setCornerRadius(_ radius: eCornerRadius = .c4) {
        self.layer.cornerRadius = radius.rawValue
        self.layer.masksToBounds = true
    }
    
    func setBorderWidth(_ width: eBorderWidth = .b1) {
        self.layer.borderWidth = width.rawValue
    }
    
//    func setBorderColor(_ color: UIColor = Colors.primary) -> self.layer.borderColor{
//        return self.layer.borderColor = color.cgColor
//    }
    
    func setBorderColor(_ color: UIColor? = Colors.border) {
        layer.borderColor = color?.cgColor
    }
    
    func setBorder(width: eBorderWidth = .b1, color: UIColor = Colors.border){
        
        layer.borderWidth = width.rawValue
        layer.borderColor = color.cgColor
    }
    
    func setBorderWithCorner(width: eBorderWidth = .b1, color: UIColor = Colors.border,radius: eCornerRadius = .c4){
        
        layer.borderWidth = width.rawValue
        layer.borderColor = color.cgColor
        
        layer.cornerRadius = radius.rawValue
        layer.masksToBounds = true
    }
    
    func capsuleShape(){
        layer.cornerRadius = frame.size.height/2
    }
    
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    
    
    func roundCorners(radius: CGFloat = 18, corners: CACornerMask = [.layerMaxXMinYCorner, .layerMinXMinYCorner]) {
        
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
        
    }
    
    func bottomSideShadow(){
        
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 1.5
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0 , height:1)
    }
    
    func topSideShadow(){
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: -3) // Adjust the offset to control the shadow's position
        self.layer.shadowRadius = 3
        
//        let shadowSize: CGFloat = 20
//        let contactRect = CGRect(x: -shadowSize, y: 0, width: self.frame.size.width + shadowSize * 2, height: shadowSize)
//        self.layer.shadowPath = UIBezierPath(ovalIn: contactRect).cgPath
//
//        self.layer.shadowOpacity = 0.2
//        //    view.layer.shadowOffset = CGSize(width: 0, height: -4)
//        self.layer.shadowRadius = 5
//        self.layer.shadowColor = UIColor.gray.cgColor
        
        
//        self.layer.masksToBounds = false
//        self.layer.shadowRadius = 10
//        self.layer.shadowOpacity = 1
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOffset = CGSize(width: 0 , height:10)
    }
    
    
    func hideWithAnimation(_ hidden: Bool, _ completion : @escaping()->()){
        
        UIView.transition(with: self, duration: 0.4, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
            completion()
        })
    }
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        layer.addSublayer(border)
    }
    
    func circularView(){
        
        self.layer.cornerRadius = self.frame.size.width/2
        self.clipsToBounds = true
    }
    
//    @IBInspectable var cornerRadiusV: CGFloat{
//        get {
//            return layer.cornerRadius
//        }
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
//        }
//    }
//    
//    @IBInspectable var borderWidthV: CGFloat {
//        get {
//            return layer.borderWidth
//        }
//        set {
//            layer.borderWidth = newValue
//        }
//    }
//    
//    @IBInspectable var borderColorV: UIColor?{
//        get {
//            return UIColor(cgColor: layer.borderColor!)
//        }
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//    }
//    
//    @IBInspectable var isCircularView1: Bool {
//        get {
//            return true
//        }
//        set {
//            if newValue == true{
//                layer.cornerRadius = frame.size.width/2
//                clipsToBounds = true
//                
//            }
//        }
//    }
}

extension UILabel {
    
    // MARK: - spacingValue is spacing that you need
    func lineSpacing(spacingValue: CGFloat = 4, lineMultipleHeight : CGFloat = 0, textAlignment: NSTextAlignment = .left) {
        
        // MARK: - Check if there's any text
        guard let textString = text else { return }
        
        // MARK: - Create "NSMutableAttributedString" with your text
        let attributedString = NSMutableAttributedString(string: textString)
        
        // MARK: - Create instance of "NSMutableParagraphStyle"
        let paragraphStyle = NSMutableParagraphStyle()
        
        // MARK: - Actually adding spacing we need to ParagraphStyle
        paragraphStyle.lineSpacing = spacingValue
        if lineMultipleHeight != 0{
            paragraphStyle.lineHeightMultiple = lineMultipleHeight
        }
        
        // MARK: - Adding ParagraphStyle to your attributed String
        attributedString.addAttribute(
            .paragraphStyle,
            value: paragraphStyle,
            range: NSRange(location: 0, length: attributedString.length
                          ))
        
        // MARK: - Assign string that you've modified to current attributed Text
        attributedText = attributedString
        self.textAlignment = textAlignment

    }
    
    func changeColor (fullText : String , changeText : String , textColor: UIColor = Colors.red ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: textColor , range: range)
        self.attributedText = attribute
    }
}


//MARK:Hide show tabbar with animation

//extension UITabBarController {
//    func setTabBarVisible(visible:Bool, duration: TimeInterval, animated:Bool) {
//        if (tabBarIsVisible() == visible) { return }
//        let frame = self.tabBar.frame
//        let height = frame.size.height
//        let offsetY = (visible ? -height : height)
//        
//        // animation
//        UIViewPropertyAnimator(duration: duration, curve: .linear) {
//            self.tabBar.frame.offsetBy(dx:0, dy:offsetY)
//            self.view.frame = CGRect(x:0,y:0,width: self.view.frame.width, height: self.view.frame.height + offsetY)
//            self.view.setNeedsDisplay()
//            self.view.layoutIfNeeded()
//        }.startAnimation()
//    }
//    
//    func tabBarIsVisible() ->Bool {
//        return self.tabBar.frame.origin.y < UIScreen.main.bounds.height
//    }
//}


// scroll to bottom tableview, collectionview, scrollview
extension UIScrollView {
    
    func scrollToBottom(animated: Bool) {
        if self.contentSize.height < self.bounds.size.height { return }
        let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
        self.setContentOffset(bottomOffset, animated: animated)
    }
    
    var currentPage: Int {
        return Int((self.contentOffset.x + (0.5 * self.frame.size.width)) / self.frame.width) + 1
    }
}

// Get date month year seperate using this extension
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    
    var millisecondsSince1970:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func timeAgoDisplay() -> String {
        
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.second, .minute, .hour, .day, .weekOfYear, .month, .year], from: self, to: now)
        
        if let year = components.year, year >= 1 {
            return "\(year) year\(year > 1 ? "s" : "") ago"
        }
        if let month = components.month, month >= 1 {
            return "\(month) month\(month > 1 ? "s" : "") ago"
        }
        if let week = components.weekOfYear, week >= 1 {
            return "\(week) week\(week > 1 ? "s" : "") ago"
        }
        if let day = components.day, day >= 1 {
            return "\(day) day\(day > 1 ? "s" : "") ago"
        }
        if let hour = components.hour, hour >= 1 {
            return "\(hour) hour\(hour > 1 ? "s" : "") ago"
        }
        if let minute = components.minute, minute >= 1 {
            return "\(minute) minute\(minute > 1 ? "s" : "") ago"
        }
        if let second = components.second, second >= 3 {
            return "\(second) seconds ago"
        }
        return "Just now"
        
        
        
//        let calendar = Calendar.current
//        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
//        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
//        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
//        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!
//
//        if minuteAgo < self {
//            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
//            return "\(diff) sec ago"
//        } else if hourAgo < self {
//            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
//            return "\(diff) min ago"
//        } else if dayAgo < self {
//            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
//            return "\(diff) hrs ago"
//        } else if weekAgo < self {
//            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
//            if diff > 1{
//                return "\(diff) days ago"
//            }
//            return "\(diff) day ago"
//        }
//        let diff = Calendar.current.dateComponents([.weekday], from: self, to: Date()).weekday ?? 0
//        return "\(diff) weeks ago"
    }
    
    func toString(withFormat dateFormat: eDateFormats = .yyyyMMdd) -> String{
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat.rawValue
        
        let dateString = formatter.string(from: self)
        
        return dateString
        
    }
}

// Convert object model to [string:any]
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}


extension Dictionary {
//    var queryString: String {
//        var output: String = ""
//        for (key,value) in self {
//            output +=  "\(key)=\(value)&"
//        }
//        output = String(output.dropLast())
//        return output
//    }
    
    // merge dictionaries
    func merge(dict: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
        var mutableCopy = self
        for (key, value) in dict {
            // If both dictionaries have a value for same key, the value of the other dictionary is used.
            mutableCopy[key] = value
        }
        return mutableCopy
    }
}
extension Dictionary where Key == String, Value: Any {
    var queryString : String {
        let queryItems = self.map { key, value in
            let encodedKey = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return "\(encodedKey)=\(encodedValue)"
        }
        return queryItems.joined(separator: "&")
    }
}
//extension UITabBarController {
//
//    func addSubviewToLastTabItem(_ image: UIImage) {
//
//        if let lastTabBarButton = self.tabBar.subviews.last, let tabItemImageView = lastTabBarButton.subviews.first {
//            if let accountTabBarItem = self.tabBar.items?.last {
//                accountTabBarItem.selectedImage = nil
//                accountTabBarItem.image = nil
//            }
//            let imgView = UIImageView()
//            imgView.frame = tabItemImageView.frame
//            imgView.layer.cornerRadius = tabItemImageView.frame.height/2
//            imgView.layer.masksToBounds = true
//            imgView.contentMode = .scaleAspectFill
//            imgView.clipsToBounds = true
//            imgView.image = image
//            self.tabBar.subviews.last?.addSubview(imgView)
//        }
//    }
//}


extension UITableView {
    
    func reloadRowsWithoutAnimation(to index: Int) {
        UIView.performWithoutAnimation {
            
            let indexPath = IndexPath(item: index, section: 0)
            
            let offset = self.contentOffset
            //          self.reloadSections(IndexSet(integer: section), with: .none)
            self.reloadRows(at: [indexPath], with: .automatic)
            self.contentOffset = offset
        }
    }
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = #colorLiteral(red: 0.9373082519, green: 0.9373301864, blue: 0.9373183846, alpha: 1)
        messageLabel.lineSpacing(spacingValue: 4)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: fonts.regular, size: 18)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
    
    // spinner pagination
    func startSpinner(_ spinnerColor: UIColor = Colors.primary){
        
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: self.bounds.width, height: CGFloat(44))
        spinner.color = spinnerColor
        self.tableFooterView = spinner
        self.tableFooterView?.isHidden = false
    }
    
    func stopSpinner(){
        
        self.tableFooterView?.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        self.tableFooterView?.isHidden = true
    }
    
    func reloadRowsAt(_ index:Int){
        self.reloadRows(at: [IndexPath(item: index, section: 0)], with: .fade)
    }
    
    func deleteRowAt(_ index:Int){
        self.deleteRows(at: [IndexPath(item: index, section: 0)], with: .none)
    }
    
    func scrollTableToBottom(animated: Bool = true) {
        let sections = self.numberOfSections
        let rows = self.numberOfRows(inSection: sections - 1)
        if (rows > 0){
            self.scrollToRow(at: NSIndexPath(row: rows - 1, section: sections - 1) as IndexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToRow(_ index: Int,animated: Bool = true){
        self.scrollToRow(at: IndexPath(row: index, section: 0), at: .top, animated: animated)
    }
    
    func updateHeaderViewHeight() {
        if let header = self.tableHeaderView {
            let newSize = header.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
            header.frame.size.height = newSize.height
        }
    }
}

extension UITextView {
    
    
}


extension URL {
    
    func mimeType() -> String {
        let pathExtension = self.pathExtension
        if let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, pathExtension as NSString, nil)?.takeRetainedValue() {
            if let mimetype = UTTypeCopyPreferredTagWithClass(uti, kUTTagClassMIMEType)?.takeRetainedValue() {
                return mimetype as String
            }
        }
        return "application/octet-stream"
    }
    var containsImage: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeImage)
    }
    var containsAudio: Bool {
        let mimeType = self.mimeType()
        guard let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeAudio)
    }
    var containsVideo: Bool {
        let mimeType = self.mimeType()
        guard  let uti = UTTypeCreatePreferredIdentifierForTag(kUTTagClassMIMEType, mimeType as CFString, nil)?.takeRetainedValue() else {
            return false
        }
        return UTTypeConformsTo(uti, kUTTypeMovie)
    }
    
    func generateThumbnail() -> UIImage? {
        do {
            let asset = AVURLAsset(url: self)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            
            // Swift 5.3
            let cgImage = try imageGenerator.copyCGImage(at: .zero,
                                                         actualTime: nil)
            
            return UIImage(cgImage: cgImage)
        } catch {
            print(error.localizedDescription)
            
            return nil
        }
    }
    
    func appending(_ queryItem: String, value: String?) -> URL {

        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: queryItem, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        return urlComponents.url!
    }
    
    subscript(queryParam:String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParam })?.value
    }
    
    func fileSize() -> Double {
        var fileSize: Double = 0.0
        var fileSizeValue = 0.0
        try? fileSizeValue = (self.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).allValues.first?.value as! Double?)!
        if fileSizeValue > 0.0 {
            fileSize = (Double(fileSizeValue) / (1024 * 1024)) //in Mb size
        }
        return fileSize
    }
}
extension Double {
    func toInt() -> Int {
        return Int(self)
    }
}
// Phasset filesize
extension PHAsset {
    var fileSize: Float {
        get {
            let resource = PHAssetResource.assetResources(for: self)
            let imageSizeByte = resource.first?.value(forKey: "fileSize") as? Float ?? 0
            let imageSizeMB = imageSizeByte / (1024.0*1024.0)
            return imageSizeMB
        }
    }
}

extension UICollectionView{
    
    func reloadRowAt(index:Int){
        self.reloadItems(at: [IndexPath(row: index, section: 0)])
    }
    
    func scrollToTop(to index: Int = 0){
        
        let topIndexPath = IndexPath(item: index, section: 0)
        self.scrollToItem(at: topIndexPath, at: .top, animated: true)
    }
    
}

extension UICollectionViewFlowLayout {

    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}

extension Double {
    func roundToPlaces(_ places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func numberFormatString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        
        return formattedValue
    }
    func decimalFormatString() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        let number = NSNumber(value: self)
        let formattedValue = formatter.string(from: number)!
        
        return formattedValue
    }
    
    func roundOffAndComma(toPlaces places: Int = 2) -> String{
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.locale = Locale(identifier: "en_US")
        numberFormatter.minimumFractionDigits = places
        numberFormatter.maximumFractionDigits = places // Set the maximum number of decimal places you want

        if let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) {
//            print("___formattedNumber: ",formattedNumber) // Output: 12,345.68
            return formattedNumber
        }
        else{
            return "\(self)"
        }
    }
}

extension UITextField {
    
    func restrictToNumbersAndCharacterLimit(_ string:String,_ range: NSRange ,_ charLimit:Int = 0) -> Bool{
        let aSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let compSepByCharInSet = string.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        
        let currentCharacterCount = self.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        
        if charLimit == 0{
            return string == numberFiltered
        }
        else{
            let newLength = currentCharacterCount + string.count - range.length
            
            return (string == numberFiltered) && (newLength <= charLimit)
        }
    }
    
    func restrictCharacterLimitWithDecimal(_ string:String,_ range: NSRange ,_ charLimit:Int = 10) -> Bool{
        
        if string.isEmpty { return true }   // Allow delete key anywhere!
        guard let oldText = self.text, let rng = Range(range, in: string) else {
            return true
        }
        let newText = oldText.replacingCharacters(in: rng, with: string)
        
        let isNumeric = newText.isEmpty || (Double(newText) != nil)
        
        let formatter = NumberFormatter()
        formatter.locale = .current
        let decimalPoint = formatter.decimalSeparator ?? "."
        let numberOfDots = newText.components(separatedBy: decimalPoint).count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.firstIndex(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        if newText.count == 1 && !isNumeric {   // Allow first character to be a sign or decimal point
            return CharacterSet(charactersIn: decimalPoint).isSuperset(of: CharacterSet(charactersIn: string))
        }
        
        let newLength = newText.count + string.count - range.length
        
        return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2 && (newLength <= charLimit)
    }
    
    func restrictOnlyNumbers(_ string: String) -> Bool{
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
    
}

extension UIButton{
    
    func setTouchEffect(color:UIColor = UIColor.darkGray){//color_216
        let colorAnimation = CABasicAnimation(keyPath: "backgroundColor")
        colorAnimation.fromValue = color.cgColor
        colorAnimation.duration = 0.3  // animation duration
        self.layer.add(colorAnimation, forKey: "ColorPulse")
    }
    
    func scaleAnimation(){
        UIView.animate(withDuration: 0.2,
                       animations: {
            self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        },completion: { _ in
//            self.isSelected = !self.isSelected
            UIView.animate(withDuration: 0.2) {
                self.transform = CGAffineTransform.identity
            }
        })
    }
    
    func imageTextSpacing(to spacing: CGFloat = 0) {
        
        let insetAmount = spacing / 2
        let isRTL = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft
        if isRTL {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: -insetAmount)
        } else {
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }
    
    // set content inset for button with image on right and left side with localization
    func setContentInsetForImageAndTitle(){
        if isRTL() {
            self.contentHorizontalAlignment = .right
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 10)
        }
        else{
            self.contentHorizontalAlignment = .left
            self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 40)
        }
    }
}
extension Dictionary where Key == String, Value == String {
    func toHeader() -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        for (key, value) in self  {
            headers.add(name: key, value: value)
        }
        return headers
    }
}

extension String {
    
    func height(width:CGFloat = screenWidth,
                   font: UIFont = UIFont(name: fonts.regular, size: fSize.f14)!,
                   numberOfLines:Int = 0,
                   lineSpacing:CGFloat = 3) -> CGFloat{
        
        let label = UILabel(frame: CGRect.zero)
        label.text = self
        label.font = font
        label.numberOfLines = numberOfLines
        label.lineSpacing(spacingValue: lineSpacing)
        label.sizeToFit()
        
        let labelHeight = label.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height), withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel).height
        
        return labelHeight
    }
    

    func toInt()-> Int? {
        return Int(self)
    }
    
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func validatePanCard() -> Bool{
        let panCardRegex = "[A-Z]{5}[0-9]{4}[A-Z]{1}"
        let panNumber = NSPredicate(format:"SELF MATCHES %@", panCardRegex)
        return panNumber.evaluate(with: self)
    }
    func getYoutubeID() -> String?{
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/)|(?<=shorts/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    
    func getWidth(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    
    func removeExtraSpaces() -> String {
        return self.replacingOccurrences(of: "[\\s\n]+", with: " ", options: .regularExpression, range: nil)
    }
    
    func extractUrlsFromString() -> [String] {
        
        let types: NSTextCheckingResult.CheckingType = .link
        let detector = try? NSDataDetector(types: types.rawValue)
        var urlStrings = [String]()
        
        guard let detect = detector else {
            return []
        }
        let matches = detect.matches(in: self, options: .reportCompletion, range: NSMakeRange(0, self.count))
        
        for match in matches {
            if let string = match.url?.absoluteString {
                urlStrings.append(string)
            }
        }
        return urlStrings
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isValidIfscCode() -> Bool {
        let ifscCodeRegex = "^[A-Z]{4}0[A-Z0-9]{6}$"
        
        let regexTest = NSPredicate(format:"SELF MATCHES %@", ifscCodeRegex)
        return regexTest.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool{
        
    //Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
        let passwordRegex = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$"//"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"

        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: self)
    }
    
    func isValidMobileNumber(str:String) -> Bool {
        let phoneRegEx = "^[0-9]\\d{9}$"
        let phoneNumber = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneNumber.evaluate(with: str)
    }
    
    func removeHtmlTags() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
    
    func dateStringFormat() -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self) ?? Date()
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "dd-MM-yyyy, h:mm a"//HH:mm:ss
        
        let myString = formatter.string(from: date)
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
//        formatter.dateFormat = "dd MMMM yyyy"
        // again convert your date to string
        let newDate = formatter.string(from: yourDate!)
        
        return newDate
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
    
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
    
    func checkableText(font: UIFont = UIFont(name: fonts.regular, size: fSize.f14)!,color: UIColor = Colors.fontGray) -> NSAttributedString{
        
        let attributedText : NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributedText.addAttributes([
            NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.strikethroughColor: color,
            NSAttributedString.Key.font : font
        ], range: NSMakeRange(0, attributedText.length))
        return attributedText
    }
    
    var containsOnlyDigits: Bool {
        let notDigits = NSCharacterSet.decimalDigits.inverted
        return rangeOfCharacter(from: notDigits, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    var containsOnlyLetters: Bool {
        let notLetters = NSCharacterSet.letters.inverted
        return rangeOfCharacter(from: notLetters, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    var isAlphanumeric: Bool {
        let notAlphanumeric = NSCharacterSet.decimalDigits.union(NSCharacterSet.letters).inverted
        return rangeOfCharacter(from: notAlphanumeric, options: String.CompareOptions.literal, range: nil) == nil
    }
    
    func toDate(_ dateFormat : String = Constants.dateFormat) -> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from:self)!
        if let date = dateFormatter.date(from: self){
            return date
        }
        return nil
    }
    
    // return first character of words
    func firstCharacters() -> String {
        let words = self.components(separatedBy: " ")
        let initials = words.compactMap { $0.first }
        return initials.map { String($0).uppercased() }.joined()
    }
    
    func underLinedString() -> NSAttributedString{
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        let attributedString = NSAttributedString(string: self, attributes: attributes)
        
        return attributedString
    }
}
extension UIViewController{
    
    func redirectToNotificationPermission(){
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                // Already authorized
            }
            else {
                // Either denied or notDetermined
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
                    (granted, error) in
                    
                    guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                        return
                    }
                    if UIApplication.shared.canOpenURL(settingsUrl) {
                        DispatchQueue.main.async {
                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            })
                        }
                    }
                    // add your own
//                    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
//                    let alertController = UIAlertController(title: "Allow Notifications", message: "Open settings to allow app notifications", preferredStyle: .alert)
//                    let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
//                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
//                            return
//                        }
//                        if UIApplication.shared.canOpenURL(settingsUrl) {
//                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
//                            })
//                        }
//                    }
////                    let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
////                    alertController.addAction(cancelAction)
//                    alertController.addAction(settingsAction)
//                    DispatchQueue.main.async {
//                        APP_DEL.navigationController.present(alertController, animated: true, completion: nil)
//                    }
                }
            }
        }
    }
}


extension UIButton {
    func addRightImage(image: UIImage, offset: CGFloat) {
        self.setImage(image, for: .normal)
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0.0).isActive = true
        self.imageView?.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -offset).isActive = true
    }
    
    func changeImageSize(to size: CGFloat){
        self.imageEdgeInsets = UIEdgeInsets(top: size, left: size, bottom: size, right: size)
    }
    
    func underlineTitle() {
        if let title = titleLabel?.text {
            let attributedString = NSMutableAttributedString(string: title)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: title.count))
            setAttributedTitle(attributedString, for: .normal)
        }
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.first(where: \.isKeyWindow)?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
extension Dictionary where Value: Equatable {
    func key(from value: Value) -> Key? {
        return self.first(where: { $0.value == value })?.key
    }
}
extension UIFont {

    func regular(ofSize size : CGFloat = fSize.f14) -> UIFont {
        return UIFont(name: fonts.regular, size: size)!
    }
    
    func medium(ofSize size : CGFloat = fSize.f16) -> UIFont {
        return UIFont(name: fonts.medium, size: size)!
    }
    
    func bold(ofSize size : CGFloat = fSize.f18) -> UIFont {
        return UIFont(name: fonts.bold, size: size)!
    }
}
extension UIView {
    
    func setGradient(colors: [UIColor], locations: [NSNumber]? = nil) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.locations = locations

        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addBlurEffect(style: UIBlurEffect.Style = .dark) {
        // Create a blur effect
        let blurEffect = UIBlurEffect(style: style)

        // Create a visual effect view with the blur effect
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        //blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.85

        // Insert the blur effect view behind the existing content
        insertSubview(blurEffectView, at: 0)
    }
    
    func removeBlurEffect() {
        // Remove all subviews with UIVisualEffectView
        subviews.filter { $0 is UIVisualEffectView }.forEach { $0.removeFromSuperview() }
    }
}
