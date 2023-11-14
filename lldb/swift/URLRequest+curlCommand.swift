extension URLRequest {
    var curlCommand: String? {
        guard let method = httpMethod,
              let url = url?.absoluteString else {
            return nil
        }

        var components = ["curl", "-X", method]
        let headers = allHTTPHeaderFields?
            .map { key, value in
                "-H '\(key): \(value)'"
            }
            .joined(separator: " ")
        let body = httpBody
            .flatMap { String(data: $0, encoding: .utf8) }
            .map { "-d '\($0)'" }
        let components = [
            "curl",
            "-X \(method)",
            "'\(url)'",
            headers,
            body
        ]

        return components.compactMap { $0 }.joined(separator: " ")
    }
}
