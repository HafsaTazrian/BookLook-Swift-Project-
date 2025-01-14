//
//  AuthorBookDetailView.swift
//  BookIsh2.0
//
//  Created by Hafsa Tazrian on 11/25/23.
//

import SwiftUI

// Assuming the Book model has properties for title, author, description, etc.
struct AuthorBookDetailView: View {
    let book: AuthorBook  // Make sure to use the correct book model that includes all necessary info

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // AsyncImage to load book cover
                if let url = book.coverImageURL {
                    AsyncImage(url: url) { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(maxHeight: 150)
                             .cornerRadius(10)
                    } placeholder: {
                        Color.gray.opacity(0.3)
                             .aspectRatio(2/3, contentMode: .fit)
                             .cornerRadius(10)
                    }
                }

                // Book title
                Text(book.title)
                    .font(.title)
                    .fontWeight(.bold)

                // Book author
                Text("by \(book.author)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)

                // Book genres
                if let genres = book.genres, !genres.isEmpty {
                    Text("Genres: \(genres.joined(separator: ", "))")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }

                // Book average rating
                if let rating = book.starRating {
                    HStack {
                        Text("Rating:")
                            .fontWeight(.bold)
                        StarRatingView(rating: rating)
                    }
                    .font(.headline)
                }

                // Book release date
                if let releaseDate = book.releaseDate {
                    Text("Released: \(releaseDate)")
                        .font(.headline)
                }

                // Book description
                if let description = book.description {
                    Text(description)
                        .font(.body)
                }

                Spacer()  // Pushes all content to the top
            }
            .padding()
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

    


// Preview provider for SwiftUI previews
struct AuthorBookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Make sure to provide a sample book instance with dummy data
        AuthorBookDetailView(book: AuthorBook.sample)
    }
}

// Extension to AuthorBook to provide sample data for previews
extension AuthorBook {
    static var sample: AuthorBook {
        return AuthorBook(id: 123, title: "Sample Book", author: "Jane Doe", coverImageURL: URL(string: "https://example.com/cover.jpg"), starRating: 4.5, genres: ["Fiction", "Mystery"], description: "This is a sample book description.", releaseDate: "January 1, 2020")
    }
}
