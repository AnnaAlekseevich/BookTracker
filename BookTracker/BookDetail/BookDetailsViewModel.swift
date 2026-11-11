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
    var book: Book
    
    init(book: Book = Book(id: "", title: "", description: "", coverURL: nil)) {
        self.book = book
    }
}
