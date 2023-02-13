
import Foundation

class FruitViewModel: ObservableObject {
    @Published var fruits = [
        Fruit(name: "りんご", check: true),
        Fruit(name: "みかん", check: false),
        Fruit(name: "ばなな", check: true),
        Fruit(name: "パイナップル", check: false)
    ]
    let conversion = ConversionModel()
    let userDefaults = UserDefaultsModel()

    func delete(offset: IndexSet) {
        self.fruits.remove(atOffsets: offset)
        let fruitsJson = conversion.encode(fruits: fruits)
            userDefaults.setDefaults(json: fruitsJson)
    }
    
    func addFruit(text: String) {
        self.fruits.append(Fruit(name: text, check: false))
        let fruitsJson = conversion.encode(fruits: fruits)
            userDefaults.setDefaults(json: fruitsJson)
    }
    
    func updateDefaults() {
        let result = conversion.encode(fruits: self.fruits)
        userDefaults.setDefaults(json: result)
    }
    
    //アプリ起動時に呼ばれるメソッド
    func firstGet() -> [Fruit] {
        let savedJson = userDefaults.getDefaults()
        let fruitList = conversion.decode(json: savedJson)
        return fruitList
    }
}
