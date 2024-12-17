import Foundation
import UIKit

class ViewController: UIViewController {

    let input =
    """
    Register A: 24847151
    Register B: 0
    Register C: 0

    Program: 2,4,1,5,7,5,1,6,0,3,4,0,5,5,3,0
    """

    let testInput =
    """
    Register A: 2024
    Register B: 0
    Register C: 0

    Program: 0,3,5,4,3,0
    """

    override func viewDidLoad() {
        super.viewDidLoad()

        parse()
        part1()
        part2()
    }

    var strings: [String] = []

    var A = 0
    var B = 0
    var C = 0

    var program: [Int] = []

    func parse() {
//        strings = testInput.split(separator: "\n", omittingEmptySubsequences: true)
        strings = input.split(separator: "\n", omittingEmptySubsequences: true)
            .map({ String($0) })

        A = Int(strings[0].split(separator: "Register A: ")[0])!
        B = Int(strings[1].split(separator: "Register B: ")[0])!
        C = Int(strings[2].split(separator: "Register C: ")[0])!

        program = strings[3].split(separator: "Program: ")[0].split(separator: ",").map({ Int($0)! })
    }

    func comboOperand(code: Int) -> Int {
        switch code {
        case 0, 1, 2, 3:
            return code
        case 4:
            return A
        case 5:
            return B
        case 6:
            return C
        default:
            return 0 // error
        }
    }

    var instructionPointer = 0
    var output: [Int] = []

    func operation(operand: Int, code: Int) {
        switch code {
        case 0: // adv
            let result = Int(Double(A) / Double( 2 << (comboOperand(code: operand) - 1)))
            A = result

        case 1: // bxl (xor)
            let result = B ^ operand
            B = result

        case 2: // bst
            let result = comboOperand(code: operand) % 8
            B = result

        case 3: // jnz
            if A == 0 { break }
            instructionPointer = operand
            return

        case 4: // bxc
            let result = B ^ C
            B = result

        case 5: // out
            let result = comboOperand(code: operand) % 8
            output.append(result)

        case 6: // bdv
            let result = Int(Double(A) / Double( 2 << (comboOperand(code: operand) - 1)))
            B = result

        case 7: // cdv
            let result = Int(Double(A) / Double( 2 << (comboOperand(code: operand) - 1)))
            C = result

        default:
            return
        }

        instructionPointer += 2
    }

    func part1() {
        while instructionPointer < program.count - 1 {
            let code = program[instructionPointer]
            let operand = program[instructionPointer + 1]
            operation(operand: operand, code: code)
        }
        print(output.map({ String($0) }).joined(separator: ","))
    }

    func part2() {
        // sequences and observations
    }
}
