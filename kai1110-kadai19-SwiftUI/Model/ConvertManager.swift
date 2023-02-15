
import Foundation

//UserDefaultsで扱うための処理のモデル
class ConvertManager {
    func encode(fruits: [Fruit]) -> String? {
        do {
            let data = try JSONEncoder().encode(fruits)
            guard let json = String(data: data, encoding: .utf8) else {
                return nil
            }
            return json
        } catch {
            return nil
        }
    }
    func decode(json: String) -> [Fruit]? {
        do {
            guard let data = json.data(using: .utf8) else {
                return nil
            }
            let fruits = try JSONDecoder().decode([Fruit].self, from: data)
            return fruits
        } catch {
            return nil
        }
    }
}
