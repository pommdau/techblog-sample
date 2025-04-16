// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// A user is an individual's account on GitHub that owns repositories and can make new content.
  static let User = ApolloAPI.Object(
    typename: "User",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.Actor.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.PackageOwner.self,
      GitHubGraphQLAPI.Interfaces.ProfileOwner.self,
      GitHubGraphQLAPI.Interfaces.ProjectOwner.self,
      GitHubGraphQLAPI.Interfaces.ProjectV2Owner.self,
      GitHubGraphQLAPI.Interfaces.ProjectV2Recent.self,
      GitHubGraphQLAPI.Interfaces.RepositoryDiscussionAuthor.self,
      GitHubGraphQLAPI.Interfaces.RepositoryDiscussionCommentAuthor.self,
      GitHubGraphQLAPI.Interfaces.RepositoryOwner.self,
      GitHubGraphQLAPI.Interfaces.Sponsorable.self,
      GitHubGraphQLAPI.Interfaces.UniformResourceLocatable.self
    ],
    keyFields: nil
  )
}