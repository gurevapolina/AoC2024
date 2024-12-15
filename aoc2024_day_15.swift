import Foundation
import UIKit

class ViewController: UIViewController {
    
    let input =
    """
    """
    
    let testInput =
    """
    ##########
    #..O..O.O#
    #......O.#
    #.OO..O.O#
    #..O@..O.#
    #O#..O...#
    #O..O..O.#
    #.OO.O.OO#
    #....O...#
    ##########

    <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
    vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
    ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
    <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
    ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
    ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
    >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
    <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
    ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
    v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
    """

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parse()
        parsePart1()
        part1()
        parsePart2()
        part2()
    }
    
    var strings: [String] = []
    
    var moves: [Direction] = []
    var map: [[String]] = []
    var point: Point = (0, 0)
    
    func parse() {
        strings = testInput.split(separator: "\n").map({ String($0) })
//        strings = input.split(separator: "\n").map({ String($0) })
    }
    
    func parsePart1() {
        let parts = strings.split(whereSeparator: { $0.starts(with: "######") })
            
        map = parts[0].map({ $0.map({ String($0) }) })
        map.insert(Array(repeating: "#", count: map.width), at: 0)
        map.append(Array(repeating: "#", count: map.width))
        moves = parts[1].joined().map({ $0 == "v" ? .down : $0 == "^" ? .up : $0 == "<" ? .left : .right })
        
        for i in 0..<map.height {
            for j in 0..<map.width {
                if map[i][j] == "@" {
                    point = (i , j)
                }
            }
        }
    }
    
    func parsePart2() {
        let parts = strings.split(whereSeparator: { $0.starts(with: "######") })
            
        map = parts[0].map({ $0
            .replacingOccurrences(of: "#", with: "##")
            .replacingOccurrences(of: "O", with: "[]")
            .replacingOccurrences(of: ".", with: "..")
            .replacingOccurrences(of: "@", with: "@.")
            .map({ String($0) })
        })
        map.insert(Array(repeating: "#", count: map.width), at: 0)
        map.append(Array(repeating: "#", count: map.width))
        moves = parts[1].joined().map({ $0 == "v" ? .down : $0 == "^" ? .up : $0 == "<" ? .left : .right })
        
        for i in 0..<map.height {
            for j in 0..<map.width {
                if map[i][j] == "@" {
                    point = (i , j)
                }
            }
        }
    }
    
    func isOnMap(_ point: Point) -> Bool {
        return point.i >= 0 && point.j >= 0 && point.i < map.height && point.j < map.width
    }
    
    func makeMove(direction: Direction) {
        let nextPoint = direction.nextPoint(point: point)
        
        if map[nextPoint.0][nextPoint.1] == "." {
            map[nextPoint.0][nextPoint.1] = "@"
            map[point.0][point.1] = "."
            point = nextPoint
            return
        }
        
        guard map[nextPoint.0][nextPoint.1] == "O" else { return }
        
        var toMove = direction.nextPoint(point: nextPoint)
        while isOnMap(toMove) && map[toMove.0][toMove.1] == "O" {
            toMove = direction.nextPoint(point: toMove)
        }
        
        if isOnMap(toMove) == false || map[toMove.0][toMove.1] == "#" {
            return
        }
        
        map[toMove.0][toMove.1] = "O"
        map[nextPoint.0][nextPoint.1] = "@"
        map[point.0][point.1] = "."
        point = nextPoint
    }
    
    func makeMovePart2(direction: Direction) {
        let nextPoint = direction.nextPoint(point: point)
        
        if map[nextPoint.0][nextPoint.1] == "." {
            map[nextPoint.0][nextPoint.1] = "@"
            map[point.0][point.1] = "."
            point = nextPoint
            return
        }
        
        guard map[nextPoint.0][nextPoint.1] == "[" || map[nextPoint.0][nextPoint.1] == "]" else { return }
        
        var toMove = direction.nextPoint(point: nextPoint)
        while isOnMap(toMove) && (map[toMove.0][toMove.1] == "[" || map[toMove.0][toMove.1] == "]") {
            toMove = direction.nextPoint(point: toMove)
        }
        
        if isOnMap(toMove) == false || map[toMove.0][toMove.1] == "#" {
            return
        }
        
        if direction == .left || direction == .right {
            map[toMove.0].remove(at: toMove.1)
            map[toMove.0].insert(".", at: point.1)
            point = nextPoint
            return
        }
        if direction == .up || direction == .down {
            visited = []
            let moved = movePoint(from: nextPoint, direction: direction)
            if moved {
                map[nextPoint.0][nextPoint.1] = "@"
                map[point.0][point.1] = "."
                point = nextPoint
            }
            return
        }
    }
    
    var visited: [Point] = []
    
    func findAllBoxes(from point: Point, direction: Direction) -> [Point] {
        if map[point.i][point.j] != "[" && map[point.i][point.j] != "]" {
            return []
        }
        if visited.contains(where: { $0.i == point.i && $0.j == point.j }) {
            return []
        }
        
        let anotherPoint = map[point.i][point.j] == "[" ? (point.i, point.j + 1) : (point.i, point.j - 1)
        visited.append(point)
        visited.append(anotherPoint)

        var queue: [Point] = [point, anotherPoint]
        
        let next = direction.nextPoint(point: point)
        if isOnMap(next) {
            queue += findAllBoxes(from: next, direction: direction)
        }
        
        let anotherNext = direction.nextPoint(point: anotherPoint)
        if isOnMap(anotherNext) {
            queue += findAllBoxes(from: anotherNext, direction: direction)
        }
        
        return  queue
    }
    
    func movePoint(from point: Point, direction: Direction) -> Bool {
        var queue = findAllBoxes(from: point, direction: direction)
        
        for point in queue {
            let next = direction.nextPoint(point: point)
            if map[next.i][next.j] == "#" {
                return false
            }
        }
        
        if direction == .up {
            queue.sort { $0.i <= $1.i }
        }
        if direction == .down {
            queue.sort { $0.i >= $1.i }
        }
        
        for point in queue {
            let next = direction.nextPoint(point: point)
            if map[next.i][next.j] == "." {
                map[next.i][next.j] = map[point.i][point.j]
                map[point.i][point.j] = "."
            }
        }
        
        return true
    }
    
    func part1() {
        for move in moves {
            makeMove(direction: move)
        }
        
        var result = 0
        for i in 0..<map.height {
            for j in 0..<map.width {
                if map[i][j] == "O" {
                    result += (100 * i + j)
                }
            }
        }
        
        print(result)
    }
    
    func part2() {
        for move in moves {
            makeMovePart2(direction: move)
        }
        
        var result = 0
        for i in 0..<map.height {
            for j in 0..<map.width {
                if map[i][j] == "[" {
                    result += (100 * i + j)
                }
            }
        }
        
        print(result)
    }
}

enum Direction {
    case up
    case down
    case left
    case right

    func nextPoint(point: Point) -> Point {
        switch self {
        case .up:
            return (point.0 - 1, point.1)
        case .down:
            return (point.0 + 1, point.1)
        case .left:
            return (point.0, point.1 - 1)
        case .right:
            return (point.0, point.1 + 1)
        }
    }
}

typealias Point = (i: Int, j: Int)

extension [[String]] {
    var height: Int {
        count
    }
    
    var width: Int {
        self[0].count
    }
}
