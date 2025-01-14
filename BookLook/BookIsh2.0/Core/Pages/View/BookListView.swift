
////
import SwiftUI


// Assuming ProfileView exists
//struct ProfileView: View {
//    var body: some View {
//        Text("Profile View")
//    }
//}

// Assuming Book model and BookFetcher are defined elsewhere and are correct
struct BookListView: View {
    @StateObject private var fetcher = BookFetcher()
    @State private var selectedTab = "home"
    @State private var searchText = ""    // For the search bar
    

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ScrollView {
                   // searchField
                    TextField("Search", text: $searchText, onCommit: {
                        fetcher.searchBooks(searchTerm: searchText)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    LazyVStack(alignment: .leading) {
                        ForEach(fetcher.books, id: \.id) { book in
                            BookRow(book: book)
                        }
                    }
                }
                .navigationTitle("BookLook")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person.crop.circle")
                                .imageScale(.large)
                        }
                    }
                }
                .onAppear {
                    fetcher.loadBooks()
                }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag("home")

            AuthorView() // Placeholder for Author View
                .tabItem {
                    Label("Author", systemImage: "person.fill")
                }
                .tag("author")

            StatusView() // Placeholder for Status View
                .tabItem {
                    Label("Status", systemImage: "hourglass")
                }
                .tag("status")

            GenreView()// Placeholder for Genre View
                .tabItem {
                    Label("Genre", systemImage: "music.note.list")
                }
                .tag("genre")
        }
    }
    
    private var searchField: some View {
            TextField("Search", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
        }

        private var searchResults: [Book] {
            if searchText.isEmpty {
                return fetcher.books
            } else {
                return fetcher.books.filter {
                    $0.title.localizedCaseInsensitiveContains(searchText) ||
                    $0.author.localizedCaseInsensitiveContains(searchText)
                    // Add more conditions if there are other fields to search by
                }
            }
        }
    }

        
    
    
    



struct BookRow: View {
    let book: Book

    var body: some View {
        NavigationLink(destination: BookDetailView(book: book)) {
            HStack {
                // Your existing HStack content for the book row
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
        }
        .padding(.horizontal)

    }
}



extension Image {
    func iconModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.gray)
            .frame(maxWidth: 50, maxHeight: 80)
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}

struct StarRatingView: View {
    let rating: Double

    private var fullStarCount: Int {
        return Int(rating)
    }

    private var hasHalfStar: Bool {
        return rating > Double(fullStarCount)
    }

    var body: some View {
        HStack {
            ForEach(0..<fullStarCount, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            if hasHalfStar {
                Image(systemName: "star.leadinghalf.fill")
                    .foregroundColor(.yellow)
            }
        }
    }
    
    
    
}


