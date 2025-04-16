// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Unions {
  /// The results of a search.
  static let SearchResultItem = Union(
    name: "SearchResultItem",
    possibleTypes: [
      GitHubGraphQLAPI.Objects.App.self,
      GitHubGraphQLAPI.Objects.Discussion.self,
      GitHubGraphQLAPI.Objects.Issue.self,
      GitHubGraphQLAPI.Objects.MarketplaceListing.self,
      GitHubGraphQLAPI.Objects.Organization.self,
      GitHubGraphQLAPI.Objects.PullRequest.self,
      GitHubGraphQLAPI.Objects.Repository.self,
      GitHubGraphQLAPI.Objects.User.self
    ]
  )
}