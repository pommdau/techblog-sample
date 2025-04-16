// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// An Issue is a place to discuss ideas, enhancements, tasks, and bugs for a project.
  static let Issue = ApolloAPI.Object(
    typename: "Issue",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.Assignable.self,
      GitHubGraphQLAPI.Interfaces.Closable.self,
      GitHubGraphQLAPI.Interfaces.Comment.self,
      GitHubGraphQLAPI.Interfaces.Deletable.self,
      GitHubGraphQLAPI.Interfaces.Labelable.self,
      GitHubGraphQLAPI.Interfaces.Lockable.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.ProjectV2Owner.self,
      GitHubGraphQLAPI.Interfaces.Reactable.self,
      GitHubGraphQLAPI.Interfaces.RepositoryNode.self,
      GitHubGraphQLAPI.Interfaces.Subscribable.self,
      GitHubGraphQLAPI.Interfaces.SubscribableThread.self,
      GitHubGraphQLAPI.Interfaces.UniformResourceLocatable.self,
      GitHubGraphQLAPI.Interfaces.Updatable.self,
      GitHubGraphQLAPI.Interfaces.UpdatableComment.self
    ],
    keyFields: nil
  )
}