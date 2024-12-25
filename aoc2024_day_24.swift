import Foundation
import UIKit
import HeapModule
import OrderedCollections

class ViewController: UIViewController {

    let input =
    """
    """

    let testInput =
    """
    x00: 1
    x01: 0
    x02: 1
    x03: 1
    x04: 0
    y00: 1
    y01: 1
    y02: 1
    y03: 1
    y04: 1

    ntg XOR fgs -> mjb
    y02 OR x01 -> tnw
    kwq OR kpj -> z05
    x00 OR x03 -> fst
    tgd XOR rvg -> z01
    vdt OR tnw -> bfw
    bfw AND frj -> z10
    ffh OR nrd -> bqk
    y00 AND y03 -> djm
    y03 OR y00 -> psh
    bqk OR frj -> z08
    tnw OR fst -> frj
    gnj AND tgd -> z11
    bfw XOR mjb -> z00
    x03 OR x00 -> vdt
    gnj AND wpb -> z02
    x04 AND y00 -> kjc
    djm OR pbm -> qhw
    nrd AND vdt -> hwm
    kjc AND fst -> rvg
    y04 OR y02 -> fgs
    y01 AND x02 -> pbm
    ntg OR kjc -> kwq
    psh XOR fgs -> tgd
    qhw XOR tgd -> z09
    pbm OR djm -> kpj
    x03 XOR y03 -> ffh
    x00 XOR y04 -> ntg
    bfw OR bqk -> z06
    nrd XOR fgs -> wpb
    frj XOR qhw -> z04
    bqk OR frj -> z07
    y03 OR x01 -> nrd
    hwm AND bqk -> z03
    tgd XOR rvg -> z12
    tnw OR pbm -> gnj
    """

    override func viewDidLoad() {
        super.viewDidLoad()

        parse()
        part1()
        part2()
    }

    var strings: [String] = []
    var dict: [String: Int] = [:]
    var actions: [Action] = []

    func parse() {
//        strings = testInput.split(separator: "\n")
        strings = input.split(separator: "\n")
            .map({ String($0) })

        for string in strings {
            if string.contains(":") {
                let parts = string.components(separatedBy: ": ")
                dict[parts[0]] = Int(parts[1]) ?? 0
            } else {
                let parts = string.components(separatedBy: " ")
                let operand1 = parts[0]
                let operand2 = parts[2]
                let operation = Operation(string: parts[1])
                let resultTarget = parts[4]

                let action = Action(operand1: operand1,
                                    operand2: operand2,
                                    operation: operation,
                                    resultTarget: resultTarget)
                actions.append(action)
            }
        }
    }

    func part1() {
        var index = 0
        while !actions.isEmpty {
            let action = actions[index]
            if action.performOperation(dict: &dict) {
                actions.remove(at: index)
                if !actions.isEmpty {
                    index = index % actions.count
                }
            } else {
                index = (index + 1) % actions.count
            }
        }

        let binaryResult = dict
            .filter({ $0.key.contains("z") })
            .sorted(by: { $0.key >= $1.key })
            .map({ $0.value })
            .map({ String($0) })
            .joined()

        let result = Int(binaryResult, radix: 2)!
        print(result)
    }

    func part2() {
        var result: [String] = []

        result +=
            actions.filter({
                $0.resultTarget.contains("z") &&
                $0.operation != .xor &&
                $0.resultTarget != "z45"
            }).map({ $0.resultTarget })

        result +=
            actions.filter({
                !$0.resultTarget.contains("z") &&
                !$0.operand1.contains("x") &&
                !$0.operand1.contains("y") &&
                !$0.operand2.contains("x") &&
                !$0.operand2.contains("y") &&
                $0.operation == .xor
            }).map({ $0.resultTarget })

        let xorGates = actions.filter({
            ($0.operand1.contains("x") ||
            $0.operand1.contains("y") ||
            $0.operand2.contains("x") ||
            $0.operand2.contains("y")) &&
            $0.operation == .xor &&
            $0.operand1 != "x00" &&
            $0.operand1 != "y00" &&
            $0.operand2 != "x00" &&
            $0.operand2 != "y00"
        }).map({ $0.resultTarget })

        for gate in xorGates {
            if actions.contains(
                where: { ($0.operand1 == gate || $0.operand2 == gate ) && $0.operation == .xor }
            ) == false {
                result.append(gate)
            }
        }

        let andGates = actions.filter({
            ($0.operand1.contains("x") ||
            $0.operand1.contains("y") ||
            $0.operand2.contains("x") ||
            $0.operand2.contains("y")) &&
            $0.operation == .and &&
            $0.operand1 != "x00" &&
            $0.operand1 != "y00" &&
            $0.operand2 != "x00" &&
            $0.operand2 != "y00"
        }).map({ $0.resultTarget })

        for gate in andGates {
            if actions.contains(
                where: { ($0.operand1 == gate || $0.operand2 == gate ) && $0.operation == .or }
            ) == false {
                result.append(gate)
            }
        }

        print(result.sorted(by: <).joined(separator: ","))
    }
}

struct Action {
    let operand1: String
    let operand2: String
    let operation: Operation
    let resultTarget: String

    func performOperation(dict: inout [String: Int]) -> Bool {
        guard let value1 = dict[operand1],
              let value2 = dict[operand2]
        else { return false }

        let result: Int
        switch operation {
        case .and:
            result = value1 & value2
        case .or:
            result = value1 | value2
        case .xor:
            result = value1 ^ value2
        }

        dict[resultTarget] = result
        return true
    }
}

enum Operation {
    case and
    case or
    case xor

    init(string: String) {
        switch string {
        case "AND":
            self = .and
        case "OR":
            self = .or
        case "XOR":
            self = .xor
        default:
            fatalError()
        }
    }
}
