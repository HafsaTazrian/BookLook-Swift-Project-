//
//  BookIsh2_0App.swift
//  BookIsh2.0
//
//  Created by Rakibul Nasib on 10/11/23.
//

import SwiftUI
import Firebase

@main
struct BookIsh2_0App: App {
    @StateObject var viewModel = AuthViewModel()
    
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(viewModel)
        }
    }
}
