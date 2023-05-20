//
//  Mappable.swift
//  onTopPoke
//
//  Created by Vinicius Albino on 20/05/23.
//

import Foundation

public typealias JSONDictionary = [String: Any]
public typealias Mappable = Codable & Equatable

infix operator <-->

public func <--> <T: Codable>(jsonData: Data?, type: T.Type) -> T? {
    guard let data = jsonData, !data.isEmpty else {
        return nil
    }
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .useDefaultKeys
    do {
        return try decoder.decode(T.self, from: data)
    } catch {
        let string = String(data: data, encoding: .utf8)
        print("error decoding \(error) - Data: \(String(describing: string))")
        return nil
    }
}

public func <--> <T:Codable>(jsonData: Data?, type: [T.Type]) -> [T]? {
    guard let data = jsonData, !data.isEmpty else {
        return nil
    }
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .useDefaultKeys
    do {
        return try decoder.decode([T].self, from: data)
    } catch {
        let string = String(data: data, encoding: .utf8)
        print("error decoding \(error) - Data: \(String(describing: string))")
        return nil
    }
}
