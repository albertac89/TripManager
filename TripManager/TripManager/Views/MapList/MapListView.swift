//
//  MapListView.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI
import MapKit
import Polyline

struct MapListView: View {
    @ObservedObject var viewModel: MapListViewModel
    @State private var selectedTrip: Trip?
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: MKMapPoint(.barcelona).coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    @State private var selectedAnnotation: Trip.Stop?

    struct Constants {
        struct Strings {
            static let origin = "Origin"
            static let destination = "Destination"
            static let stop = "Stop"
            static let address = "Address"
            static let okError = "Ok"
        }
    }

    var body: some View {
        Map(position: $position, interactionModes: .all) {
            if let selectedTrip {
                Marker(Constants.Strings.origin, 
                       systemImage: Icons.origin,
                       coordinate: selectedTrip.origin.point.coordinate)
                .tint(.whiteOnDark)
                Marker(Constants.Strings.destination,
                       systemImage: Icons.destination,
                       coordinate: selectedTrip.destination.point.coordinate)
                .tint(.whiteOnDark)

                if let polyline = Polyline(coordinates: selectedTrip.route).mkPolyline {
                    MapPolyline(polyline)
                        .stroke(.blue, lineWidth: 5)
                }

                ForEach(selectedTrip.stops) { stop in
                    if let point = stop.point {
                        Annotation(Constants.Strings.stop, coordinate: point.coordinate) {
                            ZStack {
                                Image(systemName: Icons.stop)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25)
                                    .tint(.whiteOnDark)
                                    .onTapGesture {
                                        if viewModel.stop != nil {
                                            selectedAnnotation = stop
                                        }
                                    }
                            }
                            .task(viewModel.loadStops)
                            .background(.darkOnDark)
                            .clipShape(Circle())
                            .opacity(stop.id == selectedAnnotation?.id ? 0 : 1)
                        }
                        Annotation("", coordinate: point.coordinate) {
                            if stop.id == selectedAnnotation?.id, let stop = viewModel.stop {
                                VStack {
                                    HStack {
                                        Image(systemName: Icons.closeIcon)
                                            .onTapGesture {
                                                selectedAnnotation = nil
                                            }
                                            .tint(.darkOnDark)
                                        Spacer()
                                    }
                                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                    StopInfoView(stop: stop)
                                }
                                .padding(10)
                                .background(.darkOnDark)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                            }
                        }
                    }
                }
            }
        }.onChange(of: selectedTrip) {
            withAnimation(.smooth(duration:  3)) {
                if let selectedTrip, let polyline = Polyline(coordinates: selectedTrip.route).mkPolyline {
                    let rect = viewModel.cameraPosition(for: polyline)
                    position = .rect(rect)
                }
            }
        }
        List(viewModel.trips, selection: $selectedTrip) { trip in
            TripCell(trip: trip)
                .listRowBackground(trip == selectedTrip ? Color.gray : nil)
                .onTapGesture {
                    selectedTrip = trip
                }
        }
        .listStyle(.plain)
        .task(viewModel.loadTrips)
        .refreshable(action: viewModel.loadTrips)
        .alert(viewModel.errorDescription ?? "", isPresented: $viewModel.showError) {
            Button(Constants.Strings.okError, role: .cancel) { }
        }
    }
}

#Preview {
    MapListView(viewModel: MapListViewModel(tripsDataManager: TripsDataManager(api: Api(client: URLSession.shared))))
}
