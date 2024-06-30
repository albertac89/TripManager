//
//  StopsDataManagerTests.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 30/6/24.
//

import XCTest
@testable import TripManager

final class StopsDataManagerTests: XCTestCase {
    private var sut: StopsDataManagerProtocol?

    override func setUpWithError() throws {
        URLProtocol.registerClass(URLProtocolMock.self)
        guard let tripstMock = MockedData.forFile(name: "stops") else {
            XCTFail("Mock response not loaded")
            return
        }
        URLProtocolMock.mockData[StopsDataManager.Constants.stopsPath] = tripstMock
        let api = Api(client: URLSessionMock.mock)
        sut = StopsDataManager(api: api)
    }

    func test_get_stops() async {
        guard let sut = sut else {
            XCTFail("Expected non-nil sut")
            return
        }

        do {
            let result = try await sut.getStops()
            XCTAssertEqual(result?.address, "Ramblas, Barcelona")
        } catch {
            XCTFail("Error getStops")
        }
    }
}
