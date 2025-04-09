//
//  MessageError.swift
//  AsyncDemo
//
//  Created by HIROKI IKEUCHI on 2025/04/09.
//

import Foundation

// ref: https://ikeh1024.hatenablog.com/entry/2022/11/14/155956
struct MessageError: Swift.Error, CustomStringConvertible, LocalizedError {
    var description: String
    var errorDescription: String? { description }
}
