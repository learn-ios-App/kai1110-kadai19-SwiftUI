
import SwiftUI

struct ListItemView: View {
    @State var fruit: Fruit
    @State var isEditView = false
    var body: some View {
        HStack {
            HStack {
                Button(action: {
                    fruit.check.toggle()
                }) {
                    Image(
                        systemName: fruit.check
                        ? "checkmark.circle"
                        : "circle"
                    )
                }
                Text(fruit.name)
            }
            Spacer()
            Button(action: {
                isEditView = true
            }) {
                Image(systemName: "i.circle")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .sheet(isPresented: $isEditView) {
            EditView(
                fruitName: fruit.name,
                cancel: {
                    isEditView = false
                },
                edit: { text in
                    fruit.name = text
                    isEditView = false
                }
            )
        }
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(fruit: Fruit(name: "りんご", check: false))
    }
}
