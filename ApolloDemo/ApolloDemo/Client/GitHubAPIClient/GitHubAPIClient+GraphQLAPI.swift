//
//  GitHubAPIClient+GraphQLAPI.swift
//  ApolloDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/16.
//

import Foundation
import Apollo

// MARK: - 検索

extension GitHubAPIClient {
    
    func fetchUser(login: String) async throws -> GitHubGraphQLAPI.UserFields? {
        let query = GitHubGraphQLAPI.FetchUserQuery(login: login)
        let data = try await apollo.fetch(query: query)
        let user = data.user?.fragments.userFields
        return user
    }
    
    func fetchUserRepos(login: String) async throws -> [GitHubGraphQLAPI.RepositoryFields] {
        let query = GitHubGraphQLAPI.FetchUserReposQuery(login: login)
        let data = try await apollo.fetch(query: query)
        let repos = data.user?.repositories.nodes?.compactMap { $0?.fragments.repositoryFields } ?? []
        return repos
    }
    
    func searchRepos(query: String, first: Int = 10, after: String? = nil) async throws -> [GitHubGraphQLAPI.RepositoryFields] {
        let after: GraphQLNullable<String> = if let after {
            .some(after)
        } else {
            .none
        }
        
        let query = GitHubGraphQLAPI.SearchReposQuery(
            query: query,
            first: .some(first),
            after: after
        )
        let data = try await apollo.fetch(query: query)
        let repos = data.search.edges?.compactMap { $0?.node?.asRepository?.fragments.repositoryFields } ?? []
        
        return repos
    }
    
}

