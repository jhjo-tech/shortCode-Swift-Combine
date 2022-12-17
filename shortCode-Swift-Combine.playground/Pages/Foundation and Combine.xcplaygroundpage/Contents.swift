import Foundation
import Combine
import SwiftUI

struct Model: Decodable { }

URLSession.shared
    .dataTaskPublisher(for: URL(string: "http://www.google.com")!)
    .map { data, response in
        return data
    }
    .decode(type: Model.self, decoder: JSONDecoder())

// NotificationCenter

let center = NotificationCenter.default
let noti = Notification.Name("MyNoti")
let notiPublisher = center.publisher(for: noti, object: nil)
let subscription = notiPublisher.sink { _ in
    print("Noti Received")
}

center.post(name: noti, object: nil)
subscription.cancel()

// Keypath binding to NSObject instances

let ageLabel = UILabel()

Just(30)
    .map {"Age is \($0)"}
    .assign(to: \.text, on: ageLabel)

print("text: \(ageLabel.text)")

// Timer
let timerPublisher = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect() // subscribe 되면 바로 시작

let timerSubscription = timerPublisher.sink { time in
    print("time: \(time)")
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    timerSubscription.cancel()
}
