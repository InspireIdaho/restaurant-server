import Vapor
import FluentSQLite

final class MenuItem: SQLiteModel {
    var id: Int?
    var name: String
    var description: String
    var price: Double
    var category: String
    var imageName: String
    var image_url: String?

    init(name: String,
        description: String,
        price: Double,
        category: String,
        imageName: String) {
        self.name = name
        self.description = description
        self.price = price
        self.category = category
        self.imageName = imageName
        self.image_url = ""
    }
    
    func updateURL(baseURL: URL) {
        self.image_url = URL(string: imageName, relativeTo: baseURL)?.absoluteString
    }
}

extension MenuItem: Content {}
extension MenuItem: Parameter {}
extension MenuItem: Migration {}

