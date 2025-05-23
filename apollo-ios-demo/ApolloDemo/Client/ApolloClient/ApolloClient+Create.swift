//
//  ApolloClient+create.swift
//  ApolloDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/15.
//

import Foundation
import Apollo

// MARK: - Factory Method

extension ApolloClient {
    static func create(accessToken: String? = nil) -> ApolloClient {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        let client = URLSessionClient()
        let provider = DefaultInterceptorProvider(client: client, store: store)
        // swiftlint:disable:next force_unwrapping
        let url = URL(string: "https://api.github.com/graphql")!
        
        let headers: [String: String] = if let accessToken {
            ["Authorization": "Bearer \(accessToken)"]
        } else {
            [:]
        }
        
        let transport = RequestChainNetworkTransport(
            interceptorProvider: provider,
            endpointURL: url,
            additionalHeaders: headers
        )
        return ApolloClient(networkTransport: transport, store: store)
    }
}
