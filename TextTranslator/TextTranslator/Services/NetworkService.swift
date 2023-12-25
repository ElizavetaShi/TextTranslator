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
    
    func loadLanguages(completion: @escaping() -> Void) {
        guard let url = URL(string: host + "/getLanguages") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = additionalHeaders
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let jsonData = data else { return }
            print(String(data: jsonData, encoding: .utf8))
        }.resume()
    }
    
}
