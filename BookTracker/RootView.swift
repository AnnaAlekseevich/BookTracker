//
//  RootView.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 05/10/2026.
//

import SwiftUI

struct RootView: View {
    @State
    private var storage = BooksWishListStorage()

    var body: some View {
        BooksView(storage: storage)
    }
}

#Preview {
    RootView()
}
