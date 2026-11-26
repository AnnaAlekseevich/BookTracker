//
//  BookDetailsView.swift
//  BookTracker
//
//  Created by Anna Alekseyevich on 08/11/2026.
//

import SwiftUI

struct BookDetailsView: View {
    @State private var model: BookDetailsViewModel
    
    init(model: BookDetailsViewModel) {
        _model = State(initialValue: model)
    }

    var body: some View {
        VStack(spacing: 0) {
            bookCover
                .frame(width: 60, height: 90)
                .background(Color(.secondarySystemFill))
                .clipShape(RoundedRectangle(cornerRadius: 6))
        }
        .navigationTitle("Book Details")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                favoriteButton
            }
        }
    }
    
    private var bookCover: some View {
        AsyncImage(url: model.book.coverURL) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
            case .empty where model.book.coverURL != nil:
                ProgressView()
            default:
                Image(systemName: "book.closed")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    private var favoriteButton: some View {
        Button {
            model.toggleWishList()
        } label: {
            Image(systemName: model.isFavorite ? "star.fill" : "star")
                .font(.title2)
                .foregroundStyle(model.isFavorite ? Color.yellow : Color.secondary)
        }
        .accessibilityLabel(
            model.isFavorite ? "Remove from favorites" : "Add to favorites"
        )
    }
}
