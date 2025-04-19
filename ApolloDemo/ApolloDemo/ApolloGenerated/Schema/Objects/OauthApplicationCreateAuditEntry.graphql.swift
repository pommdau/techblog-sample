// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// Audit log entry for a oauth_application.create event.
  static let OauthApplicationCreateAuditEntry = ApolloAPI.Object(
    typename: "OauthApplicationCreateAuditEntry",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.AuditEntry.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.OauthApplicationAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.OrganizationAuditEntryData.self
    ],
    keyFields: nil
  )
}