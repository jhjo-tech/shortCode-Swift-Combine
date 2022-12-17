import Foundation
import Combine

// class에서만 동작합니다.
final class ViewModel {
    @Published var name: String = "A"
}

final class Label {
    var text: String = ""
}

let label = Label()
let vm = ViewModel()
print("text : \(label.text)")

vm.$name.assign(to: \.text, on: label)
print("text: \(label.text)")

vm.name = "BB"
print("text: \(label.text)")

vm.name = "HHH"
print("text: \(label.text)")
