//
//  MapListViewModelTests.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

import XCTest
@testable import TripManager
import MapKit

@MainActor
final class MapListViewModelTests: XCTestCase {
    private let tripsService = TripsDataManagerMock()
    private let stopsService = StopsDataManagerMock()
    private var sut: MapListViewModel?

    override func setUpWithError() throws {
        sut = MapListViewModel(tripsDataManager: tripsService, stopsDataManager: stopsService)
    }

    func test_getTrips() async {
        guard let sut = sut else {
            XCTFail("Expected non-nil sut")
            return
        }

        // Initial values
        XCTAssertFalse(sut.showError)
        XCTAssertNil(sut.errorDescription)
        XCTAssertEqual(sut.trips.count, 0)
        XCTAssertNil(sut.stop)
        XCTAssertEqual(tripsService.getTripsSpy, 0)
        XCTAssertEqual(stopsService.getStopsSpy, 0)

        // Load trips
        await sut.loadTrips()

        // Check
        XCTAssertFalse(sut.showError)
        XCTAssertNil(sut.errorDescription)
        XCTAssertEqual(sut.trips.count, 3)
        XCTAssertNil(sut.stop)
        XCTAssertEqual(tripsService.getTripsSpy, 1)
        XCTAssertEqual(stopsService.getStopsSpy, 0)
    }

    func test_getTrips_error() async {
        guard let sut = sut else {
            XCTFail("Expected non-nil sut")
            return
        }

        // Set error
        tripsService.getTripsShouldShowError = true

        // Initial values
        XCTAssertFalse(sut.showError)
        XCTAssertNil(sut.errorDescription)
        XCTAssertEqual(sut.trips.count, 0)
        XCTAssertNil(sut.stop)
        XCTAssertEqual(tripsService.getTripsSpy, 0)
        XCTAssertEqual(stopsService.getStopsSpy, 0)

        // Load trips
        await sut.loadTrips()

        // Check
        XCTAssertTrue(sut.showError)
        XCTAssertEqual(sut.errorDescription ?? "", "forcedTestError\n\nPull to refresh")
        XCTAssertEqual(sut.trips.count, 0)
        XCTAssertNil(sut.stop)
        XCTAssertEqual(tripsService.getTripsSpy, 1)
        XCTAssertEqual(stopsService.getStopsSpy, 0)
    }

    func test_getStops() async {
        guard let sut = sut else {
            XCTFail("Expected non-nil sut")
            return
        }

        // Initial values
        XCTAssertFalse(sut.showError)
        XCTAssertNil(sut.errorDescription)
        XCTAssertEqual(sut.trips.count, 0)
        XCTAssertNil(sut.stop)
        XCTAssertEqual(tripsService.getTripsSpy, 0)
        XCTAssertEqual(stopsService.getStopsSpy, 0)

        // Load trips
        await sut.loadStops()

        // Check
        XCTAssertFalse(sut.showError)
        XCTAssertNil(sut.errorDescription)
        XCTAssertEqual(sut.trips.count, 0)
        XCTAssertEqual(sut.stop?.address, "testAddress")
        XCTAssertEqual(tripsService.getTripsSpy, 0)
        XCTAssertEqual(stopsService.getStopsSpy, 1)
    }

    func test_getStops_error() async {
        guard let sut = sut else {
            XCTFail("Expected non-nil sut")
            return
        }

        // Set error
        stopsService.getStopsShouldShowError = true

        // Initial values
        XCTAssertFalse(sut.showError)
        XCTAssertNil(sut.errorDescription)
        XCTAssertEqual(sut.trips.count, 0)
        XCTAssertNil(sut.stop)
        XCTAssertEqual(tripsService.getTripsSpy, 0)
        XCTAssertEqual(stopsService.getStopsSpy, 0)

        // Load trips
        await sut.loadStops()

        // Check
        XCTAssertTrue(sut.showError)
        XCTAssertEqual(sut.errorDescription ?? "", "forcedTestError")
        XCTAssertEqual(sut.trips.count, 0)
        XCTAssertNil(sut.stop)
        XCTAssertEqual(tripsService.getTripsSpy, 0)
        XCTAssertEqual(stopsService.getStopsSpy, 1)
    }

    func test_cameraPosition() {
        guard let sut = sut else {
            XCTFail("Expected non-nil sut")
            return
        }

        var coordinate = CLLocationCoordinate2D(latitude: 132132.0, longitude: 123132.0)
        var mkPolyline = MKPolyline(coordinates: &coordinate, count: 1)

        let result = sut.cameraPosition(for: mkPolyline)

        let expectedOrigin = MKMapPoint(CLLocationCoordinate2D(latitude: 132132.0, longitude: 123132.0))
        let expectedSize = MKMapSize(width: 0, height: 0)
        let expected = MKMapRect(origin: expectedOrigin, size: expectedSize)

        XCTAssertEqual(result, expected)
    }
}
