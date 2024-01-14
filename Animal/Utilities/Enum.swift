//
//  Enum.swift
//  
//
//  Created by Arvind on 25/12/17.
//  Copyright © 2017 Komal. All rights reserved.
//

import Foundation
import UIKit


enum eStoryboardName: String {
    
    case Home = "Home"
   
}

enum eLanguageCode: String{
    
    case en = "en"
    case ar = "ar"
}

enum eUserDefaults: String {
    
    case accessToken
    case fcmToken
    case user
    case chapterId
}

enum ePostType: String {
    
    case EVENT
    case ANNOUNCEMENTS
    case DISPUTE
}

enum eEventStatusType: String {
    
    case UPCOMING
    case COMPLETED
}

enum eEventType: String {
    
    case ONLINE
    case OFFLINE
}



enum Colors{
    
    // for AFMT
    static let primary = UIColor(red: 33/255, green: 33/255, blue: 33/255, alpha: 1.0) //212121
    static let secondary = UIColor(red: 228/255, green: 235/255, blue: 255/255, alpha: 1.0) //E4EBFF
    
    // generic color
//    static let primary = UIColor(red: 76/255, green: 130/255, blue: 216/255, alpha: 1.0) //4C82D8
//    static let secondary = UIColor(red: 231/255, green: 239/255, blue: 254/255, alpha: 1.0) //E7EFFE
    
    static let separator = UIColor(red: 225/255, green: 225/255, blue: 225/255, alpha: 1.0) //E1E1E1
    static let bgScreen = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0) //E5E5E5
    static let black = UIColor(red: 23/255, green: 34/255, blue: 38/255, alpha: 1.0) //172226
    static let gray = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1.0) //8A8A8A
    static let darkGray = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1.0) //464646
    static let lightGray = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1.0) //C2C2C2
    static let extremeLightGray = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1.0) //FBFBFB
    static let red = UIColor(red: 255/255, green: 77/255, blue: 79/255, alpha: 1.0) //FF4D4F
    static let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) //FFFFFF
    static let bgLightGray = UIColor(red: 242/255, green: 242/255, blue: 244/255, alpha: 1.0) //F1F2F4
    static let lighGreen = UIColor(red: 75/255, green: 202/255, blue: 89/255, alpha: 1.0) //4BCA59
    static let bgCard = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0) //#F4F4F4
    static let mustardDark = UIColor(red: 229/255, green: 152/255, blue: 46/255, alpha: 1.0) //#E5982E
    static let mustardLight = UIColor(red: 241/255, green: 184/255, blue: 11/255, alpha: 1.0) //#F1B80B
    static let yellow = UIColor(red: 255/255, green: 229/255, blue: 130/255, alpha: 1.0) //#FFE582
    static let border = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1.0) //DDDDDD
    
    
    static let fontBlack = UIColor(red: 23/255, green: 34/255, blue: 38/255, alpha: 1.0) //172226
    static let fontGray = UIColor(red: 138/255, green: 138/255, blue: 138/255, alpha: 1.0) //8A8A8A
    static let fontDarkGray = UIColor(red: 70/255, green: 70/255, blue: 70/255, alpha: 1.0) //464646
    static let fontLightGray = UIColor(red: 194/255, green: 194/255, blue: 194/255, alpha: 1.0) //C2C2C2
    static let fontRed = UIColor(red: 255/255, green: 77/255, blue: 79/255, alpha: 1.0) //FF4D4F
    static let fontWhite = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) //FFFFFF
    static let fontLighGreen = UIColor(red: 75/255, green: 202/255, blue: 89/255, alpha: 1.0) //4BCA59
    
    
    static let orange = UIColor(red: 227/255, green: 136/255, blue: 113/255, alpha: 1.0) //E38871
    
    static let defaultBorder = UIColor(red: 176/255, green: 176/255, blue: 176/255, alpha: 1.0) //B0B0B0
    static let extraLightGray = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0) //F5F5F5
    static let disabledBtnTitle = UIColor(red: 154/255, green: 154/255, blue: 154/255, alpha: 1.0) //9A9A9A
    static let mustard = UIColor(red: 239/255, green: 160/255, blue: 1/255, alpha: 1.0) //EFA001
    static let green = UIColor(red: 81/255, green: 195/255, blue: 25/255, alpha: 1.0) //51C319
    static let yelllow = UIColor(red: 255/255, green: 247/255, blue: 231/255, alpha: 1.0) //FFF7E7
    static let pink = UIColor(red: 255/255, green: 232/255, blue: 232/255, alpha: 1.0) //FFE8E8
    static let lightGreen = UIColor(red: 239/255, green: 255/255, blue: 231/255, alpha: 1.0) //EFFFE7
    
}

enum fonts{
    
    static let regular = "SFProDisplay-Regular"
    static let medium = "SFProDisplay-Medium"
    static let bold = "SFProDisplay-Bold"
}

//extension UIFont {
//
//    public enum fontType: String {
//
//        case book = "AbdoMaster-Book"
//        case medium = "AbdoMaster-Medium"
//        case semibold = "AbdoMaster-SemiBold"
//    }
//
//    public enum fSize: String {
//
//        case f10: CGFloat = 10
//        case f12: CGFloat = 12
//        case f14: CGFloat = 14
//        case f16: CGFloat = 16
//        case f18: CGFloat = 18
//        case f20: CGFloat = 20
//        case f24: CGFloat = 24
//    }
//
//    static func setFont(_ type: fontType = .medium, size: fSize = .f14) -> UIFont {
//        return UIFont(name: type.rawValue, size: size)!
//    }
//}

enum fSize{
    
