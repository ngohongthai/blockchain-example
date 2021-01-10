//
//  File.swift
//  
//
//  Created by Ngo Hong Thai on 10/01/2021.
//

import Foundation
import Vapor

final class BlockchainNode: Content {
    var address: String
    
    init(address: String) {
        self.address = address
    }
}
