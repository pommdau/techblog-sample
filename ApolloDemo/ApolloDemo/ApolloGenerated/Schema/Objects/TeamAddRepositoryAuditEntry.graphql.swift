// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// Audit log entry for a team.add_repository event.
  static let TeamAddRepositoryAuditEntry = ApolloAPI.Object(
    typename: "TeamAddRepositoryAuditEntry",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.AuditEntry.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.OrganizationAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.RepositoryAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.TeamAuditEntryData.self
    ],
    keyFields: nil
  )
}