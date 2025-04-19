// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GitHubGraphQLAPI {
  class SearchReposQuery: GraphQLQuery {
    static let operationName: String = "SearchRepos"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query SearchRepos($query: String!, $first: Int = 10, $after: String) { search(after: $after, first: $first, query: $query, type: REPOSITORY) { __typename repositoryCount edges { __typename cursor node { __typename ... on Repository { ...RepositoryFields } } } pageInfo { __typename endCursor hasNextPage } } }"#,
        fragments: [LanguageFields.self, RepositoryFields.self]
      ))

    public var query: String
    public var first: GraphQLNullable<Int>
    public var after: GraphQLNullable<String>

    public init(
      query: String,
      first: GraphQLNullable<Int> = 10,
      after: GraphQLNullable<String>
    ) {
      self.query = query
      self.first = first
      self.after = after
    }

    public var __variables: Variables? { [
      "query": query,
      "first": first,
      "after": after
    ] }

    struct Data: GitHubGraphQLAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.Query }
      static var __selections: [ApolloAPI.Selection] { [
        .field("search", Search.self, arguments: [
          "after": .variable("after"),
          "first": .variable("first"),
          "query": .variable("query"),
          "type": "REPOSITORY"
        ]),
      ] }

      /// Perform a search across resources, returning a maximum of 1,000 results.
      var search: Search { __data["search"] }

      /// Search
      ///
      /// Parent Type: `SearchResultItemConnection`
      struct Search: GitHubGraphQLAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.SearchResultItemConnection }
        static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("repositoryCount", Int.self),
          .field("edges", [Edge?]?.self),
          .field("pageInfo", PageInfo.self),
        ] }

        /// The total number of repositories that matched the search query. Regardless of
        /// the total number of matches, a maximum of 1,000 results will be available
        /// across all types.
        var repositoryCount: Int { __data["repositoryCount"] }
        /// A list of edges.
        var edges: [Edge?]? { __data["edges"] }
        /// Information to aid in pagination.
        var pageInfo: PageInfo { __data["pageInfo"] }

        /// Search.Edge
        ///
        /// Parent Type: `SearchResultItemEdge`
        struct Edge: GitHubGraphQLAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.SearchResultItemEdge }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("cursor", String.self),
            .field("node", Node?.self),
          ] }

          /// A cursor for use in pagination.
          var cursor: String { __data["cursor"] }
          /// The item at the end of the edge.
          var node: Node? { __data["node"] }

          /// Search.Edge.Node
          ///
          /// Parent Type: `SearchResultItem`
          struct Node: GitHubGraphQLAPI.SelectionSet {
            let __data: DataDict
            init(_dataDict: DataDict) { __data = _dataDict }

            static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Unions.SearchResultItem }
            static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .inlineFragment(AsRepository.self),
            ] }

            var asRepository: AsRepository? { _asInlineFragment() }

            /// Search.Edge.Node.AsRepository
            ///
            /// Parent Type: `Repository`
            struct AsRepository: GitHubGraphQLAPI.InlineFragment {
              let __data: DataDict
              init(_dataDict: DataDict) { __data = _dataDict }

              typealias RootEntityType = SearchReposQuery.Data.Search.Edge.Node
              static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.Repository }
              static var __selections: [ApolloAPI.Selection] { [
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

        /// Search.PageInfo
        ///
        /// Parent Type: `PageInfo`
        struct PageInfo: GitHubGraphQLAPI.SelectionSet {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.PageInfo }
          static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("endCursor", String?.self),
            .field("hasNextPage", Bool.self),
          ] }

          /// When paginating forwards, the cursor to continue.
          var endCursor: String? { __data["endCursor"] }
          /// When paginating forwards, are there more items?
          var hasNextPage: Bool { __data["hasNextPage"] }
        }
      }
    }
  }

}