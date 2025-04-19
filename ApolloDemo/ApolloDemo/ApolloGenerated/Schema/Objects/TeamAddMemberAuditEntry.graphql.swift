// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// Audit log entry for a team.add_member event.
  static let TeamAddMemberAuditEntry = ApolloAPI.Object(
    typename: "TeamAddMemberAuditEntry",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.AuditEntry.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.OrganizationAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.TeamAuditEntryData.self
    ],
    keyFields: nil
  )
}