//
//  WeatherTestCase.swift
//  BaluchonTests
//
//  Created by loc_delcros on 26/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//

import XCTest
@testable import Baluchon

class WeatherTestCase: XCTestCase {

    func testGetWeatherShouldPostFailedCallback() {
        // Given
        let weather = WeatherForecast(weatherSession: URLSessionFake(data: nil, response: nil, error: WeatherFakeResponseData.error))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather(currentCityId: CityId.MONTDEMARSAN.rawValue) { (success, weatherResponse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weather = WeatherForecast(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather(currentCityId: CityId.MONTDEMARSAN.rawValue) { (success, weatherResponse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weather = WeatherForecast(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherIncorrectData, response: WeatherFakeResponseData.responseKO, error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather(currentCityId: CityId.MONTDEMARSAN.rawValue) { (success, weatherResponse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weather = WeatherForecast(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherIncorrectData, response: WeatherFakeResponseData.responseOK, error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather(currentCityId: CityId.MONTDEMARSAN.rawValue) { (success, weatherResponse) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weather = WeatherForecast(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherCorrectData, response: WeatherFakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weather.getWeather(currentCityId: CityId.MONTDEMARSAN.rawValue) { (success, weatherResponse) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherResponse)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
