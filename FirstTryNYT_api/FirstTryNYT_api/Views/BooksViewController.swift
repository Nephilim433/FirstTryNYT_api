//
//  BooksViewController.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/5/23.
//

import UIKit


class BooksViewController: UIViewController {

    var booksViewModel: BooksViewModel?

    private var dataSource: GenericTableViewDataSource<BookTableViewCell,BookCellModel>?

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        title = ("BooksViewController.title")~
        callToUpdateUI()
        updateDataSource()
    }

    private func callToUpdateUI() {
        guard let viewModel = booksViewModel else { return }
        viewModel.updateUI = {
            self.updateDataSource()
            }
    }

    private func updateDataSource() {
        guard let viewModel = booksViewModel else { return }
        self.dataSource = GenericTableViewDataSource(cellIdentifier: BookTableViewCell.identifier, items: viewModel.books, configureCell: { cell, model in
            cell.configure(with: model)
            cell.delegate = viewModel
        })

        DispatchQueue.main.async {
            self.tableView.dataSource = self.dataSource
            self.tableView.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

