//
//  TripsDataManagerTests.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 30/6/24.
//

import XCTest
@testable import TripManager

final class TripsDataManagerTests: XCTestCase {
    private var sut: TripsDataManagerProtocol?

    override func setUpWithError() throws {
        URLProtocol.registerClass(URLProtocolMock.self)
        guard let tripstMock = MockedData.forFile(name: "trips") else {
            XCTFail("Mock response not loaded")
            return
        }
        URLProtocolMock.mockData[TripsDataManager.Constants.tripsPath] = tripstMock
        let api = Api(client: URLSessionMock.mock)
        sut = TripsDataManager(api: api)
    }

    func test_get_trips() async {
        guard let sut = sut else {
            XCTFail("Expected non-nil sut")
            return
        }

        do {
            let result = try await sut.getTrips()
            XCTAssertEqual(result?.first?.driverName, "Alberto Morales")
        } catch {
            XCTFail("Error getTrips")
        }
    }
}
