//
//  Extension+APIClient.swift
//  WallaMarvel
//
//  Created by Daniel Cano on 5/4/25.
//

import Foundation
@testable import WallaMarvel

extension APIClient {
    static func makeMockedClient() -> APIClient {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)
        return APIClient(session: session)
    }
}
