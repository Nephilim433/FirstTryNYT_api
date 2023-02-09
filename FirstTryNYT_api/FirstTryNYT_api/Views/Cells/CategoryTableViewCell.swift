//
//  CategoryTableViewCell.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/6/23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    static let identifier = "CategoryTableViewCell"

    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = FontSupport.giveMeFont(type: .titleFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var publishedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = FontSupport.giveMeFont(type: .normalFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public func configure(with model: CategoryCellModel) {
        categoryLabel.text = model.categoryName
        publishedLabel.text = "published: \(model.lastUpdated)"
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    private func setup() {
        //category label
        contentView.addSubview(categoryLabel)
        let categoryLabelConstraints = [
            categoryLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            categoryLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            categoryLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(categoryLabelConstraints)
        //publishedLabel
        contentView.addSubview(publishedLabel)
        let publishedLabelConstraints = [
            publishedLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            publishedLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            publishedLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
            publishedLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(publishedLabelConstraints)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        //MARK: - nil everything
        categoryLabel.text = nil
        publishedLabel.text = nil
    }
}

