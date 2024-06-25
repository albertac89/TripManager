//
//  Api.swift
//  TripManager
//
//  Created by Albert Aige Cortasa on 25/6/24.
//

import Foundation

protocol ApiProtocol {
    func getData<T: Decodable>(from url: String) async throws -> T?
}

final class Api {
    let client: URLSession

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
