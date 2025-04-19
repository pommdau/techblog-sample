// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Objects {
  /// Audit log entry for a repo.remove_topic event.
  static let RepoRemoveTopicAuditEntry = ApolloAPI.Object(
    typename: "RepoRemoveTopicAuditEntry",
    implementedInterfaces: [
      GitHubGraphQLAPI.Interfaces.AuditEntry.self,
      GitHubGraphQLAPI.Interfaces.Node.self,
      GitHubGraphQLAPI.Interfaces.OrganizationAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.RepositoryAuditEntryData.self,
      GitHubGraphQLAPI.Interfaces.TopicAuditEntryData.self
    ],
    keyFields: nil
  )
}