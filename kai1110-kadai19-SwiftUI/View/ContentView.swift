
import SwiftUI

struct ContentView: View {
    @StateObject var fruitViewModel = FruitViewModel()

    var body: some View {
        NavigationStack {
            List {
                ForEach(fruitViewModel.fruits) { item in
                    ListItemView(
                        fruit: item,
                        update: fruitViewModel.didTapListItemUpdateButton(newFruit:)
                    )
                }
                .onDelete(perform: fruitViewModel.delete)
            }
            .listStyle(InsetListStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: fruitViewModel.didTapPlusButton) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $fruitViewModel.isAddView) {
                FruitAddView(
                    cancel: fruitViewModel.didTapAddViewCancelButton,
                    save: fruitViewModel.didTapAddViewSaveButton(text:)
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
