
import SwiftUI

struct ContentView: View {
    @StateObject var fruitViewModel = FruitViewModel()
    @State private var isAddView = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(fruitViewModel.fruits) { item in
                    ListItemView(
                        fruit: item,
                        update: { newFruit in
                            fruitViewModel.updateDefaults(newFruit: newFruit)
                        }
                    )
                }
                .onDelete(perform: fruitViewModel.delete)
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
                        fruitViewModel.addFruit(text: text)
                        isAddView = false
                    }
                )
            }
            .onAppear() {
                fruitViewModel.firstGet()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
