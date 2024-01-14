//
//  CustomButtons.swift
//  
//
//  Created by Mac on 01/03/23.
//

import UIKit

class MyButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(type: eMyButtonTypes = .normal,
                     title:String = "",
                     titleColor: UIColor = Colors.primary,
                     tintClr: UIColor = Colors.primary,
                     bgColor: UIColor = .clear,
                     alignment: UIControl.ContentHorizontalAlignment = .center,
                     imageTitleSpacing: CGFloat = 6) {
                
        switch type {
        case .normal:
            setNormalStyle()
            capsuleShape()
        case .text:
            setTextStyle(color: titleColor, bgColor: bgColor)
        case .textWithBorder:
            setTextStyle()
            setColorStyle(with: titleColor)
            capsuleShape()
        case .imageTitle:
            setImageTitleStyle(with: titleColor, imageTitleSpacing: imageTitleSpacing)
            setBackgroundColor(to: bgColor)
            tintColor = tintClr
            capsuleShape()
        case .image:
            tintColor = tintClr
            backgroundColor = bgColor
        }
        setBtnTitle(to: title)
        contentHorizontalAlignment = alignment
    }
    
    func setNormalStyle(){
        
        setTitleColor(Colors.white, for: .normal)
        backgroundColor = Colors.primary
        
        setTitleFont()
    }
    
    func setTextStyle(color: UIColor = Colors.primary, bgColor: UIColor = .clear){
        
        backgroundColor = bgColor
        setTitleFont()
        setTitleColor(color, for: .normal)
    }
    
    func setImageTitleStyle(with color: UIColor = Colors.primary, imageTitleSpacing: CGFloat = 6){
        
        backgroundColor = .clear
        setTitleFont()
        setTitleColor(color, for: .normal)
        imageTextSpacing(to: imageTitleSpacing)
//        titleEdgeInsets = UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
    }
    
    func setColorStyle(with color: UIColor = Colors.primary){
        
        setBorderColor(color)
        setBorderWidth()
        if color == Colors.black{
            backgroundColor = .clear
            setTitleColor(Colors.fontBlack, for: .normal)
        }
    }
    
    func setTitleFont(to font: UIFont = UIFont(name: fonts.medium, size: fSize.f16)!){
        
        titleLabel?.font = font
    }
    
    func setBtnTitle(to title: String = ""){
        
        setTitle(title, for: .normal)
    }
    
    func setBtnTitleColor(to color: UIColor = Colors.primary){
        
        setTitleColor(color, for: .normal)
    }
    
    func setBackgroundColor(to color: UIColor = Colors.primary){
        
        backgroundColor = color
    }
    
    func setPaddingLeftRight(_ padding: CGFloat = 10) {
        contentEdgeInsets = UIEdgeInsets(top: 0, left: padding, bottom: 0, right: padding)
    }
    
    func enable(){
        
        alpha = 1
        isEnabled = true
    }
    
    func disable(){
        
        alpha = 0.6
        isEnabled = false
    }
    
    
    // tocuh highlight effect to button
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = true
        super.touchesBegan(touches, with: event)
    }
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesEnded(touches, with: event)
    }
    override open func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        isHighlighted = false
        super.touchesCancelled(touches, with: event)
    }
}

