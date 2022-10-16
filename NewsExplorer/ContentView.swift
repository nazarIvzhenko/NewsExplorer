//
//  ContentView.swift
//  NewsExplorer
//
//  Created by Nazar Ivzhenko on 16.10.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkRequest: NetworkRequest = NetworkRequest()
    @State private var word: String = ""
    
    @MainActor @State private var showFetchNewsFailedAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search", text: $word)
                    .textFieldStyle(.roundedBorder)
                    .padding([.top, .leading, .trailing])
                    .submitLabel(.search)
                    .onSubmit {
                        Task {
                            do {
                                try await networkRequest.fetchNews(word)
                            } catch {
                                print(error)
                                
                                showFetchNewsFailedAlert = true
                            }
                        }
                    }
                    .alert("Fetching news failed", isPresented: $showFetchNewsFailedAlert) {
                        Button("Dismiss", role: .cancel) {
                            showFetchNewsFailedAlert = false
                        }
                    }
                
                List(networkRequest.articles, id: \.self) { article in
                    NavigationLink(destination: DetailView(article: article)) {
                        VStack(alignment: .leading, spacing: 6.0) {
                            Text(article.title ?? "")
                                .font(.body)
                                .fontWeight(.bold)
                                .lineLimit(2)
                            
                            Text(article.description ?? "")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .lineLimit(2)
                        }
                        .padding(.vertical, 8.0)
                    }
                }
                .listStyle(.plain)
                .padding([.top, .leading, .trailing], 8.0)
                .navigationTitle("News")
                .toolbar {
                    Menu {
                        Button("Relevancy") {
                            Task {
                                do {
                                    try await networkRequest.fetchNews(word, sortBy: "relevancy")
                                } catch {
                                    print(error)
                                    
                                    showFetchNewsFailedAlert = true
                                }
                            }
                        }
                        Button("Popularity") {
                            Task {
                                do {
                                    try await networkRequest.fetchNews(word, sortBy: "popularity")
                                } catch {
                                    print(error)
                                    
                                    showFetchNewsFailedAlert = true
                                }
                            }
                        }
                        Button("PublishedAt") {
                            Task {
                                do {
                                    try await networkRequest.fetchNews(word, sortBy: "publishedAt")
                                } catch {
                                    print(error)
                                    
                                    showFetchNewsFailedAlert = true
                                }
                            }
                        }
                    } label: {
                        Text("Sort by")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
