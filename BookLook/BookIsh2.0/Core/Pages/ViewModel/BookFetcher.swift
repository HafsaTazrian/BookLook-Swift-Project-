//
//  BookFetcher.swift
//  BookIsh2.0
//
//  Created by Rakibul Nasib on 14/11/23.
//

import Foundation

class BookFetcher: ObservableObject {
    @Published var books = [Book]()
    
    
    func searchBooks(searchTerm: String) {
        let queryItems = [
            URLQueryItem(name: "term", value: searchTerm),
            URLQueryItem(name: "media", value: "ebook"),
            URLQueryItem(name: "entity", value: "ebook"),
            URLQueryItem(name: "limit", value: "50")
        ]

        var urlComps = URLComponents(string: "https://itunes.apple.com/search")!
        urlComps.queryItems = queryItems
        
        guard let url = urlComps.url else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let decodedResponse = try JSONDecoder().decode(BooksResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.books = decodedResponse.results
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("JSON Decoding failed: \(error)")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }.resume()
        
    }
    func loadBooks() {
        // Ensure to use the correct URL and parameters according to the iTunes API
        let url = URL(string: "https://itunes.apple.com/search?term=books&entity=ebook&limit=50")


        guard let url = url else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                do {
                    let decodedResponse = try JSONDecoder().decode(BooksResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.books = decodedResponse.results
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("JSON Decoding failed: \(error)")
                    }
                }
            } else {
                DispatchQueue.main.async {
                    print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
        }.resume()
    }
    
    
    
    
}

// Response structure for iTunes API
struct BooksResponse: Decodable {
    var resultCount: Int
    var results: [Book]
    init(results: [Book]) {
            self.resultCount = results.count
            self.results = results
        }
}
