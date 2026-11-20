//
//  Book.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 06/10/2026.
//

import Foundation

struct Book: Identifiable, Hashable {
    let id: String
    let title: String
    let description: String
    let coverURL: URL?
}

#if DEBUG
extension Book {
    static let samples: [Book] = [
        Book(
            id: "project-hail-mary",
            title: "Project Hail Mary",
            description: "A lone astronaut wakes up on a spaceship with no memory and has to save Earth from an extinction-level threat.",
            coverURL: URL(string: "https://covers.openlibrary.org/b/id/11200092-M.jpg")
        ),
        Book(
            id: "atomic-habits",
            title: "Atomic Habits",
            description: "A practical guide to building good habits and breaking bad ones through tiny everyday changes.",
            coverURL: URL(string: "https://covers.openlibrary.org/b/id/12539702-M.jpg")
        ),
        Book(
            id: "the-midnight-library",
            title: "The Midnight Library",
            description: "Between life and death there is a library, and every book in it lets you try another version of your life.",
            coverURL: URL(string: "https://covers.openlibrary.org/b/id/10313767-M.jpg")
        ),
        Book(
            id: "no-cover",
            title: "A Book Without a Cover and With a Very Long Title That Wraps",
            description: "Shows how the row looks when the image fails to load and the text is longer than the available space.",
            coverURL: nil
        ),
    ]
}
#endif
