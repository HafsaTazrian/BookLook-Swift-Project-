//
//  StatusView.swift
//  BookIsh2.0
//
//  Created by Hafsa Tazrian on 11/24/23.
//

import SwiftUI
import Firebase

// This struct represents the "Will Read" card that you can tap to see the wishlist.
struct ReadingCardView: View {
    let iconName: String
    let title: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination) {
            VStack {
                Image(systemName: iconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.black)
                Text(title)
                    .foregroundColor(.black)
            }
            .frame(width: 100, height: 100)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(10)
        }
    }
}

// This is the view where you'll navigate to the WillReadView.
struct StatusView: View {
    @StateObject var wishlistViewModel : WishListViewModel
    @StateObject var currentreadViewModel : CurrentReadViewModel
    @StateObject var havereadViewModel : HaveReadViewModel
    init() {
        if let userID = Auth.auth().currentUser?.uid {
            _wishlistViewModel = StateObject(wrappedValue: WishListViewModel(userID: userID))
            _currentreadViewModel = StateObject(wrappedValue: CurrentReadViewModel(userID: userID))
            _havereadViewModel = StateObject(wrappedValue: HaveReadViewModel(userID: userID))
        } else {
            // Handle the case where the user is not logged in
            _wishlistViewModel = StateObject(wrappedValue: WishListViewModel(userID: ""))
            _currentreadViewModel = StateObject(wrappedValue: CurrentReadViewModel(userID: ""))
            _havereadViewModel = StateObject(wrappedValue: HaveReadViewModel(userID: ""))
        }
    }
    
    var body: some View {
        
        NavigationView {
                    VStack() {
                        Spacer() // Add spacer to push content to center
                        Text("Update your reading status...")
                            
                        Image("status")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 200, height: 200)
                            .padding(.vertical, 32)
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                Spacer() // Add spacer for left padding
                                ReadingCardView(
                                    iconName: "eyeglasses",
                                    title: "Current Read",
                                    destination: AnyView(CurrentReadView(viewModel: currentreadViewModel))
                                )
                                ReadingCardView(
                                    iconName: "bookmark.fill",
                                    title: "Wish List",
                                    destination: AnyView(WillReadView(viewModel: wishlistViewModel))
                                )
                                ReadingCardView(
                                    iconName: "checkmark.circle.fill",
                                    title: "Have Read",
                                    destination: AnyView(HaveReadView(viewModel: havereadViewModel))
                                )
                                Spacer() // Add spacer for right padding
                            }
                            .padding(.vertical) // Add some vertical padding
                        }
                        .padding(.vertical ,10)
                        Spacer() // Add spacer to push content to center
                    }
                    .navigationBarTitle("BookLook")
                    .onAppear {
                        // Fetch books for the current user
                        if let userID = Auth.auth().currentUser?.uid {
                            wishlistViewModel.fetchWishlistBooks(userID: userID)
                            currentreadViewModel.fetchCurrentreadBooks(userID: userID)
                            havereadViewModel.fetchHavereadBooks(userID: userID)
                        }
                    }
                }
            }
    }





    
    // Assume WishListViewModel, WillReadView, and other necessary components are defined elsewhere.
    
    // Starting point of your SwiftUI app.
    
    struct BookishApp: App {
        var body: some Scene {
            WindowGroup {
                StatusView()
            }
        }
    }

