//
//  UserStoreKeyTest.swift
//  StocksTests
//
//  Created by Naresh on 09/09/24.
//

import XCTest
@testable import Stocks

final class UserStoreKeyTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
}

extension UserStoreKeyTest {
    func testUserStoreKeys() {
        XCTAssertEqual(UserStoreKey.accessToken.key, "accessTokenKey")
        XCTAssertEqual(UserStoreKey.refreshToken.key, "refreshTokenKey")
    }
}
