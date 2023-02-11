
import Foundation

//Model
struct Fruit: Identifiable, Codable {
    var id = UUID()
    var name: String
    var check: Bool
}
