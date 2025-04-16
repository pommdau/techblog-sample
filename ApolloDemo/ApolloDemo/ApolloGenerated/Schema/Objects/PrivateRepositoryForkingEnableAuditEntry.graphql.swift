// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// Audit log entry for a private_repository_forking.enable event.
  static let PrivateRepositoryForkingEnableAuditEntry = ApolloAPI.Object(
    typename: "PrivateRepositoryForkingEnableAuditEntry",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.AuditEntry.self,
      GitHubGraphQLAPI.Interfaces.EnterpriseAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.OrganizationAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.RepositoryAuditEntryData.self
    ],
    keyFields: nil
  )
}