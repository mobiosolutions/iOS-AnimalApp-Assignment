//
//  CustomLabels.swift
//  
//
//  Created by Mac on 12/05/23.
//

import Foundation
import UIKit

class RegularLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    func setupLabel() {
        
        setTextColor(to: Colors.fontBlack)
        setFont()
        lineSpacing(spacingValue: 4)
        numberOfLines = 0
        lineBreakMode = .byTruncatingTail
    }
    
    func setTextColor(to color: UIColor){
        
        textColor = color
    }
    
    func setFont(to font: UIFont = UIFont(name: fonts.regular, size: fSize.f14)!){
        
        self.font = font
    }
}

class MediumLabel: UILabel {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.setupLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLabel()
    }
    
    func setupLabel() {
        
        setTextColor(to: Colors.fontBlack)
        setFont()
        lineSpacing(spacingValue: 4)
        numberOfLines = 0
        lineBreakMode = .byTruncatingTail
    }
    
    func setTextColor(to color: UIColor){
        
        textColor = color
    }
    
    func setFont(to font: UIFont = UIFont(name: fonts.medium, size: fSize.f16)!){
        
        self.font = font
    }
}


class BoldLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLabel()
    }
    
    func setupLabel() {
        
        setTextColor(to: Colors.fontBlack)
        setFont()
        lineSpacing(spacingValue: 4)
        numberOfLines = 0
        lineBreakMode = .byTruncatingTail
    }
    
    func setTextColor(to color: UIColor){
        
        textColor = color
    }
    
    func setFont(to font: UIFont = UIFont(name: fonts.bold, size: fSize.f24)!){
        
        self.font = font
    }
}
