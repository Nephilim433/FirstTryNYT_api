//
//  CategoryCellViewModel.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/5/23.
//

import Foundation


class CategoriesViewModel: NSObject {

    weak var coordinator: AppCoordinator!

    private(set) var categories: [CategoryCellModel] = [] {
        didSet {
            print("binding")
            self.bind()
        }
    }

    var bind: (()->()) = {}

    override init() {
        super.init()
        getCategories()
    }

    func goToBookPage(index: Int) {
        guard coordinator != nil else { return }
        let item = categories[index]
        coordinator.goToBooksPage(with: item)
    }

    func getCategories() {
        if NetworkMonitor.shared.isReachable {
            print("get data from web")
            APIService.shared.fetchCategoryItems { result in
                switch result {
                case .success(let model):
                    let newmodel = model.results.compactMap { CategoryCellModel(categoryName: $0.displayName, lastUpdated: $0.newestPublishedDate ?? "whops", listnameEncoded: $0.listNameEncoded)
                    }
                    self.categories = newmodel
                case .failure(let error):
                    print("error = \(error)")
                }
            }
        } else {
            print("get data from core data")
            self.categories = DatabaseHelper.shared.getCategories()
        }
        NetworkMonitor.shared.stopMonitoring()
    }
}
