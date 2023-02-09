//
//  Coordinator.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/6/23.
//

import SafariServices
import UIKit


protocol Coordinator {
//    var parentCoordinator: Coordinator? {get set}
//    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}

    func start()
}

class AppCoordinator: Coordinator {
//    var parentCoordinator: Coordinator?
//    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(navCon: UINavigationController) {
        self.navigationController = navCon
    }



    func start() {
        print("App Coordinator Start")
        goToCategoriesPage()
    }

    func goToCategoriesPage() {
        //init vc
        let categoriesVC = CategoriesViewController.init()
        //init view model
        let categoriesVM = CategoriesViewModel.init()
        //set the coordinator to VM
        categoriesVM.coordinator = self
        //set vm to vc
        categoriesVC.categoriesViewModel = categoriesVM
        //push
        navigationController.pushViewController(categoriesVC, animated: true)
    }

    func goToBooksPage(with category: CategoryCellModel) {
        let booksVC = BooksViewController()
        //init view model
        let booksVM = BooksViewModel(categoryItem: category)
        //set the coordinator to VM
        booksVM.coordinator = self
        //set vm to vc
        booksVC.booksViewModel = booksVM
        //push
        navigationController.pushViewController(booksVC, animated: true)

    }

    func openURL(_ url:String) {
        guard let url = URL(string: url) else { return }
        let vc = SFSafariViewController(url: url)
        vc.modalPresentationStyle = .overCurrentContext
        navigationController.present(vc, animated: true, completion: nil)
    }

}
