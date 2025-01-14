//
//  BookListView.swift
//  BookIsh2.0
//
//  Created by Hafsa Tazrian on 11/24/23.
//

import SwiftUI


// A view representing a clickable genre button.
struct GenreButton: View {
    let genre: String
    
    var body: some View {
        NavigationLink(destination: BookGenreListView(genre: genre)) {
            Text(genre)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
}

// The main view displaying a grid of genres.
struct GenresGridView: View {
    let genres: [String] = [
        "Romance", "Thriller", "Horror", "Psychological",
        "Fantasy", "Mythology", "Mystery", "Comic",
        "Historic", "Detective", "Science Fiction", "Crime",
        "Comedy"
    ]
    
    // Define two columns for the grid layout.
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                // Create a grid with two columns.
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(genres, id: \.self) { genre in
                        GenreButton(genre: genre)
                    }
                }
                .padding()
            }
            .navigationTitle("Genres")
        }
    }
}

// A preview provider for the GenresGridView.
struct GenresGridView_Previews: PreviewProvider {
    static var previews: some View {
        GenresGridView()
    }
}

// A placeholder view that represents the list of books for a selected genre.
/*
struct BookGenreListView: View {
    var genre: String
    
    var body: some View {
        // Display the genre name in the navigation bar.
        Text("\(genre) books list view")
            .navigationTitle(genre)
    }
}
*/
