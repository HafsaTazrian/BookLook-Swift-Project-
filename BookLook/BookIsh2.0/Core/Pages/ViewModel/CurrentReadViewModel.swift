import SwiftUI
import Firebase

// ViewModel to handle fetching books from the wishlist
class CurrentReadViewModel: ObservableObject {
    @Published var books = [Book]()
    private var db = Database.database().reference()

    init(userID: String) {
        fetchCurrentreadBooks(userID: userID)
    }

    func fetchCurrentreadBooks(userID: String) {
        db.child("users").child(userID).child("currentread").observe(.value, with: { snapshot in
                    var newBooks = [Book]()
                    for child in snapshot.children {
                        if let childSnapshot = child as? DataSnapshot,
                           let dict = childSnapshot.value as? [String: Any],
                           let id = dict["id"] as? Int,
                           let title = dict["title"] as? String,
                           let author = dict["author"] as? String {
                            let book = Book(id: id, title: title, author: author)
                            newBooks.append(book)
                        }
                    }
                    DispatchQueue.main.async {
                        self.books = newBooks
                    }
        })
    }
}
/*
// Define the Book model
struct Book: Identifiable {
    let id: Int
    let title: String
    let author: String
    // Add other properties as needed
}*/

// Define a view to display books in the wishlist
struct CurrentReadView: View {
    @ObservedObject var viewModel: CurrentReadViewModel

    var body: some View {
        List {
            ForEach(viewModel.books) { book in
                VStack(alignment: .leading) {
                    Text(book.title)
                        .font(.headline)
                    Text(book.author)
                        .font(.subheadline)
                }
            }
        }
        .navigationBarTitle("Current Read")
        
    }
}

// Usage in the main ContentView:
/*
struct ContentView: View {
    @StateObject var wishlistViewModel = WishListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // Navigate to WillReadView when the corresponding card is tapped
                NavigationLink(destination: WillReadView(viewModel: wishlistViewModel)) {
                    ReadingNowCardView()
                }
            }
            .navigationBarTitle("BookIsh")
        }
    }
}
*/
