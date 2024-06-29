//
//  TripsMock.swift
//  TripManagerTests
//
//  Created by Albert Aige Cortasa on 29/6/24.
//

@testable import TripManager

struct TripsMock {
    static var data: [Trip] {
        [Trip(driverName: "test0driverName",
              status: "test0status",
              startTime: "2018-12-18T08:00:00.000Z",
              origin: Trip.LocationPoint(address: "test0address",
                                         point: Trip.Point(latitude: 123132.0, longitude: 123123.0)),
              description: "test0description",
              destination: Trip.LocationPoint(address: "test0address",
                                              point: Trip.Point(latitude: 123132.0, longitude: 123123.0)),
              stops: [Trip.Stop(point: Trip.Point(latitude: 123132.0, longitude: 123123.0), id: 0)]),
         Trip(driverName: "test1driverName",
               status: "test1status",
               startTime: "2018-12-18T08:00:00.000Z",
               origin: Trip.LocationPoint(address: "test1address",
                                          point: Trip.Point(latitude: 123132.0, longitude: 123123.0)),
               description: "test1description",
               destination: Trip.LocationPoint(address: "test1address",
                                               point: Trip.Point(latitude: 123132.0, longitude: 123123.0)),
               stops: [Trip.Stop(point: Trip.Point(latitude: 123132.0, longitude: 123123.0), id: 0)]),
         Trip(driverName: "test2driverName",
               status: "test2status",
               startTime: "2018-12-18T08:00:00.000Z",
               origin: Trip.LocationPoint(address: "test2address",
                                          point: Trip.Point(latitude: 123132.0, longitude: 123123.0)),
               description: "test2description",
               destination: Trip.LocationPoint(address: "test2address",
                                               point: Trip.Point(latitude: 123132.0, longitude: 123123.0)),
               stops: [Trip.Stop(point: Trip.Point(latitude: 123132.0, longitude: 123123.0), id: 0)])
        ]
    }
}
