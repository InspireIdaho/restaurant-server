import Vapor
import FluentSQLite

final class Categories: SQLiteModel {
    var id: Int?
    var categories: [String]
    
    init(categories: [String]) {
        self.categories = categories
    }
    
}

extension Categories: Content {}
extension Categories: Parameter {}
extension Categories: Migration {}
