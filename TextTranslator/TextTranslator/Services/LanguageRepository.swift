//
//  LanguageRepository.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 25.12.23.
//

import Foundation
import CoreData

final class LanguageRepository {
    
    func getLanguages() -> [LanguageResponseModel] {
        let request = LanguageMO.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "\(#keyPath(LanguageMO.name))", ascending: true)]
        let languages = (try? CoreDataService.shared.context.fetch(request)) ?? []
        return languages.compactMap {
            guard let name = $0.name,
                  let code = $0.code else {return nil }
            return LanguageResponseModel(code: code, name: name)}
    }
    
    func save(models: [LanguageResponseModel]) {
        let context = CoreDataService.shared.context
        context.perform {
            models.forEach { model in
                let language = self.getLanguage(by: model.code) ??  LanguageMO(context: context)
                language.code = model.code
                language.name = model.name
            }
            CoreDataService.shared.saveContext()
        }
    }
    
    private func getLanguage(by code: String) -> LanguageMO? {
        
        let request = LanguageMO.fetchRequest()
        request.predicate  = NSPredicate(format: "\(#keyPath(LanguageMO.code)) == \"\(code)\"")
        return try? CoreDataService.shared.context.fetch(request).first
    }
}
