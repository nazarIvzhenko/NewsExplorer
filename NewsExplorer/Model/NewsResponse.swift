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
    let title: String?
    let description: String?
    let author: String?
    let publishedAt: String?
    
    struct Source: Codable, Hashable {
        let id: String?
        let name: String?
    }
    
    static func demo() -> Article {
        Article(source: Source(id: "wired",
                               name: "Wired"),
                urlToImage: "https://media.wired.com/photos/631a469e40fe1e8870aa39c8/191:100/w_1280,c_limit/How-to-Preorder-iPhone-14-and-iPhone-14-Pro-Gear.png",
                title: "The Best iPhone 14 Deals—and Which Model Is Best for You",
                description: "Apple has four new handsets, from the iPhone 14 Plus to the iPhone 14 Pro Max. We break them down.",
                author: "Julian Chokkattu",
                publishedAt: "2022-09-16T11:00:00Z"
        )
    }
}
