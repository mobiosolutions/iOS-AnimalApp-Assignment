//
//  Constant.swift
//
//  Created by Arvind on 25/12/17.
//  Copyright © 2017. All rights reserved.
//

import Foundation
import UIKit


let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let screenWidth  = screenSize.width
let screenHeight = screenSize.height
let statusBarHeight = UIApplication.shared.statusBarFrame.height

let APP_DEL = UIApplication.shared.delegate as! AppDelegate
let AppName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
let AppVersion = String(format: "v%@", Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String)
let userDefault = UserDefaults.standard



//MARK:- API_URL
struct ApiUrl {
    
    
    static let WEB_API = "https://api.pexels.com/v1/"
    
    
   
    static let searchList = ApiUrl.WEB_API + "search"
    
    
}

//MARK:- API_KEYS
/// ApiKey used in App

struct ApiKey {
    
    static let contentType = "Content-Type"
    static let appJs = "application/json"
    
    static let device = "device"
    static let deviceType = "device-type"
    static let deviceOs = "device-os"
    static let deviceUuid = "device-uuid"
    static let version = "version"
    
    static let API_KEY = ""
    static let x_api = "x-api-key"
    
    //    static let deviceType = "device-type"
    static let app_version = "1.0.0"
    
    //static let X_Api_Key = "X-Api-Key"
    
    //device token
    static let device_token = "device-token"
    
    //Authorization
    static let Authorization = "Authorization"
    
    static let x_language = "x-language"
    
    // Token
    static let accessToken = "accessToken"
    static let refresh_token = "refresh_token"
    static let fcm_token = "fcm-token"
    
    // Auth
    static let email = "email"
    static let password = "password"
    static let otp = "otp"
    
    static let name = "name"
    static let country_code = "country_code"
    static let mobile = "mobile"
    
    static let chapter_id = "chapter_id"
    
    static let gallery_id = "gallery_id"
    
    static let type = "type"
    
    static let status = "status"
    
    // pagination
    static let page = "page"
    static let limit = "per_page"
    static let size = "size"
    static let query = "query"
    
    static let date = "date"
    static let company_id = "company_id"
    static let member_id = "member_id"
    
}

struct AppMessages {
    
    static let status = "status"
    static let message = "message"
    
    static let SomethingWentWrong = "Something went wrong"
    
    static let msg_email_empty = "Please enter Email"
    static let msg_email_invalid = "Please enter valid email address"
    
    static let msg_password_empty = "Please enter Password"

    
    
    static let EnterValidMobileNumber = "Please enter valid mobile number!"
    
    static let msg_logOut = "Are you sure you want to logout?"
    
    static let FirstnameAndLastnameRequired = "Firstname and Lastname are required!"
    
    static let AreYouSureYouWantToDelete = "Are you sure you want to delete?"
    
    static let PleaseSelectCategoryFirst = "Please Select Category First"
    
    static let AllFieldsRequired = "All Fields Required"
    
    static let PleaseEnterValidGstNumber = "Please Enter Valid GST Number"
    
    static let PleaseEnterValidEmailID = "Please Enter Valid EmailID"
    
    static let PleaseEnterNewMobileNumber = "Please Enter New Mobile Number"
    
    static let msg_delete_product = "Are you sure you want to delete this product?"
    
    static let msg_close_screen = "All your changes will be lost! Are you sure you want to close?"
    static let msg_skip_screen = "All your changes will be lost! Are you sure you want to skip?"
    
    static let This_Trade_is_Expired = "This Trade is Expired"
    
    static let You_can_not_confirm_negotiate_or_cancel_this_deal = "You can not confirm, negotiate or cancel this deal"
}

//struct userDefaultKey {
//
//    static let accessToken = "accessToken"
//    static let refreshToken = "refreshToken"
//    static let fcmToken = "fcmToken"
//    static let status = "status"
//}


struct ViewControllerName {
    
}

struct Str_Res {
    
}

struct Constants{
    
    static let ACTIVE = "ACTIVE"
    
    static let login_username = "log"
    
    // device type
    static let DEVICE_TYPE = "iOS"
    
    static let lineMultipleHeight = 1.3
    
    static let page_limit = 20
    
    static let chatMediaLimit = 4
    
    static let dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    
    static let AED = "AED"
    
    static let Total = "Total"
    
    static let YES = "YES"
    
    static let Certificate = "Certificate"
    
    static let Download = "Download"
    
    static let reportIssueNumber = "918780932571"
    
    static let AFMT = "AFMT"
    
    // filetype
    static let IMAGE = "IMAGE"
    static let VIDEO = "VIDEO"
    static let DOCUMENT = "DOCUMENT"
    static let APPLICATION = "APPLICATION"
    static let TEXT = "TEXT"
    static let IMAGES = "IMAGES"
    static let DOCUMENTS = "DOCUMENTS"
    
    
    // event type
//    static let ONLINE = "ONLINE"
}

struct AttachmentType{
    
    static let video = UIImage(named: "Video_play")
    static let doc = UIImage(named: "attachment_type_doc")
}

struct placeholderImages{
    
    static let attachment = UIImage(named: "attachment_placeholder")
    static let attachmentVideo = UIImage(named: "video_placeholder")
    static let work = UIImage(named: "work_placehoder")
    static let profileCover = UIImage(named: "profile_cover")
    static let companyCover = UIImage(named: "company_cover")
}

struct url_const{
    
    static let privacy_policy = "http://www.google.com"
    static let terms_service = "http://www.google.com"
    
}


struct ErrorMessages {
    
    static let decodeError = "Something went wrong!"
}


struct imagePlaceholder{
    
    static let profile = UIImage(named: "profile_placeholder")
}
