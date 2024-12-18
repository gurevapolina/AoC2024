import Foundation
import UIKit
import HeapModule

class ViewController: UIViewController {
    
    let input =
    """
    """

    let testInput =
    """
    5,4
    4,2
    4,5
    3,0
    2,1
    6,3
    2,4
    1,5
    0,6
    3,3
    2,6
    5,1
    1,2
    5,5
    2,5
    6,5
    1,4
    0,4
    6,4
    1,1
    6,1
    1,0
    0,5
    1,6
    2,0
    """
    
    var testSize = 7

    override func viewDidLoad() {
        super.viewDidLoad()

        parse()
        part1()
        part2()
    }

    var strings: [String] = []
    
    var brokenBites: [Point] = []
    
    var size = 0
    var map: [[String]] = []
    var startPoint = Point(0, 0)

    func parse() {
//        strings = testInput.split(separator: "\n", omittingEmptySubsequences: true)
        strings = input.split(separator: "\n", omittingEmptySubsequences: true)
            .map({ String($0) })
        
        brokenBites = strings.map({ string in
            let parts = string.split(separator: ",")
            return Point(Int(parts[0])!, Int(parts[1])!)
        })
        
        size = 71
//        size = testSize
        
        map = Array(repeating: Array(repeating: ".", count: size), count: size)
    }

    func findRoutes(_ source: Point, forbiddenCount: Int) -> [Point] {
        var queue = Heap<Node>()
        queue.insert(
            Node(point: source, tiles: [source])
        )
        
        let forbiddenTiles = Array(brokenBites.prefix(forbiddenCount))

        var visited: Set<[Int]> = []

        while !queue.isEmpty {
            guard let node = queue.popMin() else { continue }
            
            if visited.contains(node.point.toSet()) {
                continue
            }
            
            if node.point.x == size - 1 && node.point.y == size - 1 {
                return node.tiles
            }
            
            visited.insert(node.point.toSet())
            
            let directions = [Direction.up, .down, .left, .right]
            for direction in directions {
                if let nextPoint = direction.next(map: map, point: node.point, forbidden: forbiddenTiles) {
                    queue.insert(
                        Node(point: nextPoint, tiles: node.tiles + [nextPoint])
                    )
                }
            }
        }

        return []
    }

    func part1() {
        let route = findRoutes(startPoint, forbiddenCount: 1024)
        print(route.count - 1)
    }

    func part2() {
        for i in 3025..<brokenBites.count {
            let route = findRoutes(startPoint, forbiddenCount: i)
            if route.isEmpty {
                print("No route found for \(brokenBites[i - 1].x),\(brokenBites[i - 1].y)")
                return
            }
        }
    }
}

enum Direction {
    case up, down, left, right

    func next(map: [[String]], point: Point, forbidden: [Point]) -> Point? {
        let nextPoint: Point
        switch self {
        case .up:
            nextPoint = Point(point.x, point.y - 1)
        case .down:
            nextPoint = Point(point.x, point.y + 1)
        case .left:
            nextPoint = Point(point.x - 1, point.y)
        case .right:
            nextPoint = Point(point.x + 1, point.y)
        }

        if !map.isValid(nextPoint) {
            return nil
        }
        if forbidden.contains(where: { $0.x == nextPoint.x && $0.y == nextPoint.y }) {
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
    var x: Int
    var y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }

    func toSet() -> [Int] {
        [x, y]
    }
}

extension [[String]] {
    func isValid(_ point: Point) -> Bool {
        point.x >= 0 && point.x < count && point.y >= 0 && point.y < count
    }
}
