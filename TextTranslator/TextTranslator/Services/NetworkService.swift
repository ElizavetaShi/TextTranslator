//
//  NetworkService.swift
//  TextTranslator
//
//  Created by Elizaveta Shidlovskaya on 25.12.23.
//

import UIKit

final class NetworkService {
    
    private let host = "https://text-translator2.p.rapidapi.com"
    
    private let additionalHeaders: [String: String] =
    ["X-RapidAPI-Host": "text-translator2.p.rapidapi.com",
     "X-RapidAPI-Key": "2f2610d3b1mshfb494c5847b8bdfp1db3c6jsn3045bd3c22f7"]
    
    func loadLanguages(completion: @escaping([LanguageResponseModel]) -> Void) {
        guard let url = URL(string: host + "/getLanguages") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = additionalHeaders
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data else { return }
            let responseModel = try? JSONDecoder().decode(LanguageResponse.self, from: jsonData)
            DispatchQueue.main.async {
                completion(responseModel?.data.languages ?? [])
            }
        }.resume()
    }
    
    func translate(sourceCode: String, targetCode: String, text: String, completion: @escaping (String) -> Void) {
        guard let url = URL(string: host + "/translate") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = additionalHeaders
        
        let postData = NSMutableData(data:
        "source_language=\(sourceCode)".data(using: String.Encoding.utf8)!)
        postData.append("&target_language=\(targetCode)".data(using: String.Encoding.utf8)!)
        postData.append("&text=\(text)".data(using: String.Encoding.utf8)!)
        request.httpBody = postData as Data

        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let jsonData = data else { return }
            let responseModel = try? JSONDecoder().decode(TranslateResponse.self, from: jsonData)
            let translatedText = responseModel?.data.translatedText ?? "Error: no translation"
            DispatchQueue.main.async {
                completion(translatedText)
            }
        }.resume()
    }
}
