//
//  TranslateAssembler.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 15.01.24.
//

import UIKit

final class TranslateAssembler {
    
    private init() {}
    
    static func translateVC() -> TranslateVC {
        let vc = TranslateVC()
        let vm = TranslateVM(view: vc,
                             networkService: NetworkService())
        vc.viewModel = vm
        return vc
    }
}
