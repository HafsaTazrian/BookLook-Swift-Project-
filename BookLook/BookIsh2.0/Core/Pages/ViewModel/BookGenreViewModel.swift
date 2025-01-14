//
//  BookFetcher.swift
//  BookIsh2.0
//
//  Created by Hafsa Tazrian on 11/24/23.
//
import Foundation

class BookGenreViewModel: ObservableObject {
    @Published var books = [Book]()

    func loadBooks(forGenre genre: String) {
        // The iTunes search API uses the term parameter for searching.
        // The genre is included as part of the search term for this example.
        let encodedGenre = genre.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(encodedGenre)&entity=ebook&limit=50") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching books: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }

            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(BooksResponse.self, from: data)
                    DispatchQueue.main.async {
                        // Assuming the iTunes API response structure matches your `BooksResponse` and `Book` model.
                        self.books = decodedResponse.results
                    }
                } catch {
                    print("JSON Decoding failed: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

// This should match the structure of the iTunes API response for books.
struct BookResponse: Decodable {
    var resultCount: Int
    var results: [Book]
}
/*
// Book model
struct Book: Identifiable, Decodable, Hashable {
    let id: Int
    let title: String
    let author: String
    // Add other properties as needed
}*/
