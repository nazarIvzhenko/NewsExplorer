//
//  NetworkRequest.swift
//  News Explorer
//
//  Created by Nazar Ivzhenko on 15.10.2022.
//

import SwiftUI

class NetworkRequest: ObservableObject {
    enum NewsFetchError: Error {
        case urlCreationError
        case jsonDecodingError
        case invalidResponse
    }
    
    @Published var articles: [Article] = []
    
    func fetchNews(_ text: String, sortBy: String? = nil) async throws {
        var string: String
        
        if let sortBy = sortBy {
            string = "https://newsapi.org/v2/everything?q=\(text)&sortBy=\(sortBy)&apiKey=f6de90660e9240fcbb0312d387858e38"
        } else {
            string = "https://newsapi.org/v2/everything?q=\(text)&apiKey=f6de90660e9240fcbb0312d387858e38"
        }
        
        guard let url = URL(string: string)
        else {
            throw NewsFetchError.urlCreationError
        }
        
        let session = URLSession(configuration: .default)
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode)
        else {
            throw NewsFetchError.invalidResponse
        }

        guard let jsonData = try? JSONDecoder().decode(NewsResponse.self, from: data)
        else {
            throw NewsFetchError.jsonDecodingError
        }
        
        await MainActor.run {
            articles = jsonData.articles
        }
    }
}
