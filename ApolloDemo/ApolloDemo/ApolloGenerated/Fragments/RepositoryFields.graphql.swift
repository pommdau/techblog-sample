// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GitHubGraphQLAPI {
  struct RepositoryFields: GitHubGraphQLAPI.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString {
      #"fragment RepositoryFields on Repository { __typename createdAt description forkCount homepageUrl id isFork isPrivate languages(first: 10) { __typename edges { __typename node { __typename ...LanguageFields } size } totalCount totalSize } name owner { __typename avatarUrl id login url } primaryLanguage { __typename ...LanguageFields } pushedAt stargazerCount updatedAt url }"#
    }

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.Repository }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("createdAt", GitHubGraphQLAPI.DateTime.self),
      .field("description", String?.self),
      .field("forkCount", Int.self),
      .field("homepageUrl", GitHubGraphQLAPI.URI?.self),
      .field("id", GitHubGraphQLAPI.ID.self),
      .field("isFork", Bool.self),
      .field("isPrivate", Bool.self),
      .field("languages", Languages?.self, arguments: ["first": 10]),
      .field("name", String.self),
      .field("owner", Owner.self),
      .field("primaryLanguage", PrimaryLanguage?.self),
      .field("pushedAt", GitHubGraphQLAPI.DateTime?.self),
      .field("stargazerCount", Int.self),
      .field("updatedAt", GitHubGraphQLAPI.DateTime.self),
      .field("url", GitHubGraphQLAPI.URI.self),
    ] }

    /// Identifies the date and time when the object was created.
    var createdAt: GitHubGraphQLAPI.DateTime { __data["createdAt"] }
    /// The description of the repository.
    var description: String? { __data["description"] }
    /// Returns how many forks there are of this repository in the whole network.
    var forkCount: Int { __data["forkCount"] }
    /// The repository's URL.
    var homepageUrl: GitHubGraphQLAPI.URI? { __data["homepageUrl"] }
    /// The Node ID of the Repository object
    var id: GitHubGraphQLAPI.ID { __data["id"] }
    /// Identifies if the repository is a fork.
    var isFork: Bool { __data["isFork"] }
    /// Identifies if the repository is private or internal.
    var isPrivate: Bool { __data["isPrivate"] }
    /// A list containing a breakdown of the language composition of the repository.
    var languages: Languages? { __data["languages"] }
    /// The name of the repository.
    var name: String { __data["name"] }
    /// The User owner of the repository.
    var owner: Owner { __data["owner"] }
    /// The primary language of the repository's code.
    var primaryLanguage: PrimaryLanguage? { __data["primaryLanguage"] }
    /// Identifies the date and time when the repository was last pushed to.
    var pushedAt: GitHubGraphQLAPI.DateTime? { __data["pushedAt"] }
    /// Returns a count of how many stargazers there are on this object
    var stargazerCount: Int { __data["stargazerCount"] }
    /// Identifies the date and time when the object was last updated.
    var updatedAt: GitHubGraphQLAPI.DateTime { __data["updatedAt"] }
    /// The HTTP URL for this repository
    var url: GitHubGraphQLAPI.URI { __data["url"] }

    /// Languages
    ///
    /// Parent Type: `LanguageConnection`
    struct Languages: GitHubGraphQLAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.LanguageConnection }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("edges", [Edge?]?.self),
        .field("totalCount", Int.self),
        .field("totalSize", Int.self),
      ] }

      /// A list of edges.
      var edges: [Edge?]? { __data["edges"] }
      /// Identifies the total count of items in the connection.
      var totalCount: Int { __data["totalCount"] }
      /// The total size in bytes of files written in that language.
      var totalSize: Int { __data["totalSize"] }

      /// Languages.Edge
      ///
      /// Parent Type: `LanguageEdge`
      struct Edge: GitHubGraphQLAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.LanguageEdge }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("node", Node.self),
          .field("size", Int.self),
        ] }

        var node: Node { __data["node"] }
        /// The number of bytes of code written in the language.
        var size: Int { __data["size"] }

        /// Languages.Edge.Node
        ///
        /// Parent Type: `Language`
        struct Node: GitHubGraphQLAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.Language }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .fragment(LanguageFields.self),
          ] }

          /// The color defined for the current language.
          var color: String? { __data["color"] }
          /// The Node ID of the Language object
          var id: GitHubGraphQLAPI.ID { __data["id"] }
          /// The name of the current language.
          var name: String { __data["name"] }

          struct Fragments: FragmentContainer {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            var languageFields: LanguageFields { _toFragment() }
          }
        }
      }
    }

    /// Owner
    ///
    /// Parent Type: `RepositoryOwner`
    struct Owner: GitHubGraphQLAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Interfaces.RepositoryOwner }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("avatarUrl", GitHubGraphQLAPI.URI.self),
        .field("id", GitHubGraphQLAPI.ID.self),
        .field("login", String.self),
        .field("url", GitHubGraphQLAPI.URI.self),
      ] }

      /// A URL pointing to the owner's public avatar.
      var avatarUrl: GitHubGraphQLAPI.URI { __data["avatarUrl"] }
      /// The Node ID of the RepositoryOwner object
      var id: GitHubGraphQLAPI.ID { __data["id"] }
      /// The username used to login.
      var login: String { __data["login"] }
      /// The HTTP URL for the owner.
      var url: GitHubGraphQLAPI.URI { __data["url"] }
    }

    /// PrimaryLanguage
    ///
    /// Parent Type: `Language`
    struct PrimaryLanguage: GitHubGraphQLAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.Language }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(LanguageFields.self),
      ] }

      /// The color defined for the current language.
      var color: String? { __data["color"] }
      /// The Node ID of the Language object
      var id: GitHubGraphQLAPI.ID { __data["id"] }
      /// The name of the current language.
      var name: String { __data["name"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var languageFields: LanguageFields { _toFragment() }
      }
    }
  }

}