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
    r, wr, b, g, bwu, rb, gb, br

    brwrr
    bggr
    gbbr
    rrbgbr
    ubwu
    bwurrg
    brgr
    bbrgwb
    """

    override func viewDidLoad() {
        super.viewDidLoad()

        parse()
        part1()
        part2()
    }

    var strings: [String] = []

    func parse() {
        strings = testInput.split(separator: "\n", omittingEmptySubsequences: true)
//        strings = input.split(separator: "\n", omittingEmptySubsequences: true)
            .map({ String($0) })

        possiblePatterns = strings[0].split(separator: ", ").map({ String($0) })
        designs = strings.dropFirst().map({ String($0) })
    }

    var possiblePatterns: [String] = []
    var designs: [String] = []

    func exploreDesign(design: String) -> UInt128 {
        var indexDict = OrderedDictionary<UInt128, UInt128>()
        indexDict[0] = 1

        while let key = indexDict.keys.min(),
              let value = indexDict[key] {
            if key == design.count {
                return value
            }

            let nextIndecies: [UInt128]
            let remaining = design.suffix(design.count - Int(key))
            let exist = possiblePatterns.filter({ remaining.hasPrefix($0) })

            nextIndecies = exist.map({ key + UInt128($0.count) })

            for nextIndex in nextIndecies {
                if let count = indexDict[nextIndex] {
                    indexDict[nextIndex] = count + value
                } else {
                    indexDict[nextIndex] = value
                }
            }

            indexDict[key] = nil
        }

        return 0
    }

    func part1() {
        var uniqueCount = 0
        var allCount: UInt128 = 0

        for (_, design) in designs.enumerated() {
            let count = exploreDesign(design: design)
            if count > 0 {
                uniqueCount += 1
                allCount += count
                print(design, count)
            }
        }
        print(uniqueCount)
        // part 2
        print(allCount)
    }

    func part2() {
    }
}
