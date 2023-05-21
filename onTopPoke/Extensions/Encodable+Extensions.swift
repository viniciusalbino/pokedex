//
//  Encodable+Extensions.swift
//  onTopPoke
//
//  Created by Vinicius Albino on 21/05/23.
//

import Foundation
extension Encodable {
    func encoded() -> Data {
        guard let encoded = try? JSONEncoder().encode(self) else {
            return Data()
        }
        return encoded
    }
}
