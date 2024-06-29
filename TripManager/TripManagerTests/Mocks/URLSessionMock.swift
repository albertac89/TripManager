//
//  URLSessionMock.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

import Foundation

final class URLSessionMock {
    static var mock: URLSession {
        let configurationWithMock = URLSessionConfiguration.default
        configurationWithMock.protocolClasses = [URLProtocolMock.self]
        return URLSession(configuration: configurationWithMock)
    }
}
