import Foundation
import UIKit
import HeapModule
import OrderedCollections

class ViewController: UIViewController {

    let input =
    """
    671A
    826A
    670A
    085A
    283A
    """

    let testInput =
    """
    029A
    980A
    179A
    456A
    379A
    """

    override func viewDidLoad() {
        super.viewDidLoad()

        parse()
        part1()
        part2()
    }

    var codes: [String] = []

    func parse() {
//        codes = testInput.split(separator: "\n")
        codes = input.split(separator: "\n")
            .map({ String($0) })
    }

    func way(from: String, to: String) -> String {
        switch (from, to) {
        // 0 to all
        case ("0", "8"):
            return "^^^"
        case ("0", "A"):
            return ">"

        // 1 to all
        case ("1", "A"):
            return ">>v"

        // 2 to all
        case ("2", "6"):
            return ">^"
        case ("2", "8"):
            return "^^"

        // 3 to all
        case ("3", "A"):
            return "v"

        // 5 to all
        case ("5", "A"):
            return "vv>"


        // 6 to all
        case ("6", "7"):
            return "<<^"
        case ("6", "A"):
            return "vv"

        // 7 to all
        case ("7", "0"):
            return ">vvv"
        case ("7", "1"):
            return "vv"

        // 8 to all
        case ("8", "2"):
            return "vv"
        case ("8", "3"):
            return "vv>"
        case ("8", "5"):
            return "v"

        // A to all
        case ("A", "0"):
            return "<"
        case ("A", "2"):
            return "<^"
        case ("A", "6"):
            return "^^"
        case ("A", "8"):
            return "<^^^"

        default:
            return ""
        }
    }

    func robotWay(from: String, to: String) -> String {
        switch (from, to) {
        // ^ to all
        case ("^", ">"):
            return ">v"
        case ("^", "<"):
            return "v<"
        case ("^", "v"):
            return "v"
        case ("^", "A"):
            return ">"

        // < to all
        case ("<", ">"):
            return ">>"
        case ("<", "^"):
            return ">^"
        case ("<", "v"):
            return ">"
        case ("<", "A"):
            return ">>^"

        // v to all
        case ("v", ">"):
            return ">"
        case ("v", "<"):
            return "<"
        case ("v", "^"):
            return "^"
        case ("v", "A"):
            return ">^" // ?

        // > to all
        case (">", "<"):
            return "<<"
        case (">", "^"):
            return "^<" // ?
        case (">", "v"):
            return "<"
        case (">", "A"):
            return "^"

        // A to all
        case ("A", "<"):
            return "v<<"
        case ("A", "^"):
            return "<"
        case ("A", "v"):
            return "<v"
        case ("A", ">"):
            return "v"

        default:
            return ""
        }
    }

    func fromNumericToRobotic(string: String) -> String {
        let parts = string.split(separator: "")
        var lastVisited = "A"
        var result = ""

        for part in parts {
            result += way(from: lastVisited, to: String(part))
            result += "A"
            lastVisited = String(part)
        }

        return result
    }

    func fromRoboticToRobotic(string: String) -> String {
        let parts = string.split(separator: "")
        var lastVisited = "A"
        var result = ""

        for part in parts {
            result += robotWay(from: lastVisited, to: String(part))
            result += "A"
            lastVisited = String(part)
        }

        return result
    }

    func part1() {
        var digitKeypadCodes: [String] = []
        for code in codes {
            let result = fromNumericToRobotic(string: code)
            digitKeypadCodes.append(result)
        }

        var firstRobotCodes: [String] = []
        for code in digitKeypadCodes {
            let result = fromRoboticToRobotic(string: code)
            firstRobotCodes.append(result)
        }

        var secondRobotCodes: [String] = []
        for code in firstRobotCodes {
            let result = fromRoboticToRobotic(string: code)
            secondRobotCodes.append(result)
        }


        var result = 0
        for index in 0..<codes.count {
            let intCode = Int(codes[index].replacingOccurrences(of: "A", with: "")) ?? 0
            let count = secondRobotCodes[index].count
            result += intCode * count
        }

        print(result)
    }

    func part2() {
    }
}
