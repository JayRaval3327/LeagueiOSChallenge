//
//  ProfileView.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-18.
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject private var viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: viewModel.feed.avatarURL)) { image in
                image
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .foregroundColor(.blue)
            } placeholder: {
                Color.gray
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
            }
            .frame(width: 120, height: 120)
            
            
            Text(viewModel.feed.username)
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                Text(viewModel.feed.email)
                    .font(.body)
                
                if !viewModel.isValidEmail {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.yellow)
                }
            }
            
            Spacer()
        }
        .padding()
    }
}
