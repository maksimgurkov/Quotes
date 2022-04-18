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
}

enum Source: String {
    case source = "https://thesimpsonsquoteapi.glitch.me/quotes"
}
