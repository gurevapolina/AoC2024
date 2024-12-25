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
    #####
    .####
    .####
    .####
    .#.#.
    .#...
    .....

    #####
    ##.##
    .#.##
    ...##
    ...#.
    ...#.
    .....

    .....
    #....
    #....
    #...#
    #.#.#
    #.###
    #####

    .....
    .....
    #.#..
    ###..
    ###.#
    ###.#
    #####

    .....
    .....
    .....
    #....
    #.#..
    #.#.#
    #####
    """

    override func viewDidLoad() {
        super.viewDidLoad()

        parse()
        part1()
        part2()
    }

    var strings: [String] = []

    var keys: [String] = []
    var locks: [String] = []

    func parse() {
//        strings = testInput.split(separator: "\n")
        strings = input.split(separator: "\n")
            .map({ String($0) })

        while !strings.isEmpty {
            let prefix = strings.prefix(7)
            if prefix[0].hasPrefix("####") {
                locks.append(prefix.joined())
            }
            if prefix[0].hasPrefix("....") {
                keys.append(prefix.joined())
            }

            strings.removeFirst(7)
        }
    }

    func isOverlap(key: String, lock: String) -> Bool {
        for (k, l) in zip(key, lock) {
            if k == "#" && l == "#" {
                return true
            }
        }
        return false
    }

    func part1() {
        var result = 0
        for key in keys {
            for lock in locks {
                if isOverlap(key: key, lock: lock) == false {
                    result += 1
                }
            }
        }
        print(result)
    }

    func part2() {
    }
}
