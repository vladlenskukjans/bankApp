//
//  UITextField+SecureToggle.swift
//  moneyApp
//
//  Created by Vladlens Kukjans on 19/02/2023.
//

import Foundation
import UIKit

let passwordToggleButton = UIButton(type: .custom)

extension UITextField {
    
    func enablePasswordToggle() {
        passwordToggleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        passwordToggleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .selected)
        
        passwordToggleButton.addTarget(self, action: #selector(togglePassordView), for: .touchUpInside)
        rightView = passwordToggleButton
        rightViewMode = .always
        
    }
    
    @objc func togglePassordView() {
        isSecureTextEntry.toggle()
        passwordToggleButton.isSelected.toggle()
        
    }
}
