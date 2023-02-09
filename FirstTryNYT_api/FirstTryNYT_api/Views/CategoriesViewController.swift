//
//  CategoriesViewController.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/5/23.
//

import UIKit

class CategoriesViewController: UIViewController {

    var categoriesViewModel: CategoriesViewModel?

    private var dataSource: GenericTableViewDataSource<CategoryTableViewCell,CategoryCellModel>?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.isHidden = true
        spinner.hidesWhenStopped = true
        return spinner
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        title = "The New York Times API"
        view.backgroundColor = .systemBackground
        updateDataSource()
        callToUpdateUI()
        //MARK: - uncomment this to clear core data
//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didTapDelete))

    }

    @objc private func didTapDelete() {
        DatabaseHelper.shared.clearDatabase()
    }


    private func callToUpdateUI() {
        guard let viewModel = categoriesViewModel else { return }
        viewModel.bind = {
            self.updateDataSource()
        }
    }

    func updateDataSource() {
        guard let viewModel = categoriesViewModel else { return }
        self.dataSource = GenericTableViewDataSource(cellIdentifier: CategoryTableViewCell.identifier, items: viewModel.categories, configureCell: { cell, evm in
            cell.configure(with: evm)
        })

        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource

            self.tableView.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.center = view.center
    }

}

extension CategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = categoriesViewModel else { return }
        //cordinator.openBooksWith
        viewModel.goToBookPage(index: indexPath.row)
    }
}
