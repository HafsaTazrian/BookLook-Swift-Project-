//
//  ContentView.swift
//  BookIsh2.0
//
//  Created by Rakibul Nasib on 10/11/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                //ProfileView()
                BookListView()
           }
            else {
                LoginView()
            }
        }
        .background(Color(red: 189 / 255, green: 213 / 255, blue: 231 / 255).edgesIgnoringSafeArea(.all)) // Hardcoded RGB color

    }
}


    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environmentObject(AuthViewModel())
            .background(Color(red: 189 / 255, green: 213 / 255, blue: 231 / 255)) // Preview background
                
        }
    }

