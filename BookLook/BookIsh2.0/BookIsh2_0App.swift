

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
