
import Foundation

class FruitViewModel: ObservableObject {
    @Published var fruits = [
        Fruit(name: "りんご", check: true),
        Fruit(name: "みかん", check: false),
        Fruit(name: "ばなな", check: true),
        Fruit(name: "パイナップル", check: false)
    ]
    //エンコード・デコードするためのインスタンス
    private let conversion = ConversionModel()
    //UserDefaultsへの処理を行う為のインスタンス
    private let userDefaults = UserDefaultsModel()

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
    
    //編集時とCheckの変更時に呼ばれるメソッド
    func updateDefaults(newFruit: Fruit) {
        guard let index = fruits.firstIndex(where: { $0.id == newFruit.id }) else {
            return
        }
        fruits[index] = newFruit
        let result = conversion.encode(fruits: self.fruits)
        userDefaults.setDefaults(json: result)
    }
    
    //アプリ起動時に呼ばれるメソッド
    func firstGet() {
        let savedJson = userDefaults.getDefaults()
        let fruitList = conversion.decode(json: savedJson)
        self.fruits = fruitList
    }
}
