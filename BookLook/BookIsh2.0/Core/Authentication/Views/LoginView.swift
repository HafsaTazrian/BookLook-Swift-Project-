//
//  LoginView.swift
//  BookIsh2.0
//
//  Created by Rakibul Nasib on 10/11/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        NavigationStack{
           //
            VStack {
                Spacer()
                //image
                Image("login")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 220, height: 200)
                    .padding(.vertical, 32)
                
                //form fields
                VStack(spacing: 24){
                    InputView(text: $email, title:"Email Address", placeholder: "name@example.com").autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    InputView(text: $password, title:" Password", placeholder: "Enter your password",
                    isSecuredField: true
                    ).autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                //sign in
                Button{
                    Task{
                        try await viewModel.signIn(
                            withEmail: email,
                            password: password)
                    }
                }
            label: {
                HStack{
                    Text("Sign In")
                        .fontWeight(.semibold)
                    Image(systemName: "arrow.right")
                }
                
                .frame(width: UIScreen.main.bounds.width - 32, height: 48)
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            }
            .background(Color(.black))
            .disabled(!formIsValid)
            .opacity(formIsValid ? 1.0 : 0.5)
            .cornerRadius(10.0)
            .padding(.top, 24)
            
            Spacer()
                //sign up
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack{
                        Text("Don't have an account?")
                            .foregroundColor(Color.black)
                        Text("Sign Up")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.black)
                    }
                }
            }
            .padding()
            .background(Color(red: 189 / 255, green: 213 / 255, blue: 231 / 255).edgesIgnoringSafeArea(.all)) // Set background color


        }
    }
}

extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>5
    }
}

#Preview {
    LoginView()
}
