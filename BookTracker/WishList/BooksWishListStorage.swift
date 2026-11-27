//
//  BooksWishListStorage.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 20/11/2026.
//

import Observation

@Observable
class BooksWishListStorage {
    private(set) var books: [Book]
    
    init(books: [Book] = []) {
        self.books = books
    }
    
    func toggle(book: Book) {
        if contains(book: book) {
            removeBook(book: book)
        } else {
            addBook(book: book)
        }
    }
}

extension BooksWishListStorage {
    func addBook(book: Book) {
        guard !contains(book: book) else { return }
        books.append(book)
    }
    
    func removeBook(book: Book) {
        books.removeAll { $0.id == book.id }
    }
    
    func contains(book: Book) -> Bool {
        books.contains { $0.id == book.id }
    }
}
