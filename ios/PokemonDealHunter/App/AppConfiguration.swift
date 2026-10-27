import Foundation

enum AppConfiguration {
    /// Keep this true until a live backend is running. Sample prices are fictional.
    static let usesSampleData = true
    static let apiBaseURL = URL(string: "http://127.0.0.1:8000/api/v1")!
}
