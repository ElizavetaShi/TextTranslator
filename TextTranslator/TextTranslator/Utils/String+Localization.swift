//
//  String+Localization.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 22.01.24.
//

import Foundation


extension String {
    var localizable: String {
        return NSLocalizedString(self, comment: "")
    }
}
