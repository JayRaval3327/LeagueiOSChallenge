//
//  FeedView.swift
//  LeagueiOSChallenge
//
//  Created by Jay Raval on 2025-04-17.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject private var viewModel: FeedViewModel
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }
    
    private enum Labels {
        static let loaderTitle = "Loading posts..."
        static let alertTitle = "Error"
        static let okTitle = "OK"
        static let guestAlertTitle = "Thank You"
        static let guestAlertMessage = "Thank you for trialing this app"
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView(Labels.loaderTitle)
                } else {
                    List {
                        ForEach(viewModel.feeds) { feed in
                            buildFeedItem(feed: feed)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                switch viewModel.activeAlert {
                case .error:
                    Alert(
                        title: Text(Labels.alertTitle),
                        message: Text(viewModel.alertMessage),
                        dismissButton: .default(Text(Labels.okTitle))
                    )
                case .guest:
                    Alert(
                        title: Text(Labels.guestAlertTitle),
                        message: Text(Labels.guestAlertMessage),
                        dismissButton: .default(Text(Labels.okTitle)) {
                            viewModel.dismissViewController()
                        }
                    )
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    @ViewBuilder
    private func buildFeedItem(feed: FeedDisplayable) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Button {
                viewModel.didTapUser(feed)
            } label: {
                AsyncImage(url: URL(string: feed.avatarURL)) { image in
                    image
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .foregroundColor(.blue)
                } placeholder: {
                    Color.gray
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                .frame(width: 50, height: 50)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Button {
                    viewModel.didTapUser(feed)
                } label: {
                    Text(feed.username)
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                
                Text(feed.title)
                    .font(.title3)
                    .fontWeight(.semibold)
                
                Text(feed.description)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 8)

    }
    
}
