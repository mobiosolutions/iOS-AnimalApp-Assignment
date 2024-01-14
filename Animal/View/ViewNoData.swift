//
//  ViewNoData.swift
//  
//
//  Created by  Mac on 20/04/22.
//

import UIKit

class ViewNoData: UIView {
    
    //MARK: - Variables
    
    @IBOutlet weak var viewImg: UIView!
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var lblTitle: MediumLabel!
    
    @IBOutlet weak var viewDesc: UIView!
    @IBOutlet weak var lblDesc: RegularLabel!
    
    @IBOutlet weak var viewBtn: UIView!
    @IBOutlet weak var btn: MyButton!
    
    //MARK: Variables
    typealias completionBlock = (Bool) -> Void
    var completionBlock : completionBlock?

    override init(frame : CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder : NSCoder){
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        
        let viewFromXib = Bundle.main.loadNibNamed("ViewNoData", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        self.addSubview(viewFromXib)
        
        configureView()
    }
}

//MARK: - Click action
extension ViewNoData{
    
    @IBAction func btnClicked(_ sender: UIButton) {
        
        self.completionBlock?(true)
    }
}
//MARK: - Functions
extension ViewNoData{
    
    private func configureView(){
        
        viewImg.isHidden = true
        viewTitle.isHidden = true
        viewDesc.isHidden = true
        viewBtn.isHidden = true
        
        img.image = UIImage(named: "sad_face")
        
        lblTitle.setFont(to: UIFont(name: fonts.medium, size: fSize.f20)!)
        lblTitle.textAlignment = .center
        lblTitle.text = "No Data Found!"
        
        lblDesc.setTextColor(to: Colors.fontDarkGray)
        lblDesc.textAlignment = .center
        
//        btn.setupButton(title: "Button")
    }
    
    func btnClickCallback(completion: @escaping (_ result: Bool)->()) {
        
        self.completionBlock = completion
    }
}
