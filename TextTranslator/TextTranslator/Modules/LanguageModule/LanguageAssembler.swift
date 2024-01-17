//
//  LanguageAssembler.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 15.01.24.
//

import UIKit

final class LanguageAssembler {
    
    private init() {}
    
    static func languageVC(type: LanguageType, delegate: LanguageVCDelegate) -> LanguageVC {
        let vc = LanguageVC()
        let vm = LanguageVM(view: vc,
                            networkService: NetworkService(),
                            languageRepository: LanguageRepository())
        vm.type = type
        vm.delegate = delegate
        vc.viewModel = vm
        return vc
    }
}
