//
//  BookDetailsViewModel.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 08/11/2026.
//

import SwiftUI
import Observation

@Observable
class BookDetailsViewModel {
    private let storage: BooksWishListStorage
    let book: Book
    
    var isInWishList: Bool {
        storage.contains(book: book)
    }
    
    init(book: Book, storage: BooksWishListStorage) {
        self.book = book
        self.storage = storage
    }
    
    func toggleWishList() {
        storage.toggle(book: book)
    }
}
