//: [Previous](@previous)

import Foundation
import Combine

// Map
let numPublisher = PassthroughSubject<Int, Never>()
let numSubscription = numPublisher
    .map{$0 * 2}
    .sink { value in
        print("Transformed value: \(value)")
    }

numPublisher.send(10)
numPublisher.send(20)
numPublisher.send(30)
numSubscription.cancel()

// Filter
let stringPublisher = PassthroughSubject<String, Never>()
let stringSubscription = stringPublisher
    .filter { $0.contains("a") }
    .sink {value in print("Filtered Value: \(value)")}

stringPublisher.send("abc")
stringPublisher.send("qsdfa")
stringPublisher.send("dsfsdfgsdfgew")
stringPublisher.send("qwerfgcvb")
stringSubscription.cancel()
stringPublisher.send("aaaa")

// CombineLastest
// Basic CombineLastest

/*
 "A"      "B"     "C"
    1      2               3
   (A, 1) (B, 2)  (C, 2)  (C, 3)
 */

let strCombinePublisher = PassthroughSubject<String, Never>()
let numCombinePublisher = PassthroughSubject<Int, Never>()

strCombinePublisher.combineLatest(numCombinePublisher).sink { (str, num) in
    print("Receive: \(str), \(num)")
}

// 동일한 결과
//Publishers.CombineLatest(strCombinePublisher, numCombinePublisher)
//    .sink { (str, num) in
//        print("Receive: \(str), \(num)")
//    }

strCombinePublisher.send("A")
numCombinePublisher.send(1)
strCombinePublisher.send("B")
numCombinePublisher.send(2)
strCombinePublisher.send("C")
numCombinePublisher.send(3)

// 응용

let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

let validtatedCrendetialsSubscription = usernamePublisher.combineLatest(passwordPublisher)
    .map { (username, password) -> Bool in
        return !username.isEmpty && !password.isEmpty && password.count > 10
    }
    .sink { valid in
        print("valid? : \(valid)")
    }

usernamePublisher.send("ID")
passwordPublisher.send("0123456789")
passwordPublisher.send("01234567890")

// Merge
let arr1Publiser = [1, 2, 3, 4, 5].publisher
let arr2Publisher = [100, 200, 300].publisher

let mergePublisherSubscription = arr1Publiser.merge(with: arr2Publisher)
    .sink { value in
        print("Merge : \(value)")
    }

// 위와 동일
//Publishers.Merge(arr1Publiser, arr2Publisher)
//    .sink { value in
//        print("Merge : \(value)")
//    }

// ======>
print("=====>\n\n")

var subscriptions = Set<AnyCancellable>()

// removeDuplicates
let words = "Hi Hi there! Hi new ?".components(separatedBy: " ").publisher

words.removeDuplicates()
    .sink { value in
        print("Duplicate : \(value)")
    }
    .store(in: &subscriptions)

// compactMap
let strings = ["A", "1", "1.55", "EEE", "0.1"].publisher

strings.compactMap{ Float($0) }
    .sink { value in
        print("compactMap  : \(value)")
    }
    .store(in: &subscriptions)

// ignoreOutput
let numbers = (1...100_000).publisher

numbers.ignoreOutput()
    .sink(
        receiveCompletion: {
            print("Completed with : \($0)")
        },
        receiveValue: {print($0)}
    )
    .store(in: &subscriptions)

// prefix

numbers.prefix(5)
    .sink(
        receiveCompletion: {
            print("Completed with : \($0)")
        },
        receiveValue: {print($0)}
    )
    .store(in: &subscriptions)

//: [Next](@next)
