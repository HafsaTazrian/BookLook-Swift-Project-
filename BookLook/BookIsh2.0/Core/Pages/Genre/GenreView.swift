//
//  GenreView.swift
//  BookIsh2.0
//
//  Created by Hafsa Tazrian on 11/24/23.
//

import SwiftUI

struct GenreView: View {
    // Define your genre list as per your requirement
    let genres = [
        "Romance", "Thriller", "Horror", "Psychological",
        "Fantasy", "Mythology", "Mystery", "Comic",
        "Historic", "Detective", "Science Fiction", "Crime",
        "Comedy","Health","Mind & Body","Classics","Computers",
        "Humor","Young Adult"
    ]
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    Text("Genres")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Grid for genres
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(genres, id: \.self) { genre in
                            NavigationLink(destination: BookGenreListView(genre: genre)) {
                                Text(genre)
                                    .padding()
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding()
                    
                    // Horizontal scroll view for books
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<5) { _ in // Replace with your book data
                                VStack {
                                    Image("book_cover") // Replace with actual book cover images
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 150)
                                        .cornerRadius(5)
                                        .shadow(radius: 5)
                                    
                                    // Text("Book Title") // Replace with actual book title
                                    //Text("Author Name") // Replace with actual author name
                                }
                                .padding(.horizontal, 10)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: ProfileView()
                        ) {
                            Image(systemName: "person.crop.circle")
                                .imageScale(.large)
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .accentColor(.primary)
            
            
        }
    }
    
    struct GenreView_Previews: PreviewProvider {
        static var previews: some View {
            GenreView()
        }
    }
}
