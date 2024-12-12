import UIKit

class ViewController: UIViewController {

    var input =
    """
    """

    var testInput =
    """
    RRRRIICCFF
    RRRRIICCCF
    VVRRRCCFFF
    VVRCCCJFFF
    VVVVCJJCFE
    VVIVCCJJEE
    VVIIICJJEE
    MIIIIIJJEE
    MIIISIJEEE
    MMMISSJEEE
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        parse()
        part1()
        part2()
    }

    var map = [[String]]()

    func parse() {
//        map = input.split(separator: "\n", omittingEmptySubsequences: true)
        map = testInput.split(separator: "\n", omittingEmptySubsequences: true)
            .map { String($0).split(separator: "").map { String($0) } }
    }

    var areas: [[Point]] = []
    var visited: [Point] = []

    func isOnMap(point: Point) -> Bool {
        return point.i >= 0 && point.i < map.height && point.j >= 0 && point.j < map.width
    }

    func hasFance(point: Point, direction: Direction) -> Bool {
        let nextPoint = direction.nextPoint(point)
        return !isOnMap(point: nextPoint) || map[nextPoint.i][nextPoint.j] != map[point.i][point.j]
    }

    func hasItem(point: Point, direction: Direction) -> Bool {
        let nextPoint = direction.nextPoint(point)
        return isOnMap(point: nextPoint) && map[nextPoint.i][nextPoint.j] == map[point.i][point.j]
    }

    func hasDiagonalItem(point: Point, direction: Direction) -> Bool {
        let nextPoint = direction.nextDiagonal(point)
        return isOnMap(point: nextPoint) && map[nextPoint.i][nextPoint.j] == map[point.i][point.j]
    }

    func corners(point: Point) -> Int {
        var corners: Int = 0

        let hasFenceUp = hasFance(point: point, direction: .up)
        let hasFenceDown = hasFance(point: point, direction: .down)
        let hasFenceLeft = hasFance(point: point, direction: .left)
        let hasFenceRight = hasFance(point: point, direction: .right)

        if hasFenceUp && hasFenceLeft {
            corners += 1
        }
        if hasFenceUp && hasFenceRight {
            corners += 1
        }
        if hasFenceDown && hasFenceLeft {
            corners += 1
        }
        if hasFenceDown && hasFenceRight {
            corners += 1
        }

        if hasItem(point: point, direction: .up) && hasItem(point: point, direction: .left) {
            if !hasDiagonalItem(point: point, direction: .left) {
                corners += 1
            }
        }
        if hasItem(point: point, direction: .up) && hasItem(point: point, direction: .right) {
            if !hasDiagonalItem(point: point, direction: .up) {
                corners += 1
            }
        }
        if hasItem(point: point, direction: .down) && hasItem(point: point, direction: .right) {
            if !hasDiagonalItem(point: point, direction: .right) {
                corners += 1
            }
        }
        if hasItem(point: point, direction: .down) && hasItem(point: point, direction: .left) {
            if !hasDiagonalItem(point: point, direction: .down) {
                corners += 1
            }
        }

        return corners
    }

    func perimeter(area: [Point]) -> Int {
        var perimeter: Int = 0

        let directions = [Direction.up, .down, .left, .right]
        for direction in directions {
            perimeter += area.reduce(0, { $0 + (hasFance(point: $1, direction: direction) ? 1 : 0) })
        }
        return perimeter
    }

    func numberOfSides(area: [Point]) -> Int {
        return area.reduce(0, { $0 + corners(point: $1) })
    }

    func findArea(point: Point) -> [Point] {
        let symbol = map[point.i][point.j]
        var area: [Point] = []
        let directions = [Direction.up, .down, .left, .right]

        area.append(point)
        visited.append(point)

        for direction in directions {
            let nextPoint = direction.nextPoint(point)

            if isOnMap(point: nextPoint) && map[nextPoint.i][nextPoint.j] == symbol &&
               !visited.contains(where: { $0.i == nextPoint.i && $0.j == nextPoint.j }) {

                visited.append(nextPoint)
                area.append(contentsOf: findArea(point: nextPoint))
            }
        }
        return area
    }

    func findAllAreas() {
        for i in 0..<map.height {
            for j in 0..<map.width {
                if !visited.contains(where: { $0.i == i && $0.j == j }) {
                    let point = (i, j)
                    areas.append(findArea(point: point))
                }
            }
        }

    }

    func part1() {
        findAllAreas()

        let result = areas.reduce(0, { $0 + $1.count * perimeter(area: $1) })
        print(result)
    }

    func part2() {
        let result = areas.reduce(0, { $0 + $1.count * numberOfSides(area: $1) })
        print(result)

    }
}

struct Fence {
    let point: Point
    let direction: Direction
}

enum Direction {
    case up
    case down
    case left
    case right

    func nextPoint(_ point: Point) -> Point {
        switch self {
        case .up:
            return (point.i - 1, point.j)
        case .down:
            return (point.i + 1, point.j)
        case .left:
            return (point.i, point.j - 1)
        case .right:
            return (point.i, point.j + 1)
        }
    }

    func nextDiagonal(_ point: Point) -> Point {
        switch self {
        case .up:
            return (point.i - 1, point.j + 1)
        case .down:
            return (point.i + 1, point.j - 1)
        case .left:
            return (point.i - 1, point.j - 1)
        case .right:
            return (point.i + 1, point.j + 1)
        }
    }
}

typealias Point = (i: Int, j: Int)

extension [[String]] {
    var height: Int {
        return count
    }

    var width: Int {
        return self[0].count
    }
}
