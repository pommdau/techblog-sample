// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// Audit log entry for a repo.config.disable_anonymous_git_access event.
  static let RepoConfigDisableAnonymousGitAccessAuditEntry = ApolloAPI.Object(
    typename: "RepoConfigDisableAnonymousGitAccessAuditEntry",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.AuditEntry.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.OrganizationAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.RepositoryAuditEntryData.self
    ],
    keyFields: nil
  )
}