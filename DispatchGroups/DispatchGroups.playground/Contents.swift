import UIKit



func heavyDuty(identifier: String, _ completion: @escaping ()->()) {
    var i = 0
    while i < 5000 {
        print("\(identifier) ======> \(i)")
        i+=1
    }
    completion()
}


let queue1 = DispatchQueue(label: "queue 1")
let queue2 = DispatchQueue(label: "queue 2")
let dispatchGroup = DispatchGroup()

dispatchGroup.enter()
queue1.async {
    heavyDuty(identifier: "call 1") {
        dispatchGroup.leave()
    }
}
dispatchGroup.enter()
queue2.async {
    heavyDuty(identifier: "call 2") {
        dispatchGroup.leave()
    }
}

dispatchGroup.notify(queue: .main) {
    print("Done")
}





