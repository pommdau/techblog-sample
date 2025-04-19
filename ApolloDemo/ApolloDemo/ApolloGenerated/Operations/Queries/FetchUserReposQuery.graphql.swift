// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GitHubGraphQLAPI {
  class FetchUserReposQuery: GraphQLQuery {
    static let operationName: String = "FetchUserRepos"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query FetchUserRepos($login: String!) { user(login: $login) { __typename repositories(first: 10) { __typename nodes { __typename ...RepositoryFields } } } }"#,
        fragments: [LanguageFields.self, RepositoryFields.self]
      ))

    public var login: String

    public init(login: String) {
      self.login = login
    }

    public var __variables: Variables? { ["login": login] }

    struct Data: GitHubGraphQLAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("user", User?.self, arguments: ["login": .variable("login")]),
      ] }

      /// Lookup a user by login.
      var user: User? { __data["user"] }

      /// User
      ///
      /// Parent Type: `User`
      struct User: GitHubGraphQLAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.User }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("repositories", Repositories.self, arguments: ["first": 10]),
        ] }

        /// A list of repositories that the user owns.
        var repositories: Repositories { __data["repositories"] }

        /// User.Repositories
        ///
        /// Parent Type: `RepositoryConnection`
        struct Repositories: GitHubGraphQLAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.RepositoryConnection }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("nodes", [Node?]?.self),
          ] }

          /// A list of nodes.
          var nodes: [Node?]? { __data["nodes"] }

          /// User.Repositories.Node
          ///
          /// Parent Type: `Repository`
          struct Node: GitHubGraphQLAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.Repository }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .fragment(RepositoryFields.self),
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

            struct Fragments: FragmentContainer {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              var repositoryFields: RepositoryFields { _toFragment() }
            }

            typealias Languages = RepositoryFields.Languages

            typealias Owner = RepositoryFields.Owner

            typealias PrimaryLanguage = RepositoryFields.PrimaryLanguage
          }
        }
      }
    }
  }

}