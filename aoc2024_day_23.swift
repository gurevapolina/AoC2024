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
    kh-tc
    qp-kh
    de-cg
    ka-co
    yn-aq
    qp-ub
    cg-tb
    vc-aq
    tb-ka
    wh-tc
    yn-cg
    kh-ub
    ta-co
    de-co
    tc-td
    tb-wq
    wh-td
    ta-ka
    td-qp
    aq-cg
    wq-ub
    ub-vc
    de-ta
    wq-aq
    wq-vc
    wh-yn
    ka-de
    kh-ta
    co-tc
    wh-qp
    tb-vc
    td-yn
    """

    override func viewDidLoad() {
        super.viewDidLoad()

        parse()
        part1()
        part2()
    }

    var pairs: [[String]] = []

    func parse() {
        pairs = testInput.split(separator: "\n")
//        pairs = input.split(separator: "\n")
            .map({
                String($0).split(separator: "-").map({ String($0) })
            })
    }

    var set: Set<[String]> = .init()

    func part1() {
        var index = 0
        while index < pairs.count {
            let current = pairs[index]

            let pairsWithFirst = pairs.filter({ $0.contains(current[0]) && $0 != current })
            let pairsWithSecond = pairs.filter({ $0.contains(current[1]) && $0 != current })

            pairLoop: for pair in pairsWithFirst {
                for pair2 in pairsWithSecond {
                    if pair[0] == pair2[0] {
                        set.insert([current[0], current[1], pair[0]].sorted())
                    }

                    if pair[0] == pair2[1] {
                        set.insert([current[0], current[1], pair[0]].sorted())
                    }

                    if pair[1] == pair2[0] {
                        set.insert([current[0], current[1], pair[1]].sorted())
                    }

                    if pair[1] == pair2[1] {
                        set.insert([current[0], current[1], pair[1]].sorted())
                    }
                }
            }

            index += 1
        }

        var result = 0
        for elem in set {
            if elem.contains(where: { $0.starts(with: "t") }) {
                result += 1
            }
        }
        print(result)
    }

    func part2() {
        var dict: OrderedDictionary<String, Int> = [:]

        for elem in set {
            if let count = dict[elem[0]] {
                dict[elem[0]] = count + 1
            } else {
                dict[elem[0]] = 1
            }

            if let count = dict[elem[1]] {
                dict[elem[1]] = count + 1
            } else {
                dict[elem[1]] = 1
            }

            if let count = dict[elem[2]] {
                dict[elem[2]] = count + 1
            } else {
                dict[elem[2]] = 1
            }
        }

        let max = dict.max(by: { $0.value <= $1.value })!.value
        let result = dict.filter({ $0.value == max }).map({ $0.key })
        print(result.sorted().joined(separator: ","))
    }
}
