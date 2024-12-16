import Foundation
import UIKit
import HeapModule

class ViewController: UIViewController {

    let input =
    """
    """

    let testInput =
    """
    #################
    #...#...#...#..E#
    #.#.#.#.#.#.#.#.#
    #.#.#.#...#...#.#
    #.#.#.#.###.#.#.#
    #...#.#.#.....#.#
    #.#.#.#.#.#####.#
    #.#...#.#.#.....#
    #.#.#####.#.###.#
    #.#.#.......#...#
    #.#.###.#####.###
    #.#.#...#.....#.#
    #.#.#.#####.###.#
    #.#.#.........#.#
    #.#.#.#########.#
    #S#.............#
    #################
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
//        map = testInput.split(separator: "\n")
        map = input.split(separator: "\n")
            .map({ String($0).map({ String($0) }) })

        for i in 0..<map.height {
            for j in 0..<map.width {
                if map[i][j] == "S" {
                    startPoint = Point(i, j)
                }
            }
        }
    }

    func findRoutes(_ source: Point) -> ([[Point]], Int) {
        var queue = Heap<Node>()
        queue.insert(
            Node(point: source, direction: .right, score: 0, tiles: [source])
        )
        
        var bestScore = Int.max
        var routes: [[Point]] = []
        var visited: [[Int]: Int] = [:]

        while !queue.isEmpty {
            guard let node = queue.popMin() else { continue }

            if let score = visited[node.point.toSet()] {
                if node.score - score > 1001 {
                    continue
                }
            }

            if map[node.point.i][node.point.j] == "E" {
                if node.score < bestScore {
                    bestScore = node.score
                    routes = [node.tiles]
                } else if node.score == bestScore {
                    routes.append(node.tiles)
                }
            }
            
            visited[node.point.toSet()] = node.score

            let directions = [Direction.up, .down, .left, .right]

            for direction in directions {
                if let nextPoint = direction.next(map: map, point: node.point) {
                    let nextScore = node.score + 1 + node.direction.changedTo(anotherDirection: direction)
                    if nextScore <= bestScore {
                        queue.insert(
                            Node(point: nextPoint,
                                 direction: direction,
                                 score: nextScore,
                                 tiles: node.tiles + [nextPoint])
                        )
                    }
                }
            }
        }

        return (routes, bestScore)
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
    
    var allRoutes: [[Point]] = []

    func part1() {
        let routes = findRoutes(startPoint)
        print(routes.1)
        
        allRoutes = routes.0
    }

    func part2() {
        let set = Set(allRoutes.joined().map({ $0.toSet() }))
        print(set.count)
    }
}

enum Direction {
    case up, down, left, right

    func changedTo(anotherDirection: Direction) -> Int {
        switch (self, anotherDirection) {
        case (.up, .up), (.down, .down), (.left, .left), (.right, .right):
            return 0
        case (.up, .down), (.down, .up), (.left, .right), (.right, .left):
            return 2000
        default:
            return 1000
        }
    }

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
        if map[nextPoint.i][nextPoint.j] == "#" {
            return nil
        }
        return nextPoint
    }
}

class Node: Comparable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        return lhs.score == rhs.score
    }
    
    static func < (lhs: Node, rhs: Node) -> Bool {
        return lhs.score < rhs.score
    }
    
    var point: Point
    var direction: Direction
    var score: Int
    var tiles: [Point]

    init(point: Point, direction: Direction, score: Int, tiles: [Point]) {
        self.point = point
        self.direction = direction
        self.score = score
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
