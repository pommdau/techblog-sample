//
//  LoginView.swift
//  ApolloDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/14.
//

import SwiftUI

final actor GitHubAPIClient {
        
    let clientID: String
    let clientSecret: String
    let callbackURL: URL
    
    init(clientID: String, clientSecret: String, callbackURL: URL) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.callbackURL = callbackURL
    }
    
    @MainActor
    func openLoginPageInBrowser() async throws {
        // ログイン用URLの作成
        var urlComponents = URLComponents(string: "https://github.com/login/oauth/authorize")
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: clientID),
            URLQueryItem(name: "redirect_uri", value: callbackURL.absoluteString),
        ]
        guard let url = urlComponents?.url else {
            assertionFailure("Failed to create URL")
            return
        }
        
        await UIApplication.shared.open(url)
    }
}

struct LoginView: View {
    
    let callbackURL = URL(string: "apollodemo://callback")!
    
    var body: some View {
        Form {
            Button("Log in") {
                let url = URL(string: "https://github.com/login/oauth/authorize?client_id=\(GitHubAPICredentials.clientID)&redirect_uri=\(callbackURL.absoluteString)")!
                UIApplication.shared.open(url)
                print(url.absoluteString)
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

#Preview {
    LoginView()
}


