
import Foundation

class ConversionModel {
    func encode(fruits: [Fruit]) -> String {
        do {
            let data = try JSONEncoder().encode(fruits)
            let json = String(data: data, encoding: .utf8)!
            return json
        } catch {
            return ""
        }
    }
    
    func decode(json: String) -> [Fruit] {
        do {
            let data = json.data(using: .utf8)!
            let fruits = try JSONDecoder().decode([Fruit].self, from: data)
            return fruits
        } catch {
            return []
        }
    }
}
