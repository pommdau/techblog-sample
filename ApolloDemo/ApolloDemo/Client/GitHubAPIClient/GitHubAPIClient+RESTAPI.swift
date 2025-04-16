//
//  GitHubAPIClient.swift
//  ApolloDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/15.
//

import UIKit

// MARK: - 認証

extension GitHubAPIClient {
    @MainActor
    func openLoginPageInBrowser() {
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
        
        UIApplication.shared.open(url)
    }
    
    func fetchAccessToken(sessionCode: String) async throws -> String {
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
    
    @MainActor
    func handleCallbackURLAndExtractSessionCode(url: URL) throws -> String {
        guard
            let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let queryItems = components.queryItems,
            let sessionCode = queryItems.first(where: { $0.name == "code" })?.value
        else {
            fatalError("コールバックURLの値が不正です")
        }
        return sessionCode
    }
    
    func logout(accessToken: String) async throws {
        // リクエストの作成
        guard let url = URL(string: "https://api.github.com/applications/\(clientID)/grant") else {
            print("リクエストURLの作成に失敗")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let authorizationValue = Data("\(clientID):\(clientSecret)".utf8).base64EncodedString()
        request.addValue("Basic \(authorizationValue)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/vnd.github+json", forHTTPHeaderField: "Accept")
        request.addValue("2022-11-28", forHTTPHeaderField: "X-GitHub-Api-Version")
        
        let bodyDict = [
            "access_token": accessToken
        ]
        guard let body = try? JSONSerialization.data(withJSONObject: bodyDict, options: []) else {
            print("リクエストBodyの作成に失敗")
            return
        }
        request.httpBody = body
        
        // リクエストの送信
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            if let httpResponse = response as? HTTPURLResponse,
               (200..<300).contains(httpResponse.statusCode) {
                // 成功
                print("Logout: Success")
                return
            }
            // 失敗
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            print(jsonObject)
        } catch {
            print(error.localizedDescription)
        }
    }
}
