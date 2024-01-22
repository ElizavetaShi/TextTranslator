//
//  LanguageVM.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 15.01.24.
//

import UIKit

protocol LanguageVMProtocol {
    
    var languages: [LanguageResponseModel] { get }
    
    func loadDataIfNeeded()
    func didSelect(language: LanguageResponseModel)
}

protocol LanguageVCProtocol: UIViewController {
    func reloadData()
}

protocol NetworkServiceLanguageUseCase {
    func loadLanguages(completion: @escaping([LanguageResponseModel]) -> Void)
}

protocol LanguageRepositoryLanguageUseCase {
    func getLanguages() -> [LanguageResponseModel]
    func save(models: [LanguageResponseModel])
}

final class LanguageVM: LanguageVMProtocol {
    
    private(set) var languages: [LanguageResponseModel] = [] {
        didSet {
            view?.reloadData()
        }
    }
 
    private let networkService: NetworkServiceLanguageUseCase
    private let languageRepository: LanguageRepositoryLanguageUseCase
    private let ud = UserDefaults.standard
    
    var delegate: LanguageVCDelegate?
    var type: LanguageType = .none
    
    private weak var view: LanguageVCProtocol?
    
    init(view: LanguageVCProtocol,
         networkService: NetworkServiceLanguageUseCase,
         languageRepository: LanguageRepositoryLanguageUseCase) {
        self.view = view
        self.networkService = networkService
        self.languageRepository = languageRepository
    }
    
    func loadDataIfNeeded() {
        let loadTimeKey = "kLastLoadTimeInterval"
        let loadTime = ud.double(forKey: loadTimeKey)
        let nowTime = Date().timeIntervalSince1970
        let cashedLanguages = languageRepository.getLanguages()
        if
            nowTime - loadTime < 24 * 3600,
            !cashedLanguages.isEmpty {
            self.languages = cashedLanguages
        } else {
            networkService.loadLanguages { [weak self] languages in
                self?.languages = languages
                self?.languageRepository.save(models: languages)
                self?.ud.set(nowTime, forKey: loadTimeKey)
            }
        }
    }
    
    func didSelect(language: LanguageResponseModel) {
        delegate?.didSelect(language: language, with: type)
    }
}
