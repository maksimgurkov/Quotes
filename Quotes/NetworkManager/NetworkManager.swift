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
                        completion(.success(quotes))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
        }
    }

class ImageManager {
    
    static let shered = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String, completion: @escaping (Data) -> Void) {
        AF.request(url)
            .validate()
            .responseData { data in
                switch data.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
