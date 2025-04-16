// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GitHubGraphQLAPI {
  class SearchReposQuery: GraphQLQuery {
    static let operationName: String = "SearchRepos"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query SearchRepos($query: String!, $first: Int = 10, $after: String) { search(after: $after, first: $first, query: $query, type: REPOSITORY) { __typename repositoryCount edges { __typename cursor node { __typename ... on Repository { id name } } } } }"#
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
        ] }

        /// The total number of repositories that matched the search query. Regardless of
        /// the total number of matches, a maximum of 1,000 results will be available
        /// across all types.
        var repositoryCount: Int { __data["repositoryCount"] }
        /// A list of edges.
        var edges: [Edge?]? { __data["edges"] }

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
                .field("id", GitHubGraphQLAPI.ID.self),
                .field("name", String.self),
              ] }

              /// The Node ID of the Repository object
              var id: GitHubGraphQLAPI.ID { __data["id"] }
              /// The name of the repository.
              var name: String { __data["name"] }
            }
          }
        }
      }
    }
  }

}