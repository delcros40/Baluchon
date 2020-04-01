//
//  DeviseTestCase.swift
//  BaluchonTests
//
//  Created by loc_delcros on 30/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import XCTest
@testable import Baluchon

class DeviseTestCase: XCTestCase {
    
    func testGetDeviseShouldPostFailedCallback() {
        // Given
        let convertionDevise = ConvertionDevise(deviseBase: .euro,deviseSession: URLSessionFake(data: nil, response: nil, error: DeviseFakeResponseData.error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertionDevise.getTaux { (success, deviseRespoonse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(deviseRespoonse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostFailedCallbackIfNoData() {
        // Given
        let convertionDevise = ConvertionDevise(deviseBase: .euro,deviseSession: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertionDevise.getTaux { (success, deviseRespoonse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(deviseRespoonse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let convertionDevise = ConvertionDevise(deviseBase: .euro,deviseSession: URLSessionFake(data: DeviseFakeResponseData.deviseIncorrectData, response: DeviseFakeResponseData.responseKO, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertionDevise.getTaux { (success, deviseRespoonse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(deviseRespoonse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let convertionDevise = ConvertionDevise(deviseBase: .euro,deviseSession: URLSessionFake(data: DeviseFakeResponseData.deviseIncorrectData, response: DeviseFakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertionDevise.getTaux { (success, deviseRespoonse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(deviseRespoonse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetDeviseShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let convertionDevise = ConvertionDevise(deviseBase: .euro,deviseSession: URLSessionFake(data: DeviseFakeResponseData.deviseCorrectData, response: DeviseFakeResponseData.responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        convertionDevise.getTaux { (success, deviseRespoonse) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(deviseRespoonse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testEnumDeviseDesc() {
        XCTAssertEqual(Devise.euro.description, "EUR - euro")
    }
    
    func testConvertionDevise() {
        // Given
        var  convertionDevise = ConvertionDevise(deviseBase: .euro,deviseSession: URLSessionFake(data: DeviseFakeResponseData.deviseCorrectData, response: DeviseFakeResponseData.responseOK, error: nil))
        convertionDevise.montant = 10
        convertionDevise.rate = 1.08313
        convertionDevise.convertirDevise()
        XCTAssertEqual(convertionDevise.resultat, 10 * 1.08313)
    }
    
}
