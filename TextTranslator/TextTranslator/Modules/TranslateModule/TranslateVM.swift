//
//  TranslateVM.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 16.01.24.
//

import UIKit

protocol TranslateVMProtocol {
    
    var sourceLanguageName: String? { get }
    var targetLanguageName: String? { get }
    var translatedText: String? { get }
    
    var languageDelegate: LanguageVCDelegate { get }
    
    func translate(text: String)
}

protocol TranslateVCProtocol: UIViewController {
    
    func reloadData()
}

protocol NetworkServiceTranslateUseCase {
    func translate(sourceCode: String, targetCode: String, text: String, completion: @escaping (String) -> Void)
}

final class TranslateVM: TranslateVMProtocol {
    var languageDelegate: LanguageVCDelegate {
        return self
    }
    
    var sourceLanguageName: String? {
        return sourceLanguage?.name
    }
    
    var targetLanguageName: String? {
        return targetLanguage?.name
    }
    
    var translatedText: String? {
        didSet {
            view?.reloadData()
        }
    }
    
    private var sourceLanguage: LanguageResponseModel?
    private var targetLanguage: LanguageResponseModel?
    private var networkService: NetworkServiceTranslateUseCase
    
    weak var view: TranslateVCProtocol?
    
    init(view: TranslateVCProtocol,
         networkService: NetworkServiceTranslateUseCase) {
        self.view = view
        self.networkService = networkService
    }
    
    func translate(text: String) {
        guard let sourceCode = sourceLanguage?.code,
              let targetCode = targetLanguage?.code else { return }
        networkService.translate(sourceCode: sourceCode,
                                 targetCode: targetCode,
                                 text: text) { [weak self] translatedText in
            self?.translatedText = translatedText
        }
    }
}

extension TranslateVM: LanguageVCDelegate {
    func didSelect(language: LanguageResponseModel, with type: LanguageType) {
        switch type {
        case .source: sourceLanguage = language
        case .target: targetLanguage = language
        case .none: break
        }
        view?.reloadData()
    }
}
