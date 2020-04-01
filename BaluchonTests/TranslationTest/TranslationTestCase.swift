//
//  TranslationTestCase.swift
//  BaluchonTests
//
//  Created by loc_delcros on 26/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import XCTest
import Foundation
@testable import Baluchon

class TranslationTestCase: XCTestCase {
    
    func testGetTranslationShouldPostFailedCallback() {
        // Given
        let translation = Translation(text: "Bonjour", translationSession: URLSessionFake(data: nil, response: nil, error: TranslationFakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translation.getTranslation { (success, translate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        // Given
        let translation = Translation(text: "Bonjour", translationSession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translation.getTranslation { (success, translate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translation = Translation(text: "Bonjour", translationSession: URLSessionFake(data: TranslationFakeResponseData.translationIncorrectData, response: TranslationFakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translation.getTranslation { (success, translate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translation = Translation(text: "Bonjour", translationSession: URLSessionFake(data: TranslationFakeResponseData.translationIncorrectData, response: TranslationFakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translation.getTranslation { (success, translate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translation = Translation(text: "Bonjour", translationSession: URLSessionFake(data: TranslationFakeResponseData.translationCorrectData, response: TranslationFakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translation.getTranslation { (success, translate) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(translate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
