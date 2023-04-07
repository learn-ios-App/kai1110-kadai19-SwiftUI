
import SwiftUI

struct ContentView: View {
    @StateObject var fruitViewModel = FruitViewModel()
    var body: some View {
        NavigationStack {
            List {
                ForEach(fruitViewModel.fruits) { item in
                    ListItemView(
                        fruit: item,
                        update: { newFruit in
                            fruitViewModel.update(newFruit: newFruit)
                        }
                    )
                }
                .onDelete(perform: fruitViewModel.delete)
            }
            .listStyle(InsetListStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        fruitViewModel.didTapPlusButton()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $fruitViewModel.isAddView) {
                FruitAddView(
                    cancel: {
                        fruitViewModel.didTapAddViewCancelButton()
                    },
                    save: { text in
                        fruitViewModel.didTapAddViewSaveButton(text: text)
                    }
                )
            }
            .onAppear(perform: fruitViewModel.onAppear)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
