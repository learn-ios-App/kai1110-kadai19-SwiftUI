
import Foundation

class FruitViewModel: ObservableObject {
    @Published var fruits = [
        Fruit(name: "りんご", check: true),
        Fruit(name: "みかん", check: false),
        Fruit(name: "ばなな", check: true),
        Fruit(name: "パイナップル", check: false)
    ]
    //UserDefaultsへの処理を行う為のインスタンス
    private let userDefaultsManeger = UserDefaultsManager()
    
    @Published var isAddView = false

    func delete(offset: IndexSet) {
        self.fruits.remove(atOffsets: offset)
        do {
            try userDefaultsManeger.save(fruits: fruits)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    func addFruit(text: String) {
        self.fruits.append(Fruit(name: text, check: false))
        do {
            try userDefaultsManeger.save(fruits: fruits)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    //編集時とCheckの変更時に呼ばれるメソッド
    func update(newFruit: Fruit) {
        guard let index = fruits.firstIndex(where: { $0.id == newFruit.id }) else {
            return
        }
        fruits[index] = newFruit
        do {
            try userDefaultsManeger.save(fruits: fruits)
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    //アプリ起動時に呼ばれるメソッド
    func onAppear() {
        do {
            let savedFruits = try userDefaultsManeger.load()
            fruits = savedFruits
        } catch {
            let error = error as? DataConvertError ?? DataConvertError.unknown
            print(error.title)
        }
    }
    
    func didTapListItemUpdateButton(newFruit: Fruit) {
        update(newFruit: newFruit)
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