    static let f10: CGFloat = 10
    static let f12: CGFloat = 12
    static let f14: CGFloat = 14
    static let f16: CGFloat = 16
    static let f18: CGFloat = 18
    static let f20: CGFloat = 20
    static let f22: CGFloat = 22
    static let f24: CGFloat = 24
}

enum eCornerRadius : CGFloat{
    
    
    case c1 = 1
    case c2 = 2
    case c4 = 4
    case c6 = 6
    case c8 = 8
    case c10 = 10
    case c12 = 12
    case c14 = 14
    case c16 = 16
    case c20 = 20
    case c80 = 80
}

enum eBorderWidth : CGFloat{
    
    case b0 = 0
    case b05 = 0.5
    case b1 = 1
    case b2 = 2
    case b4 = 4
    case b6 = 6
    case b8 = 8
    case b10 = 10
}

enum eLineSpacing : CGFloat{
    
    case l1 = 1
    case l2 = 2
    case l4 = 4
    case b = 6
    case b8 = 8
    case b10 = 10
}


enum eMyButtonTypes: String{
    
    case normal
    case text
    case image
    case imageTitle
    case textWithBorder
}

enum eTextfieldType: String{
    
    case name
    case email
    case password
    case number
}

enum eAccountTypes: Decodable{
    case wishlist
    case myOrders
    case myAddress
    case kyc
    case merchant
    case helpCenter
    case languagePreference
    case logOut
}

enum eKycStatusTemp: String{
    
    case underReview
    case unable
    case verified
}

//enum eMediaType: Decodable{
//    
//    case image
//    case video
//}

enum eAddressTypes: String{
    
    case HOME = "HOME"
    case OFFICE = "OFFICE"
    case OTHER = "OTHER"
}

enum eVerifyOtpTypes: String{
    
    case MAIL = "MAIL"
    case SIGNUP = "SIGNUP"
}

enum ePageLimit{
    
    static let p4: Int = 4
    static let P6: Int = 6
    static let P8: Int = 8
    static let P10: Int = 10
    static let P20: Int = 20
    static let P100: Int = 100
}

enum eHomeApiType: String{
    
    case newArrival
    case recentlyViewed
    case women
    case men
    case kids
}

enum eQuantiyAction: String{
    
    case ADD
    case REMOVE
    case UPDATE
}


enum eCancelOrderType: String, Codable{
    
    case CHANGEMYMIND = "CHANGEDMIND"
    case RETURNPOLICY = "RETURNPOLICY"
    case INCORRECTFIT = "INCORRECTFIT"
    case DAMAGED = "DAMAGED"
    case WRONGPROUDCT = "WRONGPROUDCT"
    case OTHER = "OTHER"
}

enum eDeleteAccountReasons: String, Codable{
    
    case NONEEDED = "NONEEDED"
    case PRIVACYCONCERN = "PRIVACYCONCERN"
    case EXPENSIVE = "EXPENSIVE"
    case OTHER = "OTHER"
}

enum eKycStatus: String, Codable{
    
    case PENDING = "PENDING"
    case COMPLETED = "COMPLETED"
    case REJECTED = "REJECTED"
    case INPROCESS = "INPROCESS"
}

enum ePaymentMethod: String{
    
    case ONLINE
    case PAYLATER
}
enum eProductCustmizeType: String, Codable{
    
    case metal
    case size
    case color
    case purity
    case caliber
}

enum eSortTypes: String, Codable{
    
    case newArrival
    case highToLow
    case lowToHigh
}

enum eSounds: String{
    
    case tap = "tap"
    case bubble = "bubble"
    case remove = "remove"
}

enum eNotificationType: String, Codable{
    
    case ORDERLIST = "ORDERLIST"
    case PRODUCTLIST = "PRODUCTLIST"
    case ACCOUNT = "ACCOUNT"
    case CART = "CART"
    case WELCOME = "WELCOME"
}

enum eKeyFeaturesHomeTypes: String{
    
    case Directory = "Directory"
    case Committee = "Committee"
    case Sponsors = "Sponsors"
    case HelpDesk = "HelpDesk"
}

enum eHeaderButtons: String{
    
    case back = "back"
    case filter = "filter"
    case favourite = "favourite"
    case cancel = "cancel"
    
}

enum eCommunityBoards: String, Codable{
    
    case announcements = "announcements"
    case events = "events"
    case introductions = "introductions"
    case disputedCases = "disputedCases"
    case newsletters = "newsletters"
    case birthdays = "birthdays"
    case gallery = "gallery"
    case documents = "documents"
    case jobPostings = "jobPostings"
    case matrimonial = "matrimonial"
    case thankyou = "thankyou"
    case polls = "polls"
    case donations = "donations"
    case vendors = "vendors"
    case condolences = "condolences"
    case appreciations = "appreciations"
    
    
}

enum eMediaTypes: String{
    
    case IMAGE
    case VIDEO
    case DOCUMENT
}


enum eNetworkOptions: Codable{
    
    case vendors
    case birthday
}

enum eFeedTypes: Codable{
    
    case announcement
    case event
    case introduction
    case disputed
}

enum eHomeKeyFeature: Codable{
    
    case helpDesk
    case birthday
    case committee
    case sponsor
    case gallery
}

enum eProfileContact: Codable{
    
    case call
    case whatsapp
    case email
    case website
    case linkedIn
    case instagram
    case facebook
    case youtube
}

enum eDateFormats: String {
    case def = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"//"yyyy-MM-dd'T'hh:mm:ss.SSS'Z"
    case yyyyMMdd = "yyyy-MM-dd"
    case ddMMyyyy = "dd/MM/yyyy"
    case ddMMMyyyy = "dd/MMM/yyyy"
    case dd_MMM_yyyy = "dd MMM yyyy"
}
