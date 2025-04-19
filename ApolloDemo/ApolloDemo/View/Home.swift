//
//  Home.swift
//  ApolloDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/16.
//

import SwiftUI

struct Home: View {
    
    // MARK: - Property
        
    @State private var gitHubAPIClient = GitHubAPIClient.shared
    
    @State private var sessionCode: String?

    @AppStorage("accessToken")
    private var accessToken: String?
    
    // MARK: User Input
    
    @AppStorage("fetchUserInput")
    private var fetchUserInput = "pommdau"
    
    @AppStorage("fetchUserReposInput")
    private var fetchUserReposInput = "pommdau"
    
    @AppStorage("searchReposInput")
    private var searchReposInput = "SwiftUI"
    
    // MARK: - View
        
    var body: some View {
        Form {
            authSection()
            actionSection()
        }
        .onOpenURL { url in
            do {
                self.sessionCode = try gitHubAPIClient.handleCallbackURLAndExtractSessionCode(url: url)
            } catch {
                print(error.localizedDescription)
            }
        }
        .onAppear {
            Task {
                // 有効なアクセストークンがあれば読み込む
                if let accessToken {
                    await gitHubAPIClient.updateApolloClient(accessToken: accessToken)
                }
            }
        }
    }
        
    @ViewBuilder
    private func authSection() -> some View {
        // swiftlint:disable:next closure_body_length
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
                        let accessToken = try await gitHubAPIClient.fetchAccessToken(sessionCode: sessionCode)
                        self.accessToken = accessToken
                        await gitHubAPIClient.updateApolloClient(accessToken: accessToken)
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
                    await gitHubAPIClient.updateApolloClient(accessToken: "")
                }
            }
        }
    }
    
    @ViewBuilder
    private func actionSection() -> some View {
        // swiftlint:disable:next closure_body_length
        Section("Action") {
            HStack {
                TextField("UserName", text: $fetchUserInput)
                Button("Fetch User") {
                    Task {
                        do {
                            let user = try await gitHubAPIClient.fetchUser(login: fetchUserInput)
                            print(user ?? "no user")
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            
            HStack {
                TextField("UserName", text: $fetchUserReposInput)
                Button("Fetch UserRepos") {
                    Task {
                        do {
                            let repos = try await gitHubAPIClient.fetchUserRepos(login: fetchUserReposInput)
                            for repo in repos {
                                print("\(repo.owner.login)/\(repo.name)")
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
            
            HStack {
                TextField("Keyword", text: $searchReposInput)
                Button("Search Repos") {
                    Task {
                        do {
                            let repos = try await gitHubAPIClient.searchRepos(query: searchReposInput)
                            for repo in repos {
                                print("\(repo.owner.login)/\(repo.name)")
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Home()
}
