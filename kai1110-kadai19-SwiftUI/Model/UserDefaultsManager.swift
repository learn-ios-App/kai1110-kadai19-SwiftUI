
import Foundation

class UserDefaultsManager {
    private let userDefaults = UserDefaults.standard
    private var key = "Fruits_Key"
    //UserDefaultsに保存
    func setDefaults(json: String) -> Void {
        userDefaults.set(json, forKey: key)
    }
    //UserDefaultsから取得
    func loadJSON() -> String? {
        let fruits = userDefaults.string(forKey: key)
        return fruits
    }
}
