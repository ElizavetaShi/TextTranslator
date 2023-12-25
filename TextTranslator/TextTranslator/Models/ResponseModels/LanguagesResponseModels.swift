//
//  LanguagesResponseModels.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 25.12.23.
//

import UIKit

struct LanguageResponseModel: Decodable {
    var code: String
    var name: String
}

struct LanguageDataResponseModel: Decodable {
    var languages: [LanguageResponseModel]
}

struct LanguageResponse: Decodable {
    var data: LanguageDataResponseModel
}
