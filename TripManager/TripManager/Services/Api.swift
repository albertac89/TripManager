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
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await client.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Failed to decode data"))
        }
    }
}
