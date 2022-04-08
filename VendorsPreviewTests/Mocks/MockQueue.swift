//
//  MockQueue.swift
//  VendorsPreviewTests
//
//  Created by Michał Warchał on 08/04/2022.
//

import Foundation
@testable import VendorsPreview

final class MockQueue: Dispatching {
    func async(execute workItem: DispatchWorkItem) {
        workItem.perform()
    }
}
