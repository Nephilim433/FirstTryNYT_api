//
//  CategoryViewModelTests.swift
//  FirstTryNYT_apiTests
//
//  Created by Nephilim  on 2/9/23.
//

import XCTest
@testable import FirstTryNYT_api

class CategoryViewModelTests: XCTestCase {

    private var sut : CategoriesViewModel!

    override func setUp() {
        super.setUp()
        sut = CategoriesViewModel()
    }

    override func tearDown(){
        sut = nil
        super.tearDown()
    }

    func testCategoriesStartEmpty() {
        let result = sut.categories.count
        XCTAssertEqual(result, 0)
    }

}
