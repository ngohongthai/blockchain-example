//
//  File.swift
//  
//
//  Created by Ngo Hong Thai on 10/01/2021.
//

import Foundation

class BlockchainServices {
    private (set) var blockchain: Blockchain
    
    init() {
        self.blockchain = Blockchain(genesisBlock: Block())
    }
    
    func resolve(completion: @escaping (Blockchain) -> ()) {
        let nodes = self.blockchain.nodes
        
        for node in nodes {
            let url = URL(string: "\(node.address)/blockchain")!
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data,
                   let blockchain = try? JSONDecoder().decode(Blockchain.self, from: data) {
                    if self.blockchain.blocks.count > blockchain.blocks.count {
                        completion(self.blockchain)
                    } else {
                        self.blockchain = blockchain
                        completion(blockchain)
                    }
                }
            }.resume()
        }
    }
    
    func getBlockchain() -> Blockchain {
        return self.blockchain
    }
    
    
    func getNextBlock(for transactions: [Transaction]) -> Block {
        let block = blockchain.getNextBlock(transactions: transactions)
        blockchain.addBlock(block)
        return block
    }
    
    func registerNodes(nodes: [BlockchainNode]) -> [BlockchainNode] {
        return self.blockchain.registerNodes(nodes: nodes)
    }
    
    func getNodes() -> [BlockchainNode] {
        return blockchain.nodes
    }
}
