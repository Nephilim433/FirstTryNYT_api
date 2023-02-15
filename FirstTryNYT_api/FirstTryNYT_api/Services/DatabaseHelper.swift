//
//  DataBaseHelper.swift
//  FirstTryNYT_api
//
//  Created by Nephilim  on 2/6/23.
//

import Foundation
import CoreData


class DatabaseHelper {
    static let modelName = "Model"
    static let shared = DatabaseHelper()
    private init() {}

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: DatabaseHelper.modelName)
        container.loadPersistentStores { storeDescription , error in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
            print(storeDescription)
        }
        return container
    }()
    //MARK: - CoreData Saving Support

    private func save() {
        let contex = persistentContainer.viewContext
        if contex.hasChanges {
            contex.performAndWait {
                do {
                    try contex.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.localizedDescription)")
                }
            }
        }
    }

    //using
    public func save(category: CategoryCellModel, books: [BookCellModel]) {
        let categoryToSave = Category(context: persistentContainer.viewContext)
        categoryToSave.name = category.categoryName
        categoryToSave.listNameEncoded = category.listnameEncoded
        categoryToSave.newestPublishedDate = category.lastUpdated

        persistentContainer.viewContext.perform {

        books.forEach({ bookItem in
            let book = Book(context: self.persistentContainer.viewContext)

            book.bookName = bookItem.booksName
            book.rank = Int16(bookItem.rank)
            book.author = bookItem.author
            book.publisher = bookItem.publisher
            book.booksDescription = bookItem.booksDescription
            book.image = bookItem.image
            bookItem.buyLink.forEach { buyLink in
                let link = Link(context: self.persistentContainer.viewContext)
                link.link = buyLink.url
                link.name = buyLink.name.rawValue
                link.book = book
                categoryToSave.addToBooks(book)
            }
        })
        }
        save()

    }

    //return true/fasle if category alredy exists
    public func exists(_ item:CategoryCellModel) -> (Bool) {
        let fetchedRequest: NSFetchRequest<Category> = Category.fetchRequest()
        fetchedRequest.fetchLimit = 1
        fetchedRequest.predicate = NSPredicate(format: "name == %@", item.categoryName)
        do {
            var result = [Category]()
            result = try persistentContainer.viewContext.fetch(fetchedRequest)
            print("result.isEmpty = \(result.isEmpty)")
            guard result.isEmpty == false else { return false  }
            let category = result.first!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            let cdCategoryDate = dateFormatter.date(from: category.newestPublishedDate!)!
            let newCategoryDate = dateFormatter.date(from: item.lastUpdated)!

            if newCategoryDate > cdCategoryDate {
                print("core data is outdated")
                delete(model: item)
                return false
            } else if newCategoryDate == cdCategoryDate {
                return true
            }

        } catch let error as NSError {
            print("could not fetch, \(error) , \(error.localizedDescription)")
            return false
        }
        return false
    }

    //using
    public func getBooks(for item:CategoryCellModel) -> [BookCellModel] {
        var models = [BookCellModel]()

        if let category = getCategory(with: item.categoryName) {
            let books = category.books?.allObjects as! [Book]
            books.forEach { book in
                let tempLinks = book.link?.allObjects as! [Link]
                let links: [BuyLink] = tempLinks.compactMap { BuyLink(name: Store(rawValue: $0.name!) ?? Store.appleBooks, url: $0.link!)}
                models.append(BookCellModel(booksName: book.bookName!, booksDescription: book.booksDescription!, author: book.author!, publisher: book.publisher!, rank: Int(book.rank), buyLink: links, image: book.image!))
            }
        }
        models = models.sorted(by: { $0.rank < $1.rank })
        return models
    }

    public func getCategories() -> [CategoryCellModel] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        var categories: [CategoryCellModel] = []
        do {
            let sort = NSSortDescriptor(key: #keyPath(Category.newestPublishedDate), ascending: false)
            request.sortDescriptors = [sort]
            let fetchedCategories = try persistentContainer.viewContext.fetch(request)
            categories = fetchedCategories.compactMap { CategoryCellModel(categoryName: $0.name!, lastUpdated: $0.newestPublishedDate!, listnameEncoded: $0.listNameEncoded!) }
        } catch let error {
            print("Error fetching singers \(error)")
        }
        return categories
    }

    private func getCategory(with name: String) -> Category? {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.fetchLimit = 1
        do {
            let predicate = NSPredicate(format: "name = %@" , name)
            request.predicate = predicate
            guard let fetchedCategory = try persistentContainer.viewContext.fetch(request).first else { return nil }
            return fetchedCategory
        } catch let error {
            print("Error fetching category \(error)")
        }
        return nil
    }


    private func delete(model: CategoryCellModel) {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.fetchLimit = 1
        do {
            let predicate = NSPredicate(format: "name = %@" , model.categoryName)
            request.predicate = predicate
            guard let fetchedCategory = try persistentContainer.viewContext.fetch(request).first else { return }
            persistentContainer.viewContext.delete(fetchedCategory)
            save()
        } catch let error {
            print("Error fetching category\(error)")
        }

    }


    public func clearDatabase() {
        guard let url = persistentContainer.persistentStoreDescriptions.first?.url else { return }
        let persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        do {
            try persistentStoreCoordinator.destroyPersistentStore(at:url, ofType: NSSQLiteStoreType, options: nil)
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            print("Attempted to clear persistent store: " + error.localizedDescription)
        }
    }
}
