
import Foundation

//ViewModel
class FruitDate: ObservableObject {
    @Published var fruits = [
        Fruit(name: "りんご", check: true),
        Fruit(name: "みかん", check: false),
        Fruit(name: "ばなな", check: true),
        Fruit(name: "パイナップル", check: false)
    ]
    let userDefaults = UserDefaults.standard

    func delete(offset: IndexSet) {
        self.fruits.remove(atOffsets: offset)
        let fruitsJson = encodeFruits(fruits: fruits)
        setDefaults(json: fruitsJson)
    }
    
    func addFruit(text: String) {
        self.fruits.append(Fruit(name: text, check: false))
        let fruitsJson = encodeFruits(fruits: fruits)
        setDefaults(json: fruitsJson)
    }
    
    //[Fruit] -> String にエンコード
    func encodeFruits(fruits: [Fruit]) -> String {
        do {
            let data = try JSONEncoder().encode(fruits)
            let json = String(data: data, encoding: .utf8)!
            return json
        } catch {
            return ""
        }
    }
    
    //String -> [Fruit] にデコード
    func decodeFruit(json: String) -> [Fruit] {
        do {
            let data = json.data(using: .utf8)!
            let fruits = try JSONDecoder().decode([Fruit].self, from: data)
            return fruits
        } catch {
            return []
        }
    }
    
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
