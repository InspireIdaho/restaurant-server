import Vapor
import FluentSQLite

struct DataLoader: SQLiteMigration {
    
    static func revert(on conn: SQLiteConnection) -> EventLoopFuture<Void> {
        return conn.future(())
    }
    
    static func prepare(on connection: SQLiteConnection) -> Future<Void> {
        return DataLoader.initializeData(on: connection)
    }
    
    static func initializeData(on conn: SQLiteConnection) -> Future<Void> {
        
        let appDir = DirectoryConfig.detect()
        let resourceDir = "Sources/App/Resources"
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: appDir.workDir)
                .appendingPathComponent(resourceDir, isDirectory: true)
                .appendingPathComponent("menu.json", isDirectory: false)
            )
            
            var categoryList = Set<String>()
            
            if let items = try? JSONDecoder().decode([MenuItem].self, from: data) {
                
                let baseURL = URL(string: "http://localhost:8090/images/")
                
                for menuItem in items {
                    menuItem.id = nil
                    categoryList.insert(menuItem.category)
                    menuItem.updateURL(baseURL: baseURL!)
                    _ = menuItem.save(on: conn).catch { error in
                        let newID = error.localizedDescription
                    }
                }
                
                _ = Categories(categories: Array(categoryList))
                    .save(on: conn)
            }
        } catch {
            print("could not open initial menu data file")
        }
        
        return conn.future()
    }

}
