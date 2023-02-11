
import SwiftUI

struct ContentView: View {
    @StateObject var fruitsList = FruitDate()
    @State private var isAddView = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(fruitsList.fruits) { item in
                    ListItemView(fruit: item)
                }
                .onDelete(perform: fruitsList.delete)
            }
            .listStyle(InsetListStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAddView = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isAddView) {
                FruitAddView(
                    cancel: {
                        isAddView = false
                    },
                    save: { text in
                        fruitsList.addFruit(text: text)
                        isAddView = false
                    }
                )
            }
            .onAppear() {
                let savedFruits = fruitsList.getDefaults()
                fruitsList.fruits = fruitsList.decodeFruit(json: savedFruits)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
