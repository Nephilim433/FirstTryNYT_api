//
//  BookTableViewCell.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/6/23.
//

import UIKit

protocol BookTableViewCellDelegate: AnyObject {
    func wantToBuyAt(url:String)
}

class BookTableViewCell: UITableViewCell {

    static let identifier = "BookTableViewCell"

    weak var delegate: BookTableViewCellDelegate?

    lazy var booksName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = FontSupport.giveMeFont(type: .titleFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var booksDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = FontSupport.giveMeFont(type: .smallFont)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var author: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .label
        label.font = FontSupport.giveMeFont(type: .normalFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var publisher: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textColor = .label
        label.font = FontSupport.giveMeFont(type: .smallFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var rank: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .label
        label.font = FontSupport.giveMeFont(type: .smallFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var bookImage: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "text.book.closed")
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    lazy var buyButton : UIButton = {
        let button = UIButton()
        button.setTitle("BUY", for: .normal)
        button.titleLabel?.font = FontSupport.giveMeFont(type: .normalFont)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 3
        button.clipsToBounds = true

        button.showsMenuAsPrimaryAction = true

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()




    public func configure(with model: BookCellModel) {
        booksName.text = model.booksName
        rank.text = "Rank: \(model.rank)"
        author.text = "by \(model.author)"
        publisher.text = "Published by \(model.publisher)"
        booksDescription.text = model.booksDescription
        bookImage.image = UIImage(data: model.image)
        buyButton.menu = createMenu(items: model.buyLink)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setup()
    }

    private func setup() {
        contentView.addSubview(bookImage)
        let bookImageConstraints = [
            bookImage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            bookImage.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            bookImage.widthAnchor.constraint(equalToConstant: 130),
            bookImage.heightAnchor.constraint(equalToConstant: 195),
        ]
        NSLayoutConstraint.activate(bookImageConstraints)
        //bookname
        contentView.addSubview(booksName)
        let bookNameConstraints = [
            booksName.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            booksName.leftAnchor.constraint(equalTo: bookImage.rightAnchor, constant: 10),
            booksName.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(bookNameConstraints)
        //author
        contentView.addSubview(author)
        let authorConstraints = [
            author.topAnchor.constraint(equalTo: booksName.bottomAnchor, constant: 5),
            author.leftAnchor.constraint(equalTo: booksName.leftAnchor),
            author.rightAnchor.constraint(equalTo: booksName.rightAnchor)
        ]
        NSLayoutConstraint.activate(authorConstraints)
        //rank
        contentView.addSubview(rank)
        let rankConstraints = [
            rank.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 5),
            rank.leftAnchor.constraint(equalTo: booksName.leftAnchor),
            rank.rightAnchor.constraint(equalTo: booksName.rightAnchor)
        ]
        NSLayoutConstraint.activate(rankConstraints)

        //publisher
        contentView.addSubview(publisher)
        let publisherConstraints = [
            publisher.topAnchor.constraint(equalTo: rank.bottomAnchor, constant: 5),
            publisher.leftAnchor.constraint(equalTo: booksName.leftAnchor),
            publisher.rightAnchor.constraint(equalTo: booksName.rightAnchor)
        ]
        NSLayoutConstraint.activate(publisherConstraints)
        //buybutton
        contentView.addSubview(buyButton)
        let buyButtonConstraints = [
            buyButton.leftAnchor.constraint(equalTo: bookImage.rightAnchor, constant: 10),
            buyButton.bottomAnchor.constraint(equalTo: bookImage.bottomAnchor),
            buyButton.widthAnchor.constraint(equalToConstant: 60),
            buyButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        NSLayoutConstraint.activate(buyButtonConstraints)
        //description
        contentView.addSubview(booksDescription)
        let descriptionConstraints = [
            booksDescription.topAnchor.constraint(equalTo: bookImage.bottomAnchor, constant: 10),
            booksDescription.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            booksDescription.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            booksDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(descriptionConstraints)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        // nil everything
        booksName.text = nil
        rank.text = nil
        author.text = nil
        publisher.text = nil
        booksDescription.text = nil
        bookImage.image = nil

    }

    private func createMenu(items: [BuyLink]) -> UIMenu {
        var menuActions: [UIAction] = []
        items.forEach{ link in
            let item = UIAction(title: link.name.rawValue, image: UIImage(systemName: "bag")) { action in
                self.delegate?.wantToBuyAt(url: link.url)
            }
            menuActions.append(item)
        }
        return UIMenu(title: "Where do you want to buy?",
                      children: menuActions)
    }
}


