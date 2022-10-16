//
//  DetailView.swift
//  NewsExplorer
//
//  Created by Nazar Ivzhenko on 16.10.2022.
//

import SwiftUI

struct DetailView: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(2)
                .padding(.horizontal)
                .padding(.bottom, 1)
            
            HStack(spacing: 4) {
                Text(article.source.name)
                Text("•")
                    .font(.system(size: 18))
                
                HStack(spacing: 4) {
                    Text("by")
                    Text(article.author ?? "")
                        .fontWeight(.bold)
                }
            }
            .font(.system(size: 16))
            .foregroundColor(.secondary)
            .padding(.horizontal)
            
            Text("on \(dateFromString(article.publishedAt ?? ""))")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            HStack {
                Spacer()
                
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal, 4)
                        .padding(.top, 10)
                } placeholder: {
                    ProgressView()
                }
                
                Spacer()
            }
            
            Text(article.description ?? "")
                .font(.system(size: 18))
                .padding([.top, .leading, .trailing])
        }
    }
    
    func dateFromString(_ string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        let anotherDateFormatter = DateFormatter()
        anotherDateFormatter.dateFormat = "d MMMM, yyyy"
        
        let date = dateFormatter.date(from: string)!
        let desiredFormat = anotherDateFormatter.string(from: date)
        return desiredFormat
    }
}

struct DetailView_Previews: PreviewProvider {
    
    struct PreviewWrapper: View {
        private let article = Article.demo()
        
        var body: some View {
            DetailView(article: article)
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
    }
}
