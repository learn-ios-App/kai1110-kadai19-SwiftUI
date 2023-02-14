
import Foundation

class UserDefaultsManager {
    let userDefaults = UserDefaults.standard
    //UserDefaultsに保存
    func setDefaults(json: String) -> Void {
        let userDefaults = UserDefaults.standard
        userDefaults.set(json, forKey: "Fruits_Key")
    }
    //UserDefaultsから取得
    func getDefaults() -> String {
        let userDefaults = UserDefaults.standard
        let fruits = userDefaults.string(forKey: "Fruits_Key") ?? ""
        return fruits
    }
}
