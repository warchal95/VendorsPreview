//
//  NetworkError.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import Foundation

enum NetworkError: Error {
    case general
    case parsing
    case requestMalformed
}
