// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// An account on GitHub, with one or more owners, that has repositories, members and teams.
  static let Organization = ApolloAPI.Object(
    typename: "Organization",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.Actor.self,
      GitHubGraphQLAPI.Interfaces.AnnouncementBannerI.self,
      GitHubGraphQLAPI.Interfaces.MemberStatusable.self,
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