
//  WebService.swift
//  
//
//  Created by Asif on 21/11/23.
//  Copyright © 2023 Bhavik. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class WebService: NSObject {
    
    static let shared = WebService()
    
    func requestApi(method: String, webServiceName: String, param: Parameters?, encoding: ParameterEncoding = JSONEncoding.default, showLoader: Bool, header : HTTPHeaders = HTTPHeaders(), completion: @escaping (_ result: Bool,_ status: Int, _ message: String, _ data: Data)->()) {
        
        // check for internet
        if(connectedToInternet() == false){
            
            return
        }
        
        print("___ api is:",webServiceName)
        
        //Headers
        var headerData = [String:String]()
        
        headerData[ApiKey.Authorization] = "F0RsC7L6viQO7bzFmZTKs7hwGWhXlwm5TjAozyXUwkTmB8INisxbwjVg"        
        
//        if isRTL(){
//            headerData[ApiKey.x_language] = "ar"
//        }
//        else{
//            headerData[ApiKey.x_language] = "en"
//        }
        
        print("____ param is",param)
        
        print("header webservice",headerData)
        
        if showLoader{
            
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setDefaultMaskType(.custom)
            SVProgressHUD.setBackgroundColor(.clear)
            
            //            SVProgressHUD.setForegroundColor(color_rosegold)
            //            SVProgressHUD.setBackgroundLayerColor(color_progress_bg)    //Background Color
            SVProgressHUD.show()
        }
        
        AF.request(URL(string: webServiceName)!, method: HTTPMethod(rawValue: method), parameters: param as Any as? Parameters, encoding: JSONEncoding.default, headers: headerData.toHeader(), interceptor: nil, requestModifier: nil).responseJSON { dataResponse in
            
            //responseDecodable(of: SuperModel1.self) { dataResponse in
            
            //            .responseJSON { dataResponse in
            
            
            //responseDecodable(of: SuperModel1.self) { dataResponse in
            
            //        AF.request(URL(string: webServiceName)!, method: HTTPMethod(rawValue: method), parameters: param as Any as? Parameters, encoding: JSONEncoding.default, headers: headerData.toHeader(), interceptor: nil, requestModifier: nil).re
            
            if showLoader{
                DispatchQueue.main.async {
                    SVProgressHUD.dismiss()
                }
            }
            
            print("____statusCode: ",dataResponse.response?.statusCode)
            
            switch dataResponse.result {
                
            case .success(let JSON):
                
                let response: [String: Any] = JSON as? [String : Any] ?? [:]// as! NSDictionary
                print("____Response: ",JSON)
                
                if let status = dataResponse.response?.statusCode{
                    
                    if (status == 200 || status == 201){
                        completion(true,status, response["message"] as? String ?? "",dataResponse.data!)
                    }
                    else if status == 401{
                        
//                        if let topVC = UIApplication.topViewController(){
//                            if topVC is LoginVC{
//                                completion(false,status, response["message"] as? String ?? "Error",Data())
//                            }
//                            else{
//                                LogoutOn401()
//                            }
//                        }
                        
                    
                    }
                    else{
                        if((response["message"] as? String) != nil){
                            completion(false,status, response["message"] as? String ?? "something went wrong!",Data())
                        }else{
                            do {
                                let jsonData = try JSONSerialization.data(withJSONObject: response, options: .prettyPrinted)
                                let decoder = JSONDecoder()
//                                let decodedData = try decoder.decode([errorList].self , from: jsonData)
                                
//                                print("___________decodedData__________", decodedData);
                                var arrError : [String] = []
//                                for item in decodedData {
//                                    let errorData: errorList = item
//                                    print("_______________", item)
//                                    arrError.append(errorData.strError!)
//                                }
                                
                                completion(false, status, arrError.joined(separator: ",\n"),Data()        )
                                
                            }
                            catch {
                                print("check structure", error)
                            }
                        }
                        //                        completion(false, status, response["message"] as? String ?? "proper message not decoded", Data())
                    }
//                    else{
//                        completion(false,status, response["message"] as? String ?? "Error",Data())
//                    }
                }
                
            case .failure(let error):
                print("__failure response is",dataResponse)
                print("caught the error",error.localizedDescription)
                
                if let status = dataResponse.response?.statusCode{
                    if status == 401{
                    }
                }
                
//                showTostMsg(msg: error.localizedDescription)
                showTostMsg(msg: AppMessages.SomethingWentWrong)
//                completion(false,0, error.localizedDescription, Data())
                completion(false,0, AppMessages.SomethingWentWrong, Data())
            }
        }
    }
    
    // Media section
    
    func requestMedia(method: String, webServiceName: String, param: [String: Any]?, showLoader: Bool , completion: @escaping (_ result: Bool, _ message: String, _ response: [String:Any])->()) {
        
        // check internet
        if(connectedToInternet() == false){
            
            //       print("There is no internet connection")
            return
        }
        
        var header = [String:String]()
        
//        if webServiceName == ApiUrl.productList{
//            header[ApiKey.contentType] = "multipart/form-data"
//
//        }
        
        if let accessToken = UserDefaults.standard.object(forKey: eUserDefaults.accessToken.rawValue) as? String{
            print("access token avail",accessToken)
            if accessToken != ""{
                header[ApiKey.Authorization] = "Bearer " + accessToken
            }
        }
        
        if param != nil {
        }
        
        // show loader
        if showLoader{
            SVProgressHUD.show()
        }
        
        AF.upload(
            multipartFormData: { multipartFormData in
                if let dictParam = param {
                    
                    for (key, value) in dictParam {
                        
                        if(key == "statement"){
                            for imageData in value as! Array<Data> {
                                multipartFormData.append(imageData, withName: "\("statement")[]", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                            }
                        }
                        else if(key == "document"){
                            for imageData in value as! Array<Data> {
                                multipartFormData.append(imageData, withName: "\("statement")[]", fileName: "\(Date().timeIntervalSince1970).pdf", mimeType: "pdf")
                            }
                        }else if (value is UIImage) {
                            
                        } else {
//                            multipartFormData.append("\(value)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!, withName: key)
                            
                            
                            if let newVal = value as? Bool{
                                let str = String(newVal)
                                multipartFormData.append("\(str)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key)
                            }
                            else{
                                multipartFormData.append("\(value)".data(using: String.Encoding.utf8, allowLossyConversion: false)!, withName: key)
                            }
                            
//                            let fileData = try NSData(contentsOfFile:value, options:[]) as Data
//                            let fileData:Data = NSKeyedArchiver.archivedData(withRootObject: value)
//                            multipartFormData.append(fileData, withName: key)
                           

                            print("_____multipartFormData",multipartFormData)
                        }
                    }
                    
                    for (key, value) in dictParam {
                        if (value is UIImage) {
                            
                            if let imageData = (value as! UIImage).jpegData(compressionQuality: 0.8){
                                
                                multipartFormData.append(imageData, withName: key, fileName: "\(getTimeStamp()).jpeg", mimeType: "image/jpeg")
                            }
                        }
                    }
                }
            },
            to: webServiceName, method: HTTPMethod(rawValue: method) , headers: header.toHeader())
        
        .uploadProgress(closure: { (Progress) in
            print("Upload Progress: \(Progress.fractionCompleted)")
        })
        
        .responseJSON { response in
            SVProgressHUD.dismiss()
            hideLoader()
            print("Upload Progress finish: \(response)")
            
            switch response.result {
            case .success(let result):
                
                let response: [String: Any] = result as? [String : Any] ?? [:]// as! NSDictionary
                print("____Response: ",response)
                
                completion(true,response["message"] as! String,response)
                
                print("upload success result: \(String(describing: result))")
                
            case .failure(let err):
                print("upload err: \(err.localizedDescription)")
//                showTostMsg(msg: err.localizedDescription)
                showTostMsg(msg: AppMessages.SomethingWentWrong)
                completion(false, AppMessages.SomethingWentWrong, [:])
                hideLoader()
                SVProgressHUD.dismiss()
            }
            
        }
    }
}
