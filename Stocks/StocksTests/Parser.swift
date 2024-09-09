//
//  Parser.swift
//  Parser
//
//  Created by Naresh on 08/09/2024.
//

import Foundation

protocol FileParsable {
    func read(fileName: String, ext: String) throws -> Data
}

public enum ParsingError: Error {
    case fileNotFound
}

class Parser: FileParsable {
    
    public init() { }
    
    func read(fileName: String, ext: String) throws -> Data {
        guard let url = Bundle(for: Self.self)
                    .url(forResource: fileName, withExtension: ext) else {
            throw ParsingError.fileNotFound
        }
        return try Data(contentsOf: url)
    }
}

