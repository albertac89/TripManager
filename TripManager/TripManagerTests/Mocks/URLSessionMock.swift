//
//  URLSessionMock.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

import Foundation

final class URLSessionMock {
    /**
     static var mock: URLSession
     Creates a mock URLSession with a URLProtocolMock to run the service tests
     - Returns: A mock URLSession to run the service tests
     */
    static var mock: URLSession {
        let configurationWithMock = URLSessionConfiguration.default
        configurationWithMock.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: configurationWithMock)
    }
}
