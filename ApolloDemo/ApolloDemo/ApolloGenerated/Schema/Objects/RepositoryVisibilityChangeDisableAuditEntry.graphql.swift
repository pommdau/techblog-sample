// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// Audit log entry for a repository_visibility_change.disable event.
  static let RepositoryVisibilityChangeDisableAuditEntry = ApolloAPI.Object(
    typename: "RepositoryVisibilityChangeDisableAuditEntry",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.AuditEntry.self,
      GitHubGraphQLAPI.Interfaces.EnterpriseAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.OrganizationAuditEntryData.self
    ],
    keyFields: nil
  )
}