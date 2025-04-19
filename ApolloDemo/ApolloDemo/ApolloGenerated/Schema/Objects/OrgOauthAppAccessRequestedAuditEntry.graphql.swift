// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// Audit log entry for a org.oauth_app_access_requested event.
  static let OrgOauthAppAccessRequestedAuditEntry = ApolloAPI.Object(
    typename: "OrgOauthAppAccessRequestedAuditEntry",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.AuditEntry.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.OauthApplicationAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.OrganizationAuditEntryData.self
    ],
    keyFields: nil
  )
}