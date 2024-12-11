import Foundation
import UIKit

class ViewController: UIViewController {
    
    let input =
    """
    5688 62084 2 3248809 179 79 0 172169
    """
    
    let testInput =
    """
    125 17
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parse()
        part1()
        part2()
    }
    
    var stones: [Int] = []
    
    func parse() {
//        stones = testInput.split(separator: "\n", omittingEmptySubsequences: true)
       stones = input.split(separator: "\n", omittingEmptySubsequences: true)
            .map({ String($0) }).first?.split(separator: " ").map({ Int(String($0)) ?? 0 }) ?? []
    }
    
    func splitIntoTwo(_ num: Int) -> (Int, Int)? {
        let string = "\(num)"
        
        guard string.count % 2 == 0 else { return nil }
            
        let first = Int(String(string.prefix(string.count / 2))) ?? 0
        let second = Int(String(string.suffix(string.count / 2))) ?? 0
        return (first, second)
    }
    
    func convertNumber(_ n: Int) -> [Int] {
        if n == 0 {
            return [1]
        }
        if let twoNew = splitIntoTwo(n) {
            return [twoNew.0, twoNew.1]
        }
        return [n * 2024]
    }
    
    func numberOfStones(blinks: Int) -> Int {
        var dict: [Int: Int] = [:]
        for stone in stones {
            if let count = dict[stone] {
                dict[stone] = count + 1
            } else {
                dict[stone] = 1
            }
        }
        
        for _ in 0..<blinks {
            let zip = zip(dict.keys, dict.values)

            for (key, value) in zip {
                if let count = dict[key] {
                    let newCount = count - value
                    dict[key] = newCount == 0 ? nil : newCount
                }

                let convertedKey = convertNumber(key)
                if let count = dict[convertedKey[0]] {
                    dict[convertedKey[0]] = count + value
                } else {
                    dict[convertedKey[0]] = value
                }
                if convertedKey.count == 2 {
                    if let count = dict[convertedKey[1]] {
                        dict[convertedKey[1]] = count + value
                    } else {
                        dict[convertedKey[1]] = value
                    }
                }
            }
        }
        return dict.reduce(0, { $0 + $1.value })
    }
    
    func part1() {
        print(numberOfStones(blinks: 25))
    }
    
    func part2() {
        print(numberOfStones(blinks: 75))
    }
}
