import Foundation
import UIKit

class ViewController: UIViewController {
    
    let input =
    """
    """
    
    let testInput =
    """
    2333133121414131402
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parse()
        part1()
        part2()
    }
    
    var string: String = ""
    
    func parse() {
        string = testInput.split(separator: "\n", omittingEmptySubsequences: true)
//        string = input.split(separator: "\n", omittingEmptySubsequences: true)
            .map({ String($0) }).first ?? ""
    }
    
    func generateWithFreeSpace(_ string: String) -> [String] {
        var result: [String] = []
        for (index, char) in string.enumerated() {
            let intValue = Int(String(char)) ?? 0
            for _ in 0..<intValue {
                result.append(index % 2 == 0 ? "\(index / 2)" : ".")
            }
        }
        return result
    }
    
    func rearrageString(_ string: [String]) -> [String] {
        var stringArray = string.map({ String($0) })
        var result: [String] = []
        
        
        var frontIndex = 0
        var backIndex = stringArray.count - 1
        
        while frontIndex < stringArray.count {
            if stringArray[frontIndex] == "." {
                while stringArray[backIndex] == "." {
                    backIndex -= 1
                }
                if backIndex > frontIndex {
                    result.append("\(stringArray[backIndex])")
                    stringArray[backIndex] = "."
                    backIndex -= 1
                }
            } else {
                result.append("\(stringArray[frontIndex])")
            }
            frontIndex += 1
        }
        return result
    }
    
    func generateWithFreeSpace2(_ string: String) -> [Space] {
        var result: [Space] = []
        for (index, char) in string.enumerated() {
            let intValue = Int(String(char)) ?? 0
            result.append(
                Space(value: index % 2 == 1 ? nil : index / 2,
                      length: intValue,
                      visited: false)
            )
        }
        return result
    }
    
    func rearrageString2(_ spaces: [Space]) -> [Space] {
        var result: [Space] = spaces
        
        while let lastElementIndex = result.lastIndex(where: { $0.value != nil && !$0.visited }) {
            let lastElement = result[lastElementIndex]
            if let index = result.firstIndex(where: { $0.value == nil && $0.length >= lastElement.length }), index < lastElementIndex {
                let emptySpace = result[index]
                if emptySpace.length == lastElement.length {
                    result[index] = Space(value: lastElement.value,
                                          length: lastElement.length,
                                          visited: true)
                    result[lastElementIndex] = emptySpace
                } else {
                    result[lastElementIndex] = Space(value: nil,
                                                     length: lastElement.length,
                                                     visited: true)
                    result[index] = Space(value: lastElement.value,
                                          length: lastElement.length,
                                          visited: true)
                    result.insert(Space(value: nil,
                                        length: emptySpace.length - lastElement.length,
                                        visited: true),
                                  at: index + 1)
                    
                }
            } else {
                result[lastElementIndex] = Space(value: lastElement.value,
                                                 length: lastElement.length,
                                                 visited: true)
            }
        }
        return result
    }
    
    func sum(_ string: [String]) -> Int {
        var result = 0
        for (index, char) in string.enumerated() {
            result += (index * Int(String(char))!)
        }
        return result
    }
    
    func sum2(_ spaces: [Space]) -> Int {
        let array = spaces.map({ Array(repeating: $0.value ?? 0, count: $0.length) }).joined()
        var result = 0
        for (index, elem) in array.enumerated() {
            result += index * elem
        }
        return result
    }
    
    func part1() {
        let freeSpace = generateWithFreeSpace(string)
        let rearranged = rearrageString(freeSpace)
        print(sum(rearranged))
    }
    
    func part2() {
        let freeSpace = generateWithFreeSpace2(string)
        let rearranged = rearrageString2(freeSpace)
        print(sum2(rearranged))
    }
}

struct Space {
    let value: Int?
    let length: Int
    let visited: Bool
}

extension [Space] {
    func printed() {
        var string = ""
        for space in self {
            let element = space.value == nil ? "." : "\(space.value!)"
            for _ in 0..<space.length {
                string.append(element)
            }
        }
        print(string)
    }
}
