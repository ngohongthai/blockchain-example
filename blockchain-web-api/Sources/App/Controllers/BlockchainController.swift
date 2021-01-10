//
//  File.swift
//  
//
//  Created by Ngo Hong Thai on 10/01/2021.
//

import Foundation
import Vapor

class BlockchainController {
    private (set) var blockchainService: BlockchainServices
    
    init() {
        self.blockchainService = BlockchainServices()
    }
    
    func mine(req: Request, transaction: Transaction) -> Block {
        return blockchainService.getNextBlock(for: [transaction])
    }
    
    func registerNodes(req: Request, nodes: [BlockchainNode]) -> [BlockchainNode] {
        return blockchainService.registerNodes(nodes: nodes)
    }
    
    func getNodes(req: Request) -> [BlockchainNode] {
        return blockchainService.getNodes()
    }
    
    func getBlockchain(req: Request) -> Blockchain {
        return self.blockchainService.getBlockchain()
    }
    
    func resolve(req: Request) -> EventLoopFuture<Blockchain> {
        let promise: EventLoopPromise<Blockchain> = req.eventLoop.makePromise()
        blockchainService.resolve {
            promise.succeed($0)
        }
        
        return promise.futureResult
    }
//    func greet(req: Request) -> EventLoopFuture<String> {
//        return EventLoopFuture(req).map {(req) -> String in
//            return "Wellcome to blockchain"
//        }
//    }
}
