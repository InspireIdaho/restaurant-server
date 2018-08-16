import Vapor
import FluentSQLite

final class PreparationTime: SQLiteModel {
    var id: Int?
    var preparation_time: Int
    
    init(prepTime: Int) {
        self.preparation_time = prepTime
    }
    
}

extension PreparationTime: Content {}
extension PreparationTime: Parameter {}
extension PreparationTime: Migration {}

