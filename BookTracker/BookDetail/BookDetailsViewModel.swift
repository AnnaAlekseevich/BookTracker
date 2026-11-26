//
//  BookDetailViewModel.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 08/11/2026.
//

import SwiftUI
import Observation

@Observable
class BookDetailsViewModel {
    private let storage: BooksWishListStorage
    var books: [Book] { storage.books }
    var book: Book
    
    var isFavorite: Bool {
        storage.books.contains { $0.id == book.id }
    }
    
    init(book: Book = Book(id: "", title: "", description: "", coverURL: nil), storage: BooksWishListStorage) {
        self.book = book
        self.storage = storage
    }
    
    func toggleWishList() {
        storage.toggle(book: book)
    }
}
