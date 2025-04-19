// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// Audit log entry for a org.oauth_app_access_blocked event.
  static let OrgOauthAppAccessBlockedAuditEntry = ApolloAPI.Object(
    typename: "OrgOauthAppAccessBlockedAuditEntry",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.AuditEntry.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.OauthApplicationAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.OrganizationAuditEntryData.self
    ],
    keyFields: nil
  )
}