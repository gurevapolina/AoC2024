import Foundation
import UIKit

class ViewController: UIViewController {
    
    let input =
    """
    """
    
    let testInput =
    """
    Button A: X+94, Y+34
    Button B: X+22, Y+67
    Prize: X=8400, Y=5400

    Button A: X+26, Y+66
    Button B: X+67, Y+21
    Prize: X=12748, Y=12176

    Button A: X+17, Y+86
    Button B: X+84, Y+37
    Prize: X=7870, Y=6450

    Button A: X+69, Y+23
    Button B: X+27, Y+71
    Prize: X=18641, Y=10279
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parse()
        part1()
        part2()
    }
    
    var machines: [Machine] = []
    var strings: [String] = []
    
    func parse() {
//        strings = testInput.split(separator: "\n", omittingEmptySubsequences: true)
        strings = input.split(separator: "\n", omittingEmptySubsequences: true)
            .map({ String($0) })
        
        while !strings.isEmpty {
            let firstThree = strings.prefix(3).map({ $0 })
            let a = stringToPoint(string: firstThree[0], sign: "+")
            let b = stringToPoint(string: firstThree[1], sign: "+")
            let xy = stringToPoint(string: firstThree[2], sign: "=")
            
            machines.append(Machine(
                ax: Double(a[0]),
                bx: Double(b[0]),
                ay: Double(a[1]),
                by: Double(b[1]),
                x: Double(xy[0]),
                y: Double(xy[1])
            ))
        
            strings.removeFirst(3)
        }
    }
    
    func stringToPoint(string: String, sign: String) -> [Int] {
        let values = string.split(separator: ",", omittingEmptySubsequences: true).compactMap({
            String($0).split(separator: sign, omittingEmptySubsequences: true).compactMap({ Int($0) }).last
        })
            
        return values
    }

    
    func part1() {
        let result = machines.reduce(0) { partialResult, machine in
            if let pointsToWin = machine.pointsToWin() {
                return partialResult + pointsToWin
            }
            return partialResult
        }
        print(result)
    }
    
    func part2() {
        let result = machines.reduce(0) { partialResult, machine in
            if let pointsToWin = machine.pointsToWin(isPart2: true) {
                return partialResult + pointsToWin
            }
            return partialResult
        }
        print(result)
    }
}

struct Machine {
    let ax: Double
    let bx: Double
    let ay: Double
    let by: Double
    let x: Double
    let y: Double
    
    func pointsToWin(isPart2: Bool = false) -> Int? {
        let x = Double(self.x) + (isPart2 ? 10000000000000 : 0)
        let y = Double(self.y) + (isPart2 ? 10000000000000 : 0)
        
        let b = (y - (ay * x / ax)) / (by - (ay * bx / ax))
        let a = (x - bx * b) / ax
        
        let firstCorrect = (ax * round(a) + bx * round(b)) == x
        let secondCorrect = (ay * round(a) + by * round(b)) == y

        if firstCorrect && secondCorrect {
            return Int(round(a)) * 3 + Int(round(b))
        }
        return nil
    }
}
