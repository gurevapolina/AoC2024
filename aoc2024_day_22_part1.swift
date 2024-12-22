import Foundation
import UIKit
import HeapModule

class ViewController: UIViewController {

    let input =
    """
    """

    let testInput =
    """
    1
    10
    100
    2024
    """

    override func viewDidLoad() {
        super.viewDidLoad()

        parse()
        part1()
        part2()
    }

    var numbers: [Int] = []

    func parse() {
//        numbers = testInput.split(separator: "\n")
        numbers = input.split(separator: "\n")
            .map({ Int(String($0)) ?? 0 })
    }

    func secretNumber(initialNumber: Int, n: Int) -> Int {
        var number = initialNumber

        for _ in 0..<n {
            let mul64 = number * 64
            let mix1 = mul64 ^ number
            number = mix1
            let prune1 = mix1 % 16777216
            number = prune1

            let div32 = number / 32
            let mix2 = div32 ^ number
            number = mix2
            let prune2 = mix2 % 16777216
            number = prune2

            let mul2048 = prune2 * 2048
            let mix3 = mul2048 ^ number
            number = mix3
            let prune3 = mix3 % 16777216
            number = prune3
        }

        return number
    }


    func part1() {
        var sum = 0
        for number in numbers {
            let result = secretNumber(initialNumber: number, n: 2000)
            sum += result
        }

        print(sum)
    }

    func part2() {
    }
}
