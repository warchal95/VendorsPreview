//
//  Dispatching.swift
//  VendorsPreview
//
//  Created by Michał Warchał on 07/04/2022.
//

import Foundation

protocol Dispatching {
    func async(execute workItem: DispatchWorkItem)
}

extension DispatchQueue: Dispatching { }
