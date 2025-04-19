//
//  GitHubAPIClient.swift
//  ApolloDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/16.
//

import Foundation
import Apollo

final actor GitHubAPIClient {
    
    // MARK: - Property
    
    static let shared: GitHubAPIClient = .init(
        clientID: GitHubAPICredentials.clientID,
        clientSecret: GitHubAPICredentials.clientSecret,
        // swiftlint:disable:next force_unwrapping
        callbackURL: URL(string: "apollodemo://callback")!
    )
    
    let clientID: String
    let clientSecret: String
    let callbackURL: URL
    
    private(set) var apollo: ApolloClient = .create()
        
    // MARK: - LifeCycle
        
    init(clientID: String, clientSecret: String, callbackURL: URL) {
        self.clientID = clientID
        self.clientSecret = clientSecret
        self.callbackURL = callbackURL
    }
    
    // MARK: - Setter
    
    func updateApolloClient(accessToken: String) {
        apollo = ApolloClient.create(accessToken: accessToken)
    }
}
