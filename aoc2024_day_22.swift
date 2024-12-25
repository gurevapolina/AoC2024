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
    2
    3
    2024
    """

    private typealias PriceChange = (price: Int, change: Int)

    override func viewDidLoad() {
        super.viewDidLoad()

        parse()
        part1()
        part2()
    }

    var numbers: [Int] = []

    func parse() {
        numbers = testInput.split(separator: "\n")
//        numbers = input.split(separator: "\n")
            .map({ Int(String($0)) ?? 0 })
    }

    func nextSecretNumber(number: Int) -> Int {
        var number = number

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

        return prune3
    }

    func secretNumber(initialNumber: Int, n: Int) -> Int {
        var number = initialNumber

        for _ in 0..<n {
            let nextNumber = nextSecretNumber(number: number)
            number = nextNumber
        }

        return number
    }

    func secretNumbers(initialNumber: Int, n: Int) -> [Int] {
        var number = initialNumber

        var result: [Int] = []

        for _ in 0..<n {
            let nextNumber = nextSecretNumber(number: number)
            result.append(nextNumber)
            number = nextNumber
        }

        return result
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
        let offers = numbers.map { n in
            let prices = secretNumbers(initialNumber: n, n: 2000).map { $0 % 10 }
            let changes = zip(prices, prices[1...]).map { $1 - $0 }

            let changesPricePairs = prices[4...].enumerated().map { i, price in
                (changes[i...(i + 3)].map { String($0) }.joined(), price)
            }

            return Dictionary(changesPricePairs, uniquingKeysWith: { first, _ in first } )
        }

        let allOffers = offers.reduce([:]) { $0.merging($1, uniquingKeysWith: +) }
        let bestOffer = allOffers.values.max() ?? 0

        print(bestOffer)
    }
}
