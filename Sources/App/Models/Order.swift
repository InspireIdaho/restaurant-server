import Vapor
import FluentSQLite

final class Order: SQLiteModel {
    var id: Int?
    var menuIds: [Int]
    
    init(menuIds: [Int]) {
        self.menuIds = menuIds
    }
    
    func calcPrepTime() -> PreparationTime {
        return PreparationTime(prepTime: 20)
    }
}

extension Order: Content {}
extension Order: Parameter {}
extension Order: Migration {}
