import Combine

let just = Just(10000)
let subsctiptionOfJust = just.sink { v in
    print("just Received value: \(v)")
}

print("\n==== Array Publisher ====")

let arrPublisher = [1, 3, 4, 7, 9].publisher
let subscriptionOfArrP = arrPublisher.sink { v in
    print("arry Received value: \(v)")
}

print("\n==== keyPath Publisher ====")

class NewClaee {
    var classProperty: Int = 0 {
        didSet {
            print("DidSet property to \(classProperty)")
        }
    }
}

let newObject = NewClaee()
//newObject.classProperty = 5
let subscriptionKeyPath = arrPublisher.assign(to: \.classProperty, on: newObject)
print("Final Value : \(newObject.classProperty)")

print("\n==== Future Publisher ====")

let myFuture = Future<Int, Never> { promise in
    promise(.success(10))
}

myFuture.sink { v in
    print("\(v)")
}
