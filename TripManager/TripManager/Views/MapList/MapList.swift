//
//  MapList.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import SwiftUI
import MapKit
import Polyline

struct MapList: View {
    @ObservedObject var viewModel: MapListViewModel
    @State private var selectedTrip: Trip?
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: MKMapPoint(.barcelona).coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    @State private var selectedAnnotation: Trip.Stop?

    var body: some View {
        Map(position: $position, interactionModes: .all) {
            if let selectedTrip {
                Marker("Origen", systemImage: "car.side.fill", coordinate: selectedTrip.origin.point.coordinate).tint(.black)
                Marker("Destino", systemImage: "flag.checkered", coordinate: selectedTrip.destination.point.coordinate).tint(.black)

                if let polyline = Polyline(coordinates: selectedTrip.route).mkPolyline {
                    MapPolyline(polyline).stroke(.blue, lineWidth: 5)
                }

                // TODO fix anotations in dark mode
                ForEach(selectedTrip.stops) { stop in
                    if let point = stop.point {
                        Annotation("Parada", coordinate: point.coordinate) {
                            ZStack {
                                Image(systemName: "mappin.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25)
                                    .onTapGesture {
                                        if viewModel.stop != nil {
                                            selectedAnnotation = stop
                                        }
                                    }
                            }
                            .task(viewModel.loadStops)
                            .background(.white)
                            .clipShape(Circle())
                            .opacity(stop.id == selectedAnnotation?.id ? 0 : 1)
                        }
                        Annotation("", coordinate: point.coordinate) {
                            if stop.id == selectedAnnotation?.id, let stop = viewModel.stop {
                                VStack(alignment: .leading) {
                                    HStack {
                                        Image(systemName: "xmark.circle").onTapGesture {
                                            selectedAnnotation = nil
                                        }.tint(.black)
                                        Spacer()
                                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                                    Text("Address: \(stop.address)").font(.system(size: 12))
                                    Text("Fecha: \(stop.stopTime)").font(.system(size: 12))
                                    Text("Precio: \(stop.price)").font(.system(size: 12))
                                    Text("Pagado: \(stop.paid ? "si" : "no")").font(.system(size: 12))
                                }
                                .padding(10)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
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
            Button("OK", role: .cancel) { }
        }
    }
}

#Preview {
    MapList(viewModel: MapListViewModel(tripsDataManager: TripsDataManager(api: Api(client: URLSession.shared))))
}
