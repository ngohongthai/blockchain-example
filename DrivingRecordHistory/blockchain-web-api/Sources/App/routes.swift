import Vapor

func routes(_ app: Application) throws {
    let blockchainController = BlockchainController()
   
    app.get("blockchain") {req -> Blockchain in
        return blockchainController.getBlockchain(req: req)
    }
    
    app.post("mine") { req -> HTTPStatus in
        guard let transaction = Transaction(request: req) else {
            return .badRequest
        }
        _ = blockchainController.mine(req: req, transaction: transaction)
        return .ok
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
    
    app.get("driving-record", ":drivingLicenseNumber") { request -> [Transaction] in
        return try blockchainController.getTransactions(req: request)
    }
}
