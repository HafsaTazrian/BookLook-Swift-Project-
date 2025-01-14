//
//  AuthorView.swift
//  BookIsh2.0
//
//  Created by Hafsa Tazrian on 11/24/23.
//

import SwiftUI

struct AuthorView: View {
    @StateObject private var bookFetcher = AuthorBookFetcher()
    @State private var searchText = ""
    private func formatDate(_ dateString: String?) -> String {
        guard let dateString = dateString,
              let date = BookDetailView.dateFormatter.date(from: dateString) else {
            return "Unknown"
        }
        return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Search by Author", text: $searchText, onCommit: {
                    bookFetcher.searchBooks(byAuthor: searchText)
                })
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                
                List(bookFetcher.books) { book in
                    NavigationLink(destination: AuthorBookDetailView(book: book)){
                        HStack {
                            if let url = book.coverImageURL {
                                AsyncImage(url: url) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 100, height: 150)
                                .cornerRadius(5)
                            }
                            
                            VStack(alignment: .leading) {
                                Text(book.title)
                                    .font(.headline)
                                Text(book.author)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                if let genres = book.genres?.joined(separator: ", ") {
                                    Text("Genre: \(genres)")
                                        .font(.subheadline)
                                }
                                if let rating = book.starRating {
                                    StarRatingView(rating: rating)
                                        .font(.subheadline)
                                }
                                
                                // Book release date
                                Text("Release Date: \(formatDate(book.releaseDate))")
                                
                                
                            }
                        }
                    }
                }
                .navigationTitle("Search Books")
                .onAppear {
                                bookFetcher.searchBooks(byAuthor: "Jane Austen") // perform default search
                            }
            }
        }
    }
    
    struct AuthorView_Previews: PreviewProvider {
        static var previews: some View {
            AuthorView()
        }
    }
    
    
}
