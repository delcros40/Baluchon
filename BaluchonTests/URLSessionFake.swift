//
//  URLSessionFake.swift
//  BaluchonTests
//
//  Created by loc_delcros on 26/03/2020.
//  Copyright © 2020 DELCROS Jean-baptiste. All rights reserved.
//
import Foundation

class URLSessionFake: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        print("ok")
        let task = URLSessionDataTaskFake(data: data, urlResponse: response, error: error, completionHandler: completionHandler)
        return task
    }

    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        print("KO")
        let task = URLSessionDataTaskFake(data: data, urlResponse: response, error: error, completionHandler: completionHandler)
        return task
    }
}

class URLSessionDataTaskFake: URLSessionDataTask {
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?
    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?

    init(data: Data?, urlResponse: URLResponse?, error: Error?, completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) {
           self.completionHandler = completionHandler
           self.data = data
           self.urlResponse = urlResponse
           self.responseError = error
       }
    
    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }

    override func cancel() {}
}
