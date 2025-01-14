//
//  AuthorBookFetcher.swift
//  BookIsh2.0
//
//  Created by Hafsa Tazrian on 11/24/23.
//

import SwiftUI
import Combine
class AuthorBookFetcher: ObservableObject {
    @Published var books = [AuthorBook]()
    var cancellationToken: AnyCancellable?
    
    func searchBooks(byAuthor author: String) {
        let queryItems = [
            URLQueryItem(name: "term", value: author),
            URLQueryItem(name: "media", value: "ebook"),
            URLQueryItem(name: "entity", value: "ebook"),
            URLQueryItem(name: "limit", value: "50")
        ]
        var urlComps = URLComponents(string: "https://itunes.apple.com/search")!
        urlComps.queryItems = queryItems
        
        guard let url = urlComps.url else {
            return
        }
        
        cancellationToken = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: AuthorBookResponse.self, decoder: JSONDecoder())
            .replaceError(with: AuthorBookResponse(results: []))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] response in
                self?.books = response.results
            })
    }
}


