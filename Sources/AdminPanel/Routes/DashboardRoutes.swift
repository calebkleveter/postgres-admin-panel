import Vapor
import HTTP
import Routing

public struct DashboardRoutes: RouteCollection {
    
    public typealias Wrapped = Responder
    
    let drop: Droplet
    let customRoutePaths: [String]?
    
    public init(droplet: Droplet, customViews paths: [String]? = nil) {
        drop = droplet
        customRoutePaths = paths
    }
    
    public func build<Builder: RouteBuilder>(_ builder: Builder) where Builder.Value == Wrapped {
        
        let controller = DashboardController(droplet: drop, customViews: customRoutePaths)
        
        builder.get("/", handler: controller.index);
        
        for page in controller.custom() {
            builder.get(page.url, handler: page.route)
        }
    }
}
