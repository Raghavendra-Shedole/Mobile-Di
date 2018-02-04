//
//  CustomTextField.swift
//  Mobile-di
//
//  Created by Raghavendra Shedole on 04/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable

class CustomTextField: UITextField {
    
    /// Text field border width
    @IBInspectable public var borderWidth:CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
            layer.masksToBounds = true
            
        }
    }
    
    /// textfield border color
    @IBInspectable public var borderColor: UIColor = .clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    /// Textfield corner radius
    @IBInspectable public var cornerRadius:CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    /// Place holder color
    @IBInspectable public var placeholderColor: UIColor = .lightGray {
        didSet {
            let placeholderStr = placeholder ?? ""
            attributedPlaceholder = NSAttributedString(string: placeholderStr, attributes: [NSAttributedStringKey.foregroundColor: placeholderColor])
        }
    }
    
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
}
