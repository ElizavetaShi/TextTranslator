//
//  MainNC.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 15.01.24.
//

import UIKit

final class MainNC: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers.append(TranslateAssembler.translateVC())
    }
}
