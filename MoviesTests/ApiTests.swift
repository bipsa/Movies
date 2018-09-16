//
//  ApiTests.swift
//  MoviesTests
//
//  Created by Sebastian Romero on 16/09/18.
//  Copyright © 2018 Maachi. All rights reserved.
//

import XCTest
@testable import Movies

class ApiTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    func testAsyncRequest() {
        let expectation = self.expectation(description: "The request returns a valid response.")
        TheMovieDB.api.getTopRatedMovies { (error, response) in
            if error != nil  {
                XCTFail("Error getting response from the service")
            } else {
                XCTAssertTrue(true)
                expectation.fulfill()
            }
        }
        self.waitForExpectations(timeout: 5) { error in
            if let error = error {
                XCTFail("Error getting response from the service \(error)")
            }
        }
    }
    
}
