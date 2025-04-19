// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

extension GitHubGraphQLAPI {
  struct UserFields: GitHubGraphQLAPI.SelectionSet, Fragment {
    static var fragmentDefinition: StaticString {
      #"fragment UserFields on User { __typename avatarUrl bio id isFollowingViewer location login name repositories(first: 0) { __typename totalCount } starredRepositories(first: 0) { __typename totalCount } twitterUsername updatedAt viewerCanFollow viewerIsFollowing }"#
    }

    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.User }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .field("avatarUrl", GitHubGraphQLAPI.URI.self),
      .field("bio", String?.self),
      .field("id", GitHubGraphQLAPI.ID.self),
      .field("isFollowingViewer", Bool.self),
      .field("location", String?.self),
      .field("login", String.self),
      .field("name", String?.self),
      .field("repositories", Repositories.self, arguments: ["first": 0]),
      .field("starredRepositories", StarredRepositories.self, arguments: ["first": 0]),
      .field("twitterUsername", String?.self),
      .field("updatedAt", GitHubGraphQLAPI.DateTime.self),
      .field("viewerCanFollow", Bool.self),
      .field("viewerIsFollowing", Bool.self),
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

    /// Repositories
    ///
    /// Parent Type: `RepositoryConnection`
    struct Repositories: GitHubGraphQLAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.RepositoryConnection }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("totalCount", Int.self),
      ] }

      /// Identifies the total count of items in the connection.
      var totalCount: Int { __data["totalCount"] }
    }

    /// StarredRepositories
    ///
    /// Parent Type: `StarredRepositoryConnection`
    struct StarredRepositories: GitHubGraphQLAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: any ApolloAPI.ParentType { GitHubGraphQLAPI.Objects.StarredRepositoryConnection }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("totalCount", Int.self),
      ] }

      /// Identifies the total count of items in the connection.
      var totalCount: Int { __data["totalCount"] }
    }
  }

}