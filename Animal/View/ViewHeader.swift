//
//  ViewHeader.swift
//  
//
//  Created by Mac on 16/05/23.
//

import UIKit

class ViewHeader: UIView {

    @IBOutlet weak var btnBackScreen: MyButton!
    @IBOutlet weak var lblHeader: MediumLabel!
    
    @IBOutlet weak var btnFavourite: UIView!
    @IBOutlet weak var btnFilter: UIView!
    @IBOutlet weak var btnCancel: UIView!
    
    
    
    
    //MARK: Variables
    
    var isPoptoRootVC = false
    var isBackDisable = false
        
    var viewCtrl: UIViewController?
        
    typealias completionBlock = (Bool,eHeaderButtons) -> Void
    var completionBlock : completionBlock?
    
    override init(frame : CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        
        let viewFromXib = Bundle.main.loadNibNamed("ViewHeader", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        configureView()
    }
    
    func btnClickCallback(completion: @escaping (_ result: Bool, _ btn: eHeaderButtons)->()) {
        
        self.completionBlock = completion
    }

    // MARK: - popupmenu  Implementation
    func openDropDownMenu(_ sender: UIView,itemList:Array<Any>, iconList:Array<Any> ,itemWidth:CGFloat){
        
       
    }
}

//MARK: - Click action
extension ViewHeader{
    
    @IBAction func btnBackScreenClicked(_ sender: UIButton) {
        endEditing(true)
        if(!isBackDisable){
            if isPoptoRootVC{
                viewCtrl?.navigationController?.popToRootViewController(animated: true)
            }
            else{
                viewCtrl?.navigationController?.popViewController(animated: true)
            }
        }
//        if !viewSearch.isHidden{
//            viewSearch.isHidden = true
//            viewBtnSearch.isHidden = false
//            lblHeader.isHidden = false
//            if viewCtrl is EventsVC{
//                viewBtnCalendar.isHidden = false
//            }
//        }else{
//            if(!isBackDisable){
//                if isPoptoRootVC{
//                    viewCtrl?.navigationController?.popToRootViewController(animated: true)
//                }
//                else{
//                    viewCtrl?.navigationController?.popViewController(animated: true)
//                }
//            }
//        }
        self.completionBlock?(true,.back)
    }
    
  
    @IBAction func btnFavoriteClicked(_ sender: UIButton) {
        endEditing(true)
        self.completionBlock?(true,.favourite)
    }
    @IBAction func btnFilterClicked(_ sender: UIButton) {
        endEditing(true)
        self.completionBlock?(true,.filter)
    }
    @IBAction func btnCancelClicked(_ sender: UIButton) {
        endEditing(true)
        self.completionBlock?(true,.cancel)
    }
    
   
}
//MARK: - Functions
extension ViewHeader{
    
    private func configureView(){
        

        backgroundColor = Colors.primary
        
        btnFilter.isHidden = true
        btnFavourite.isHidden = true
        btnCancel.isHidden = true
        
        lblHeader.setTextColor(to: Colors.fontWhite)
        lblHeader.text = ""
        lblHeader.setFont(to: UIFont(name: fonts.medium, size: fSize.f18)!)
        lblHeader.numberOfLines = 1
        lblHeader.textAlignment = .center
        
        btnBackScreen.setupButton(type: .image)
        btnBackScreen.tintColor = Colors.white
        
        
        
//        if isRTL(){
//            btnBackScreen.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
//        }else{
//            btnBackScreen.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
//        }
    }
}

