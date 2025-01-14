

import SwiftUI

struct RegistrationView: View {
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        //Spacer()
        VStack {
            //image
            Image("login")
                .resizable()
                .scaledToFill()
                .frame(width: 140, height: 120)
                .padding(.vertical, 32)
            
            //form fields
            VStack(spacing: 24){
                InputView(text: $email,
                    title:"Email Address",
                    placeholder:"name@example.com").autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                InputView(text: $fullname,
                          title:"Full Name",
                          placeholder:"Name")
                InputView(
                    text: $password,
                    title:"Password",
                    placeholder: "password",
                isSecuredField: true).autocapitalization(.none)
                ZStack(
                    alignment: .trailing){
                        InputView(
                            text:$confirmPassword,
                            title:"Confirm password",
                                  placeholder: "Confirm your password",
                                  isSecuredField: true)
                        if !password.isEmpty && !confirmPassword.isEmpty {
                            if password == confirmPassword {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemGreen))
                            }
                            else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(.systemRed))
                            }
                        }
                }
            }
            .padding(.horizontal)
            .padding(.top, 12)
            
            Button{
                Task{
                    try await viewModel.createUser(
                        withEmail: email,
                        password: password,
                        fullname: fullname)
                }

            } label: {
            HStack{
                Text("Sign Up")
                    .fontWeight(.semibold)
                Image(systemName: "arrow.right")
            }
            
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
        }            .background(Color(.black))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10.0)
                .padding(.top, 24)
         
            Spacer()
            
            Button {
                dismiss()
            } label: {
                HStack{
                    Text("Already have an account?")
                        .foregroundColor(Color.black)
                    Text("Sign In")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.black)
                }
            }
            
        }
        .padding()
        .background(Color(red: 189 / 255, green: 213 / 255, blue: 231 / 255).edgesIgnoringSafeArea(.all)) // Set background color

    }
}

extension RegistrationView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count>5
        && confirmPassword == password
        && !fullname.isEmpty
    }
}

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
