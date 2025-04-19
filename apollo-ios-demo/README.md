# Post
- [apollo-iosでGitHub GrqphQL APIを利用する](https://zenn.dev/ikeh1024/articles/fcada4d0df1d20#github-graphql-api%E3%81%AEschema%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%81%AE%E8%BF%BD%E5%8A%A0)

# Setup

- 手元でアプリの動きを見る場合は、自身で作成したOAuth Appの認証情報を含んだ`GitHubAPICredentials.swift`を作成してください

```swift
import Foundation

enum GitHubAPICredentials {
    static let clientID = "your-client-id"
    static let clientSecret = "yout-client-secret"
}
```
