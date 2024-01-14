//
//  AMTost.swift
//  
//
//  Created by Arvind on 12/10/17.
//  Copyright © 2017 Komal. All rights reserved.
//

enum TostAlignment: Int {
    
    case CenterAlign
    case TopAlign
    case BottomAlign
    
    
}

import UIKit

class AMTost: UIView {

    // MARK: - Outlets

    @IBOutlet weak var viewMsg: UIView!
    @IBOutlet weak var lblMsg: UILabel!
    @IBOutlet weak var lblCenterYConstant: NSLayoutConstraint!
    
    // MARK: - Variables
    var aligment = TostAlignment.CenterAlign
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lblMsg.font = UIFont(name: fonts.regular, size: 13)
    }
    
    func setMessageTitle(msg: String){
        lblMsg.text = msg
        self.layoutIfNeeded()

        if(viewMsg.frame.size.height>34){
            viewMsg.layer.cornerRadius = 3.0
        }else{
            viewMsg.layer.cornerRadius = viewMsg.frame.size.height/2;
        }
        
        if(aligment == .CenterAlign){
            self.lblCenterYConstant.constant = 0
        }else if(aligment == .TopAlign){
            self.lblCenterYConstant.constant = -(screenHeight/4)
        }else if(aligment == .BottomAlign){
            self.lblCenterYConstant.constant = (screenHeight/2.5)
        }
        self.perform(#selector(removeTost), with: nil, afterDelay: 2.0)
    }
    
    @objc func removeTost(){
    
        UIView.animate(withDuration:0.5, animations: {
            self.alpha = 0.0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
    
}
