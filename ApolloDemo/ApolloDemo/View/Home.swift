//
//  Home.swift
//  ApolloDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/16.
//

import SwiftUI

struct Home: View {
    
    @State private var gitHubAPIClient = GitHubAPIClient.shared
            
    @State private var sessionCode: String?
    @AppStorage("accessToken")
    private var accessToken: String?
    
    var body: some View {
        Form {
            authSection()
            
            Section("Action") {
                Button("Search Repos") {
                    Task {
                        
                    }
                }
            }
        }
        .onOpenURL { url in
            do {
                self.sessionCode = try gitHubAPIClient.handleCallbackURLAndExtractSessionCode(url: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    @ViewBuilder
    private func authSection() -> some View {
        Section("Auth") {
            LabeledContent("Code", value: sessionCode ?? "(nil)")
            LabeledContent("AccessToken", value: accessToken ?? "(nil)")
            
            Button("Log in") {
                gitHubAPIClient.openLoginPageInBrowser()
            }
            
            Button("Fetch AccessToken") {
                Task {
                    do {
                        guard let sessionCode else {
                            print("Not found sessionCode")
                            return
                        }
                        self.accessToken = try await gitHubAPIClient.fetchAccessToken(sessionCode: sessionCode)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            
            Button("Print AccessToken") {
                print(accessToken ?? "(nil)")
            }

            
            Button("Logout", role: .destructive) {
                Task {
                    do {
                        guard let accessToken else {
                            return
                        }
                        try await gitHubAPIClient.logout(accessToken: accessToken)
                    } catch {
                        print("ログアウトエラー")
                        return
                    }
                    sessionCode = nil
                    accessToken = nil
                }
            }
        }
    }
}

#Preview {
    Home()
}
