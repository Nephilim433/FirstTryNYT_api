//
//  APIServiceTests.swift
//  FirstTryNYT_apiTests
//
//  Created by Nephilim  on 2/9/23.
//

import XCTest
@testable import FirstTryNYT_api

class APIServiceTests: XCTestCase {

    var sut: APIService!

    override func setUp() {
        super.setUp()
        sut = APIService()
    }

    override func tearDown(){
        sut = nil
        super.tearDown()
    }

    func testCreateURLForMangaCategoryReturnsCorrectURL() {
        let result = sut.createURL(for: "manga")
        XCTAssertEqual(result?.absoluteString, "https://api.nytimes.com/svc/books/v3/lists/current/manga.json?api-key=EfOf1ClG8jAZFSjAG2I7WmZQttTkXlTH")
    }

    func testCreateURLToListNamesReturnsCorrectURL() {
        let result = sut.createURL()
        XCTAssertEqual(result?.absoluteString, "https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=EfOf1ClG8jAZFSjAG2I7WmZQttTkXlTH")
    }

    func testValidCallToFetchListsNamesReturnStatusCode200() {
        guard let url = sut.createURL() else {
            XCTFail("Invalid URL")
            return
        }

        let promise = expectation(description: "Status code: 200")
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                XCTFail("Error: \(error!.localizedDescription)")
                return
            }
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                promise.fulfill()
            } else {
                XCTFail("Status code: \(statusCode)")
            }
        }

        dataTask.resume()

        self.waitForExpectations(timeout: 5, handler: nil)
    }

    func testValidCallToFetchBooksByNameReturnStatusCode200() {
        guard let url = sut.createURL(for: "manga") else {
            XCTFail("Invalid URL")
            return
        }

        let promise = expectation(description: "Status code: 200")
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if error != nil {
                XCTFail("Error: \(error!.localizedDescription)")
                return
            }
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                promise.fulfill()
            } else {
                XCTFail("Status code: \(statusCode)")
            }
        }

        dataTask.resume()

        self.waitForExpectations(timeout: 5, handler: nil)
    }

}
