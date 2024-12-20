import Foundation
import UIKit
import HeapModule

class ViewController: UIViewController {

    let input =
    """
    """

    let testInput =
    """
    ###############
    #...#...#.....#
    #.#.#.#.#.###.#
    #S#...#.#.#...#
    #######.#.#.###
    #######.#.#...#
    #######.#.###.#
    ###..E#...#...#
    ###.#######.###
    #...###...#...#
    #.#####.#.###.#
    #.#...#.#.#...#
    #.#.#.#.#.#.###
    #...#...#...###
    ###############
    """

    override func viewDidLoad() {
        super.viewDidLoad()

        parse()
        part1()
        part2()
    }

    var map: [[String]] = []
    var startPoint = Point(0, 0)

    func parse() {
        map = testInput.split(separator: "\n")
//        map = input.split(separator: "\n")
            .map({ String($0).map({ String($0) }) })

        for i in 0..<map.height {
            for j in 0..<map.width {
                if map[i][j] == "S" {
                    startPoint = Point(i, j)
                }
            }
        }
    }

    func findRoutes(_ source: Point) -> [Point] {
        var queue = Heap<Node>()
        queue.insert(
            Node(point: source, tiles: [source])
        )

        var visited: Set<[Int]> = []

        while !queue.isEmpty {
            guard let node = queue.popMin() else { continue }

            if visited.contains(node.point.toSet()) {
                continue
            }

            if map[node.point.i][node.point.j] == "E" {
                return node.tiles
            }

            visited.insert(node.point.toSet())

            let directions = [Direction.up, .down, .left, .right]
            for direction in directions {
                if let nextPoint = direction.next(map: map, point: node.point),
                   map[nextPoint.i][nextPoint.j] != "#" {
                    queue.insert(
                        Node(point: nextPoint, tiles: node.tiles + [nextPoint])
                    )
                }
            }
        }

        return []
    }

    func difference(cheat: Point, route: [Point]) -> Int {
        let up = Direction.up.next(map: map, point: cheat)
        let down = Direction.down.next(map: map, point: cheat)

        if let up, let down, let result = difference(first: up, second: down, route: route) {
            return result
        }

        let left = Direction.left.next(map: map, point: cheat)
        let right = Direction.right.next(map: map, point: cheat)

        if let left, let right, let result = difference(first: left, second: right, route: route) {
            return result
        }

        return 0
    }

    func difference(first: Point, second: Point, route: [Point]) -> Int? {
        if let firstIndex = route.firstIndex(where: { $0.i == first.i && $0.j == first.j }),
           let firstIndex = route.firstIndex(where: { $0.i == second.i && $0.j == second.j }) {
            return abs(firstIndex - firstIndex) - 2
        }
        return nil
    }



    func printRoute(route: [Point]) {
        var copyyy = map
        for point in route {
            copyyy[point.i][point.j] = "O"
        }

        print("_________________________")
        for i in 0..<copyyy.height {
            print(copyyy[i].joined())
        }
        print("_________________________")
    }


    func part1() {
        let deafaultRoute = findRoutes(startPoint)
        print(deafaultRoute.count)

        var result = 0

        for i in 0..<map.height {
            for j in 0..<map.width {
                if i != 0 && j != 0 && i != (map.height - 1) && j != (map.width - 1) && map[i][j] == "#" {
                    let diff = difference(cheat: Point(i, j), route: deafaultRoute)
                    if diff >= 100 {
                        result += 1
                    }
                }
            }
        }
        print(result)
    }

    func part2() {

    }
}

enum Direction {
    case up, down, left, right

    func next(map: [[String]], point: Point) -> Point? {
        let nextPoint: Point
        switch self {
        case .up:
            nextPoint = Point(point.i - 1, point.j)
        case .down:
            nextPoint = Point(point.i + 1, point.j)
        case .left:
            nextPoint = Point(point.i, point.j - 1)
        case .right:
            nextPoint = Point(point.i, point.j + 1)
        }

        if !map.isValid(nextPoint) {
            return nil
        }
        return nextPoint
    }
}

class Node: Comparable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.tiles.count == rhs.tiles.count
    }

    static func < (lhs: Node, rhs: Node) -> Bool {
        return lhs.tiles.count < rhs.tiles.count
    }

    var point: Point
    var tiles: [Point]

    init(point: Point, tiles: [Point]) {
        self.point = point
        self.tiles = tiles
    }
}

class Point {
    var i: Int
    var j: Int

    init(_ i: Int, _ j: Int) {
        self.i = i
        self.j = j
    }

    func toSet() -> [Int] {
        [i, j]
    }
}

extension [[String]] {
    var height: Int { count }
    var width: Int { self[0].count }

    func isValid(_ point: Point) -> Bool {
        point.i >= 0 && point.i < height && point.j >= 0 && point.j < width
    }
}
