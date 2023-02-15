
import Foundation

class FruitViewModel: ObservableObject {
    @Published var fruits = [
        Fruit(name: "りんご", check: true),
        Fruit(name: "みかん", check: false),
        Fruit(name: "ばなな", check: true),
        Fruit(name: "パイナップル", check: false)
    ]
    //エンコード・デコードするためのインスタンス
    private let convert = ConvertManager()
    //UserDefaultsへの処理を行う為のインスタンス
    private let userDefaults = UserDefaultsManager()
    
    @Published var isAddView = false

    func delete(offset: IndexSet) {
        self.fruits.remove(atOffsets: offset)
        guard let fruitsJson = convert.encode(fruits: fruits) else {
            return
        }
            userDefaults.setDefaults(json: fruitsJson)
    }
    
    func addFruit(text: String) {
        self.fruits.append(Fruit(name: text, check: false))
        guard let fruitsJson = convert.encode(fruits: fruits) else {
            return
        }
            userDefaults.setDefaults(json: fruitsJson)
    }
    
    //編集時とCheckの変更時に呼ばれるメソッド
    func updateDefaults(newFruit: Fruit) {
        guard let index = fruits.firstIndex(where: { $0.id == newFruit.id }) else {
            return
        }
        fruits[index] = newFruit
        guard let result = convert.encode(fruits: self.fruits) else {
            return
        }
        userDefaults.setDefaults(json: result)
    }
    
    //アプリ起動時に呼ばれるメソッド
    func onAppear() {
        guard let savedJson = userDefaults.loadJSON() else {
            return
        }
        guard let savedFruits = convert.decode(json: savedJson) else {
            return
        }
        fruits = savedFruits
    }
    
    func didTapListItemUpdateButton(newFruit: Fruit) {
        updateDefaults(newFruit: newFruit)
    }
    
    func didTapPlusButton() {
        isAddView = true
    }
    
    func didTapAddViewCancelButton() {
        isAddView = false
    }
    
    func didTapAddViewSaveButton(text: String) {
        addFruit(text: text)
        isAddView = false
    }
}
