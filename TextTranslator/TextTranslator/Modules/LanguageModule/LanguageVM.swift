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
}

protocol NetworkServiceLanguageUseCase {
    func loadLanguages(completion: @escaping([LanguageResponseModel]) -> Void)
}

protocol LanguageRepositoryLanguageUseCase {
    func getLanguages() -> [LanguageResponseModel]
    func save(models: [LanguageResponseModel])
}

final class LanguageVM: LanguageVMProtocol {
    var languages: [LanguageResponseModel] = []
    
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
    
    private let networkService: NetworkServiceLanguageUseCase
    private let languageRepository: LanguageRepositoryLanguageUseCase
    private let ud = UserDefaults.standard
      
    init(networkService: NetworkServiceLanguageUseCase, languageRepository: LanguageRepositoryLanguageUseCase) {
        self.networkService = networkService
        self.languageRepository = languageRepository
    }
}
