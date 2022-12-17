import Foundation
import Combine

let subject = PassthroughSubject<String, Never>()

let subscription = subject
    .print("[Debug]") // 중간 과정을 볼 수 있다.
    .sink { v in
    print("Subscriber received value: \(v)")
}

subject.send("Hello")
subject.send("Hello 1")
subject.send("Hello last")
//subject.send(completion: .finished)
subscription.cancel()
subject.send("new Hello!!")

