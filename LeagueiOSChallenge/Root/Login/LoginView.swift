//
//  LoginView.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-16.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private var viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
    }
    
    private enum Labels {
        static let introLabelTitle = "League Take Home Test"
        static let loginButtonTitle = "Login"
        static let continueASGuestTitle = "Continue as guest"
        static let loaderTitle = "Please wait..."
        static let alertTitle = "Error"
        static let okTitle = "OK"
    }
    
    var body: some View {
        ZStack{
            VStack(spacing: 24) {
                Text(Labels.introLabelTitle)
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.top, 50)
                
                Spacer()
                    .frame(height: 40)
                
                TextField("Username", text: $viewModel.username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 40)
                
                SecureField("Password", text: $viewModel.password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 40)
                
                Button {
                    viewModel.didTapOnLoginButton()
                } label: {
                    Text(Labels.loginButtonTitle)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.black)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 40)
                .padding(.top, 16)
                
                
                Button {
                    viewModel.didTapOnGuestButton()
                } label: {
                    Text(Labels.continueASGuestTitle)
                        .foregroundColor(.black)
                }
                .padding(.top, 8)
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(Labels.alertTitle),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text(Labels.okTitle))
                )
            }
            if viewModel.isLoading {
                ProgressView(Labels.loaderTitle)
            }
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel(apiHelper: APIHelper()))
}
