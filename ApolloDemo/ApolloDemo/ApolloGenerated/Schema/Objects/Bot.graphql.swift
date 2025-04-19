// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// A special type of user which takes actions on behalf of GitHub Apps.
  static let Bot = ApolloAPI.Object(
    typename: "Bot",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.Actor.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.UniformResourceLocatable.self
    ],
    keyFields: nil
  )
}