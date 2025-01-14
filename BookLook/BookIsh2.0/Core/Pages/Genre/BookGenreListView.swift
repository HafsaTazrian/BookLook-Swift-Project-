//
//  BookGenreListView.swift
//  BookIsh2.0
//
//  Created by Hafsa Tazrian on 11/24/23.
//

import SwiftUI


struct BookGenreListView: View {
    var genre: String
    @StateObject var viewModel = BookGenreViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.books) { book in
                NavigationLink(destination: BookDetailView(book: book)) {
                    HStack {
                                    AsyncImage(url: book.coverImageURL) { phase in
                                        switch phase {
                                        case .empty:
                                            ProgressView()
                                        case .success(let image):
                                            image.resizable()
                                        case .failure:
                                            Image(systemName: "book.closed").iconModifier()
                                        @unknown default:
                                            EmptyView()
                                        }
                                    }
                                    .frame(width: 50, height: 80)
                                    .cornerRadius(5)
                    
                                    VStack(alignment: .leading) {
                                        Text(book.title)
                                            .font(.headline)
                                        Text(book.author)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                        if let genres = book.genres, !genres.isEmpty {
                                            Text(genres.joined(separator: ", "))
                                                .font(.caption)
                                                .foregroundColor(.secondary)
                                        }
                                        if let rating = book.averageRating {
                                            StarRatingView(rating: rating)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                }
            }
            .navigationTitle(genre)
            .onAppear {
                viewModel.loadBooks(forGenre: genre)
            }
        }
    }
}


//struct BookGenreListView: View {
//    var genre: String
//    @StateObject var viewModel = BookGenreViewModel()
//
//    var body: some View {
//        List(viewModel.books) { book in
//            
//            HStack {
//                AsyncImage(url: book.coverImageURL) { phase in
//                    switch phase {
//                    case .empty:
//                        ProgressView()
//                    case .success(let image):
//                        image.resizable()
//                    case .failure:
//                        Image(systemName: "book.closed").iconModifier()
//                    @unknown default:
//                        EmptyView()
//                    }
//                }
//                .frame(width: 50, height: 80)
//                .cornerRadius(5)
//
//                VStack(alignment: .leading) {
//                    Text(book.title)
//                        .font(.headline)
//                    Text(book.author)
//                        .font(.subheadline)
//                        .foregroundColor(.secondary)
//                    if let genres = book.genres, !genres.isEmpty {
//                        Text(genres.joined(separator: ", "))
//                            .font(.caption)
//                            .foregroundColor(.secondary)
//                    }
//                    if let rating = book.averageRating {
//                        StarRatingView(rating: rating)
//                    }
//                }
//            }
//            .padding(.horizontal)
//        }
//        .navigationTitle(genre)
//        .onAppear {
//            viewModel.loadBooks(forGenre: genre)
//        }
//    }
//}
