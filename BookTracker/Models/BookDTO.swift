//
//  BookDTO.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 23/10/2026.
//

import Foundation

struct BooksResponse: Decodable {
    let numFound: Int
    let docs: [BookDTO]
}

struct BookDTO: Decodable {
    let key: String
    let title: String
    let coverId: Int?
    let authorNames: [String]?
    let firstPublishYear: Int?

    enum CodingKeys: String, CodingKey {
        case key, title
        case coverId = "cover_i"
        case authorNames = "author_name"
        case firstPublishYear = "first_publish_year"
    }
}

extension BookDTO {
    func makeBook() -> Book {
        let coverURL = coverId.flatMap { id in
            URL(string: "https://covers.openlibrary.org/b/id/\(id)-M.jpg?default=false")
        }
        let author = authorNames?.joined(separator: ", ") ?? "Unknown author"
        let description = firstPublishYear.map { "\(author), \($0)" } ?? author

        return Book(id: key, title: title, description: description, coverURL: coverURL)
    }
}
