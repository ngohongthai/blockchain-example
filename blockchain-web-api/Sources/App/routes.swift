import Vapor

func routes(_ app: Application) throws {
    let blockchainController = BlockchainController()
   
    app.get("blockchain") {req -> Blockchain in
        return blockchainController.getBlockchain(req: req)
    }
    
    app.post("mine") { req -> Block in
        let transaction = try req.content.decode(Transaction.self)
        return blockchainController.mine(req: req, transaction: transaction)
    }
    
    app.post("nodes","register") { req -> [BlockchainNode] in
        let nodes = try req.content.decode([BlockchainNode].self)
        return blockchainController.registerNodes(req: req, nodes: nodes)
    }
    
    app.get("nodes") {req -> [BlockchainNode] in
        return blockchainController.getNodes(req: req)
    }
    
    app.get("resolve") {
        return blockchainController.resolve(req: $0)
    }
    
}
