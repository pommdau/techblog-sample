// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// A review object for a given pull request.
  static let PullRequestReview = ApolloAPI.Object(
    typename: "PullRequestReview",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.Comment.self,
      GitHubGraphQLAPI.Interfaces.Deletable.self,
      GitHubGraphQLAPI.Interfaces.Minimizable.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.Reactable.self,
      GitHubGraphQLAPI.Interfaces.RepositoryNode.self,
      GitHubGraphQLAPI.Interfaces.Updatable.self,
      GitHubGraphQLAPI.Interfaces.UpdatableComment.self
    ],
    keyFields: nil
  )
}