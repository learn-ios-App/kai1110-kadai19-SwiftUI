
import Foundation

class UserDefaultsManager {
    private let userDefaults = UserDefaults.standard
    private var key = "Fruits_Key"
    
    func save(fruits: [Fruit]) throws -> Void {
        do {
            let json = try encode(fruits: fruits)
            userDefaults.set(json, forKey: key)
        } catch {
            switch error as? DataConvertError ?? DataConvertError.unknown {
            case .encodingError:
                throw DataConvertError.encodingError
            case .dataCorrupted:
                throw DataConvertError.dataCorrupted
            default:
                throw DataConvertError.unknown
            }
        }
    }
    
    func load() throws -> [Fruit] {
        guard let json = userDefaults.string(forKey: key) else {
            throw DataConvertError.dataGetError
        }
        do {
            let fruits = try decode(json: json)
            return fruits
        } catch {
            switch error as? DataConvertError ?? DataConvertError.unknown {
            case .decodingError:
                throw DataConvertError.decodingError
            case .dataCorrupted:
                throw DataConvertError.dataCorrupted
            default:
                throw DataConvertError.unknown
            }
            
        }
    }
    
    
    private func decode(json: String) throws -> [Fruit] {
        do {
            guard let data = json.data(using: .utf8) else {
                throw DataConvertError.dataCorrupted
            }
            let fruits = try JSONDecoder().decode([Fruit].self, from: data)
            return fruits
        } catch {
            throw DataConvertError.decodingError
        }
    }
    
    private func encode(fruits: [Fruit]) throws -> String {
        do {
            let data = try JSONEncoder().encode(fruits)
            guard let json = String(data: data, encoding: .utf8) else {
                throw DataConvertError.dataCorrupted
            }
            return json
        } catch {
            throw DataConvertError.encodingError
        }
    }
}
