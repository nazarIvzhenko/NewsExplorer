//
//  NewsResponse.swift
//  News Explorer
//
//  Created by Nazar Ivzhenko on 15.10.2022.
//

import Foundation

struct NewsResponse: Codable, Hashable {
    var articles: [Article]
}

struct Article: Codable, Hashable {
    let source: Source
    let urlToImage: String?
    let title: String
    let description: String?
    let author: String?
    let publishedAt: String?
    
    struct Source: Codable, Hashable {
        let id: String?
        let name: String
    }
}
