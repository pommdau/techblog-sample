// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// Audit log entry for a org.remove_member event.
  static let OrgRemoveMemberAuditEntry = ApolloAPI.Object(
    typename: "OrgRemoveMemberAuditEntry",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.AuditEntry.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.OrganizationAuditEntryData.self
    ],
    keyFields: nil
  )
}