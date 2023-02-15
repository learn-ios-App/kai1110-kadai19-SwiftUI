
import Foundation

class UserDefaultsManager {
    private let userDefaults = UserDefaults.standard

    private let key = "Fruits_Key"

    //UserDefaultsに保存
    func save(json: String) {
        userDefaults.set(json, forKey: key)
    }
    //UserDefaultsから取得
    func loadJSON() -> String? {
        userDefaults.string(forKey: key)
    }
}
