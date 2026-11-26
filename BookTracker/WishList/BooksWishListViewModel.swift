//
//  BooksWishListViewModel.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 22/10/2026.
//

import Foundation
import Observation

enum BooksWishListState {
    case empty
    case filled
}

@Observable
final class BooksWishListViewModel {
    let storage: BooksWishListStorage
    var books: [Book] { storage.books }
    var selectedBook: Book?
    
    init(storage: BooksWishListStorage) {
        self.storage = storage
    }

    var state: BooksWishListState {
        if books.isEmpty { .empty } else { .filled }
    }

    func deleteBook(index: IndexSet) {
//        if let firstIndex = index.first {  }
        guard let firstIndex = index.first else { return }
        storage.removeBook(book: books[firstIndex])
    }
    
    func toggleWishList(_ book: Book) {
        storage.toggle(book: book)
    }
    
    func openBookDetails(_ book: Book) {
        selectedBook = book
    }
}
