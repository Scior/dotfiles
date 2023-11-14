extension URLRequest {
    var curlCommand: String? {
        guard let method = httpMethod,
              let url = url?.absoluteString else {
            return nil
        }

        var components = ["curl", "-X", method, "'\(url)'"]
        for header in allHTTPHeaderFields ?? [:] {
            components.append("-H")
            components.append("'\(header.key): \(header.value)'")
        }
        if let httpBody, let body = String(data: httpBody, encoding: .utf8) {
            components.append("-d")
            components.append("'\(body)'")
        }

        return components.joined(separator: " ")
    }
}
