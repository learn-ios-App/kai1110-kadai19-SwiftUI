
import SwiftUI

struct EditView: View {
    @State var fruitName: String
    let cancel: () -> Void
    let edit: (String) -> Void
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
                        edit(fruitName)
                    }) {
                        Text("save")
                    }
                }
            }
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(fruitName: "りんご", cancel: {}, edit: { _ in })
    }
}
