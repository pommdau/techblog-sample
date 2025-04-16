//
//  LoginView.swift
//  ApolloDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/14.
//

import SwiftUI
import Apollo

struct LoginView: View {
    
    let callbackURL = URL(string: "apollodemo://callback")!
    @State private var sessionCode: String?
    
    @AppStorage("accessToken")
    private var accessToken: String?
    
    @State var apolloClient = ApolloClient.create()
    
    var body: some View {
        Form {
            LabeledContent("Code", value: sessionCode ?? "(nil)")
            LabeledContent("AccessToken", value: accessToken ?? "(nil)")
            
            Button("Log in") {
                let url = URL(string: "https://github.com/login/oauth/authorize?client_id=\(GitHubAPICredentials.clientID)&redirect_uri=\(callbackURL.absoluteString)")!
                UIApplication.shared.open(url)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            Button("Fetch AccessToken") {
                Task {
                    do {
                        guard let sessionCode else {
                            print("Not found sessionCode")
                            return
                        }
                        self.accessToken = try await fetchAccessToken(sessionCode: sessionCode)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .disabled(sessionCode == nil)
            .frame(maxWidth: .infinity, alignment: .center)
            
            Button("Print AccessToken") {
                print(accessToken ?? "(nil)")
            }
            
            Button("Search Repos") {
                Task {
                    let apolloClient = ApolloClient.create(accessToken: accessToken)
                    do {
                        let query = GitHubGraphQLAPI.SearchReposQuery(query: "SwiftUI", after: nil)
                        let data = try await apolloClient.fetch(query: query)
                        let repos =  data.search.edges?.compactMap { $0?.node?.asRepository } ?? []
                        for repo in repos {
                            print("id: \(repo.id), name: \(repo.name)")
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .onOpenURL { url in
            guard
                let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                let queryItems = components.queryItems,
                let sessionCode = queryItems.first(where: { $0.name == "code" })?.value
            else {
                fatalError("コールバックURLの値が不正です")
            }
            self.sessionCode = sessionCode
        }
    }
    
    private func fetchAccessToken(sessionCode: String) async throws -> String {
        // リクエストの作成
        let url = URL(string: "https://github.com/login/oauth/access_token")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // ヘッダの設定
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        // bodyの設定
        let bodyDict = [
            "client_id": GitHubAPICredentials.clientID,
            "client_secret": GitHubAPICredentials.clientSecret,
            "code": sessionCode
        ]
        let body = try JSONSerialization.data(withJSONObject: bodyDict, options: [])
        request.httpBody = body
        
        // リクエストの送信
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // レスポンスのデコード
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        guard
            let jsonDict = jsonObject as? [String: Any],
            let accessToken = jsonDict["access_token"] as? String
        else {
            fatalError("レスポンスのデコードに失敗")
        }
        
        return accessToken
    }
}

#Preview {
    LoginView()
}


