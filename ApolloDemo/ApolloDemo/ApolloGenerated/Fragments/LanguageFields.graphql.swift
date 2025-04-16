// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GitHubGraphQLAPI {
  struct LanguageFields: GitHubGraphQLAPI.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString {
      #"fragment LanguageFields on Language { __typename color id name }"#
    }

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.Language }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("color", String?.self),
      .field("id", GitHubGraphQLAPI.ID.self),
      .field("name", String.self),
    ] }

    /// The color defined for the current language.
    var color: String? { __data["color"] }
    /// The Node ID of the Language object
    var id: GitHubGraphQLAPI.ID { __data["id"] }
    /// The name of the current language.
    var name: String { __data["name"] }
  }

}