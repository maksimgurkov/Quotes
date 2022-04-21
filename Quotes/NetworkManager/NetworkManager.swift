//
//  NetworkManager.swift
//  Quotes
//
//  Created by Максим Гурков on 21.04.2022.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchDataWithAlamofire(for url: String, with completion: @escaping(Result<[Quotes], NetworkError>) -> Void) {
        AF.request(Link.source.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let quotes = Quotes.getQuotes(from: value)
                    DispatchQueue.main.async {
                        completion(.success(quotes))
                    }
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    
}

class ImageManager {
    
    static let shered = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let imageUrl = URL(string: url ?? "") else { return nil }
        return try? Data(contentsOf: imageUrl)
    }
}
