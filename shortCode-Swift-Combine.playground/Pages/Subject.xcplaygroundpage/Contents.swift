import Combine
import Combine

// PassthroughSubject

let passthroughSubject = PassthroughSubject<String, Never>()
let subscriptionOfPassthroughSubject = passthroughSubject.sink { v in
    print("passthroughSubject received value: \(v)")
}

passthroughSubject.send("Hello")
passthroughSubject.send("world!")

// CurrentValueSubject

let currentSubject = CurrentValueSubject<String, Never>(">>>> init value")

currentSubject.send(">> init next Value")

let subscriptionOfCurrentSubject = currentSubject.sink { v in
    print("currentSubject received value: \(v)")
}

currentSubject.send("More Text")
print("currentSubject.value : \(currentSubject.value)")

print("\n\n ==== subscribe =====")

let arrPublisher = ["Here", "we", "go"].publisher
arrPublisher.subscribe(passthroughSubject)
arrPublisher.subscribe(currentSubject)

