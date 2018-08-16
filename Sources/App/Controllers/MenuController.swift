import Vapor
import FluentSQLite


final class MenuController: RouteCollection {
    
    func boot(router: Router) throws {
        
        router.get("categories", use: getCategories)
        router.get("menu", use: searchForMenuItems)
        router.get("allItems", use: getMenuItems)
        router.post("order", use: submitOrder)
    }
    
    func getCategories(_ req: Request) throws -> Future<Categories>  {
        return Categories.query(on: req).all().flatMap { (cats: [Categories]) in
            
            var returnCat: Categories = Categories(categories: [])
            if !cats.isEmpty {
                returnCat = cats[0]
            }
            return req.future(returnCat)
        }
    }

    func getMenuItems(_ req: Request) throws -> Future<[MenuItem]>  {
        return MenuItem.query(on: req).all()
    }
    
    func searchForMenuItems(_ req: Request) throws -> Future<[MenuItem]> {
        guard let searchTerm = req
            .query[String.self, at: "category"] else {
                throw Abort(.badRequest)
        }
        return MenuItem.query(on: req)
            .filter(\.category == searchTerm).all()
    }

    func submitOrder(_ req: Request) throws -> Future<PreparationTime>  {
        return try req.content.decode(App.Order.self)
            .flatMap(to: PreparationTime.self) { (order: App.Order) in
            return req.future(order.calcPrepTime())
        }
    }


}
