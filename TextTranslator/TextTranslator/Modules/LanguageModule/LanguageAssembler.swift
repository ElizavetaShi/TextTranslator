//
//  LanguageAssembler.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 15.01.24.
//

import UIKit

final class LanguageAssembler {
    
    private init() {}
    
    static func languageVC() -> LanguageVC {
        let vc = LanguageVC()
        let vm = LanguageVM(networkService: NetworkService(), languageRepository: LanguageRepository())
        vc.viewModel = vm
        return vc
    }
}
