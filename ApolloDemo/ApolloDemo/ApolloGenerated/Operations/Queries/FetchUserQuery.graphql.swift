// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GitHubGraphQLAPI {
  class FetchUserQuery: GraphQLQuery {
    static let operationName: String = "FetchUser"
    static let operationDocument: ApolloAPI.OperationDocument = .init(
      definition: .init(
        #"query FetchUser($login: String!) { user(login: $login) { __typename ...UserFields } }"#,
        fragments: [UserFields.self]
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
          .fragment(UserFields.self),
        ] }

        /// A URL pointing to the user's public avatar.
        var avatarUrl: GitHubGraphQLAPI.URI { __data["avatarUrl"] }
        /// The user's public profile bio.
        var bio: String? { __data["bio"] }
        /// The Node ID of the User object
        var id: GitHubGraphQLAPI.ID { __data["id"] }
        /// Whether or not this user is following the viewer. Inverse of viewerIsFollowing
        var isFollowingViewer: Bool { __data["isFollowingViewer"] }
        /// The user's public profile location.
        var location: String? { __data["location"] }
        /// The username used to login.
        var login: String { __data["login"] }
        /// The user's public profile name.
        var name: String? { __data["name"] }
        /// A list of repositories that the user owns.
        var repositories: Repositories { __data["repositories"] }
        /// Repositories the user has starred.
        var starredRepositories: StarredRepositories { __data["starredRepositories"] }
        /// The user's Twitter username.
        var twitterUsername: String? { __data["twitterUsername"] }
        /// Identifies the date and time when the object was last updated.
        var updatedAt: GitHubGraphQLAPI.DateTime { __data["updatedAt"] }
        /// Whether or not the viewer is able to follow the user.
        var viewerCanFollow: Bool { __data["viewerCanFollow"] }
        /// Whether or not this user is followed by the viewer. Inverse of isFollowingViewer.
        var viewerIsFollowing: Bool { __data["viewerIsFollowing"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var userFields: UserFields { _toFragment() }
        }

        typealias Repositories = UserFields.Repositories

        typealias StarredRepositories = UserFields.StarredRepositories
      }
    }
  }

}