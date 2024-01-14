//
//  PhotoViewModel.swift
//  Animal
//
//  Created by Arvind Mehta on 13/01/24.
//

import Foundation
import Alamofire

class PhotoViewModel: NSObject {
    
    public var isSuccess: Bool = false
    public var isShowLoader: Bool = false
    public var param: Parameters?
    
    public var photoListData : BaseModal<[PhotoResponse]>? {
        didSet {
            self.bindPhotoVMToController(isSuccess)
        }
    }
    
    var bindPhotoVMToController : ((Bool) -> ()) = {_ in }
    
    override init() {
        super.init()
    }
    
    func apiPhotoList(){
        
        Service.shared.wsPhotoList(param: param!, showLoader:isShowLoader){ success, message, response in
            self.isSuccess = success
            self.photoListData = response
        }
    }
    
}
