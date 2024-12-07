import Foundation
import UIKit

class ViewController: UIViewController {
    
    let input =
    """
    """
    
    let testInput =
    """
    190: 10 19
    3267: 81 40 27
    83: 17 5
    156: 15 6
    7290: 6 8 6 15
    161011: 16 10 13
    192: 17 8 14
    21037: 9 7 18 13
    292: 11 6 16 20
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parse()
        part1()
        part2()
    }
    
    struct Equation {
        let result: Int
        let numbers: [Int]
    }
    
    var equations: [Equation] = []

    func parse() {
//        let strings = testInput.split(separator: "\n", omittingEmptySubsequences: true)
        let strings = input.split(separator: "\n", omittingEmptySubsequences: true)
            .map({
                String($0)
                    .split(separator: ":", omittingEmptySubsequences: true)
                    .map({ String($0) })
            })
        
        for string in strings {
            let result = Int(string[0]) ?? 0
            let numbers = string[1].split(separator: " ", omittingEmptySubsequences: true)
                .compactMap({ Int(String($0)) })
            equations.append(Equation(result: result, numbers: numbers))
        }
    }
    
    func solvable(_ equation: Equation) -> Bool {
        return nextStep(equation, index: 0, sum: equation.numbers[0])
    }
    
    func nextStep(_ equation: Equation, index: Int, sum: Int)  -> Bool {
        if index == equation.numbers.count - 1 {
            return equation.result == sum
        }
        guard sum <= equation.result else { return false }
        
        if nextStep(equation, index: index + 1, sum: sum + equation.numbers[index + 1]) {
            return true
        }
        if nextStep(equation, index: index + 1, sum: sum * equation.numbers[index + 1]) {
            return true
        }
        
        if isPart2 {
            let sumValue = "\(sum)"
            let nextIndexValue = "\(equation.numbers[index + 1])"
            let newSum = Int(sumValue + nextIndexValue) ?? 0
            if nextStep(equation, index: index + 1, sum: newSum) {
                return true
            }
        }
        
        return false
    }
    
    var isPart2 = false
    
    func part1() {
        isPart2 = false
        var result = 0
        for equation in equations {
            if solvable(equation) {
                result += equation.result
            }
        }
        print(result)
    }
    
    func part2() {
        isPart2 = true
        var result = 0
        for equation in equations {
            if solvable(equation) {
                result += equation.result
            }
        }
        print(result)
        
    }
}
