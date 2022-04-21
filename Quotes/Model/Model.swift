//
//  Model.swift
//  Quotes
//
//  Created by Максим Гурков on 18.04.2022.
//

struct Quotes: Decodable {
    let quote: String?
    let character: String?
    let image: String?
    
    init(quotesData: [String: Any]) {
        quote = quotesData["quote"] as? String
        character = quotesData["character"] as? String
        image = quotesData["image"] as? String
    }
    
    static func getQuotes(from value: Any) -> [Quotes] {
        guard let quotesData = value as? [[String: Any]] else { return [] }
        return quotesData.compactMap{Quotes(quotesData: $0)}
    }
}


enum Link: String {
    case source = "https://thesimpsonsquoteapi.glitch.me/quotes"
}
