
import SwiftUI

struct FruitAddView: View {
    @State private var fruitName = ""
    let cancel: () -> Void
    let save: (String) -> Void
    var body: some View {
        NavigationStack {
            HStack {
                Text("名前")
                TextField("", text: $fruitName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 150)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        cancel()
                    }) {
                        Text("cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        save(fruitName)
                    }) {
                        Text("save")
                    }
                }
            }
        }
    }
}

struct FruitAddView_Previews: PreviewProvider {
    static var previews: some View {
        FruitAddView(cancel: {}, save: { _ in })
    }
}
