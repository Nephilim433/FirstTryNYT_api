//
//  BooksViewModel.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/6/23.
//

import Foundation


class BooksViewModel:NSObject {

    weak var coordinator: AppCoordinator!

    private var categoryItem: CategoryCellModel

    private(set) var books: [BookCellModel] = [] {
        didSet {
            updateUI()
        }
    }

    var updateUI: (()->()) = {}

    init(categoryItem: CategoryCellModel) {
        self.categoryItem = categoryItem
        super.init()
        getBooks()
    }

    private func getBooks() {
        //exitst with this name?
        if DatabaseHelper.shared.exists(categoryItem) {
            print("getting books from core data")
            self.books = DatabaseHelper.shared.getBooks(for:categoryItem)
        } else {
            APIService.shared.fetchCategory(category: categoryItem.listnameEncoded) { result in
                print("fetching books from Network")
                switch result {
                case .success(let books):
                    self.books = books
                    DatabaseHelper.shared.save(category: self.categoryItem, books: books)
                case .failure(let error):
                    print("error = \(error)")
                }
            }
        }
    }
}

extension BooksViewModel: BookTableViewCellDelegate {
    func wantToBuyAt(url: String) {
        coordinator.openURL(url)
    }
}
