//
//  Api.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import Foundation

protocol ApiProtocol {
    /**
     func getData<T: Decodable>(from url: String) async throws -> T?
     - parameter url: The complete url wiht the host and path
     - returns: A generic type T?
     */
    func getData<T: Decodable>(from url: String) async throws -> T?
}

final class Api {
    let client: URLSession
    struct Constants {
        static let host = "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com"
    }

    init(client: URLSession) {
        self.client = client
    }
}

extension Api: ApiProtocol {
    func getData<T: Decodable>(from url: String) async throws -> T? {
        guard let url = URL(string: url) else { return nil }

        let (data, _) = try await client.data(from: url)

        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
