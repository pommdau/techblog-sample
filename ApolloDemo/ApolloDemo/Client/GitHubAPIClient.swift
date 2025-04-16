//
//  GitHubAPIClient.swift
//  ApolloDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/15.
//

import UIKit
import Apollo

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

extension GitHubAPIClient {
    
    func searchRepos(query: String, apolloClient: ApolloClient) async throws {
        // クエリの作成
        let query = GitHubGraphQLAPI.SearchReposQuery(query: query, after: nil)
        let data = try await apolloClient.fetch(query: query)
        let repos = data.search.edges
        print("stop")
//        let data = try await apolloClient.fetch(query: query)
//        let repos = data.user?.repositories.nodes?.compactMap { $0?.fragments.repositoryFields } ?? []
//        return repos
    }
    
}
