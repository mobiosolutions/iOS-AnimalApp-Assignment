//
//  ApiRequest.swift
//  
//
//  Created by Arvind on 21/11/23.
//  Copyright © 2023  Mac. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class Service: NSObject {
    static let shared = Service()
    
    
    //PHOTO LIST
    func wsPhotoList(param: Parameters, showLoader: Bool = true, completion: @escaping (_ success: Bool, _ message: String, _ response : BaseModal<[PhotoResponse]>?)->()) {
        
        WebService.shared.requestApi(method: HTTPMethod.get.rawValue, webServiceName: "\(ApiUrl.searchList)?\(param.queryString)", param: nil, encoding: JSONEncoding.default, showLoader: showLoader) { (success, statusCode, message, data) in
            
            if(success){
                do {
                    let response = try JSONDecoder().decode(BaseModal<[PhotoResponse]>.self, from: data)
                    completion(success, message, response)
                    
                } catch let error {
                    print("____catch let error: ",error)
                    showTostMsg(msg: ErrorMessages.decodeError)
                }
            }else{
                showTostMsg(msg: message)
                completion(success,message,nil)
            }
        }
    }
    
}
