// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// Audit log entry for a repo.config.enable_contributors_only event.
  static let RepoConfigEnableContributorsOnlyAuditEntry = ApolloAPI.Object(
    typename: "RepoConfigEnableContributorsOnlyAuditEntry",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.AuditEntry.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.OrganizationAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.RepositoryAuditEntryData.self
    ],
    keyFields: nil
  )
}