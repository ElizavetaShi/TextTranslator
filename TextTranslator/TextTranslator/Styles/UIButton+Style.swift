//
//  UIButton+Style.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 3.01.24.
//

import UIKit

extension UIButton {
    
    static func selectButton(with title: String) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .cyan
        button.setTitle(title, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.darkGray.withAlphaComponent(0.8), for: .highlighted)
        button.layer.cornerRadius = 5.0
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1.0
        button.titleLabel?.font = .systemFont(ofSize: 17.0)
        return button
    }
    
    static func translateButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .cyan
        button.setTitle("translate_button".localizable, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black.withAlphaComponent(0.8), for: .highlighted)
        button.layer.cornerRadius = 5.0
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1.0
        button.titleLabel?.font = .systemFont(ofSize: 17.0)
        return button
    }
}
