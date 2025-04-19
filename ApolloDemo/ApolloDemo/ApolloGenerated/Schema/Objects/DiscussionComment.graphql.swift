// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// A comment on a discussion.
  static let DiscussionComment = ApolloAPI.Object(
    typename: "DiscussionComment",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.Comment.self,
      GitHubGraphQLAPI.Interfaces.Deletable.self,
      GitHubGraphQLAPI.Interfaces.Minimizable.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.Reactable.self,
      GitHubGraphQLAPI.Interfaces.Updatable.self,
      GitHubGraphQLAPI.Interfaces.UpdatableComment.self,
      GitHubGraphQLAPI.Interfaces.Votable.self
    ],
    keyFields: nil
  )
}