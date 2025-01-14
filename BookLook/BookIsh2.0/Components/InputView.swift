//
//  InputView.swift
//  BookIsh2.0
//
//  Created by Rakibul Nasib on 10/11/23.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecuredField = false
    var body: some View {
        VStack(alignment: .leading, spacing: 12){
            Text(title)
                .foregroundColor(Color(.darkGray))
                .fontWeight(.semibold)
                .font(.footnote)
            if isSecuredField{
                SecureField(placeholder, text: $text)

                    .font(.system(size: 14))            }
            else{
                TextField(placeholder, text: $text)

                    .font(.system(size: 14))
            }
            Divider()
        }
    }
}

#Preview {
    InputView(text: .constant(""), title: "Email address", placeholder:"name@example.com")
}
