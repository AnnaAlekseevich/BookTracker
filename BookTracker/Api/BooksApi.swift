//
//  BooksApi.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 23/10/2026.
//

import Foundation

struct BooksApi {
    func loadBooks(offset: Int, limit: Int) async throws -> BooksResponse {
        let year = Calendar.current.component(.year, from: .now)

        var components = URLComponents(string: "https://openlibrary.org/search.json")
        components?.queryItems = [
            .init(name: "q", value: "subject:fiction language:eng first_publish_year:[\(year - 1) TO \(year)]"),
            .init(name: "sort", value: "new"),
            .init(name: "offset", value: "\(offset)"),
            .init(name: "limit", value: "\(limit)"),
            .init(name: "fields", value: "key,title,author_name,cover_i,first_publish_year"),
        ]

        guard let url = components?.url else { throw URLError(.badURL) }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(BooksResponse.self, from: data)
    }
}
