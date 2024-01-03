//
//  TranslateResponseModels.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 2.01.24.
//

import Foundation

struct TranslateResponseModel: Decodable {
    var translatedText: String
}

struct TranslateResponse: Decodable {
    var status: String
    var data: TranslateResponseModel
}
