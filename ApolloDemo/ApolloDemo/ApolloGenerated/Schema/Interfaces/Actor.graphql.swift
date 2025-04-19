// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

extension GitHubGraphQLAPI.Interfaces {
  /// Represents an object which can take actions on GitHub. Typically a User or Bot.
  static let Actor = ApolloAPI.Interface(
    name: "Actor",
    keyFields: nil,
    implementingObjects: [
      "Bot",
      "EnterpriseUserAccount",
      "Mannequin",
      "Organization",
      "User"
    ]
  )
}