// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// A repository contains the content for a project.
  static let Repository = ApolloAPI.Object(
    typename: "Repository",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.PackageOwner.self,
      GitHubGraphQLAPI.Interfaces.ProjectOwner.self,
      GitHubGraphQLAPI.Interfaces.ProjectV2Recent.self,
      GitHubGraphQLAPI.Interfaces.RepositoryInfo.self,
      GitHubGraphQLAPI.Interfaces.Starrable.self,
      GitHubGraphQLAPI.Interfaces.Subscribable.self,
      GitHubGraphQLAPI.Interfaces.UniformResourceLocatable.self
    ],
    keyFields: nil
  )
}