import Foundation
import UIKit

class Day6 {
    
    let input =
    """
    """
    
    enum Direction {
        case up
        case left
        case down
        case right
        
        func index(_ pos: (i: Int, j: Int)) -> (Int, Int) {
            switch self {
            case .up:
                return (pos.i - 1, pos.j)
            case .left:
                return (pos.i, pos.j - 1)
            case .down:
                return (pos.i + 1, pos.j)
            case .right:
                return (pos.i, pos.j + 1)
            }
        }
        
        var nextDirection: Direction {
            switch self {
            case .up:
                return .right
            case .left:
                return .up
            case .down:
                return .left
            case .right:
                return .down
            }
        }
    }
    
    init() {
        parse()
        part1()
        part2()
    }
    
    var map: [[String]] = []
    var startDirection: Direction = .up
    var start: (Int, Int) = (0, 0)
    
    var set: Set<[Int]> = .init()

    func parse() {
        map = input.split(separator: "\n", omittingEmptySubsequences: true)
            .map({
                String($0)
                    .split(separator: "", omittingEmptySubsequences: true)
                    .map({ String($0) })
            })

        for i in 0..<map.count {
            for j in 0..<map[i].count {
                if map[i][j] == "^" {
                    startDirection = .up
                    start = (i, j)
                    map[i][j] = "."
                    break
                }
                if map[i][j] == ">" {
                    startDirection = .right
                    start = (i, j)
                    map[i][j] = "."
                    break
                }
                if map[i][j] == "<" {
                    startDirection = .left
                    start = (i, j)
                    map[i][j] = "."
                    break
                }
                if map[i][j] == "v" {
                    startDirection = .down
                    start = (i, j)
                    map[i][j] = "."
                    break
                }
            }
        }
    }

    func facesEdges(map: [[String]], currentDirection: Direction, pos: (Int, Int)) -> Bool {
        if pos.0 < 0 && currentDirection == .up {
            if pos.1 >= 0 && pos.1 < (map.width - 1) {
                return true
            }
        }
        if pos.0 > (map.height - 1) && currentDirection == .down {
            if pos.1 >= 0 && pos.1 < (map.width - 1) {
                return true
            }
        }
        if pos.1 < 0 && currentDirection == .left {
            if pos.0 >= 0 && pos.0 < (map.height - 1) {
                return true
            }
        }
        if pos.1 > (map.width - 1) && currentDirection == .right {
            if pos.0 >= 0 && pos.0 < (map.height - 1) {
                return true
            }
        }
        
        return false
    }


    func nextMove(map: [[String]],
                  currentDirection: inout Direction,
                  pos: inout (Int, Int),
                  finished: inout Bool) {
        var nextIndex = currentDirection.index(pos)

        if facesEdges(map: map, currentDirection: currentDirection, pos: nextIndex) {
            finished = true
            return
        }
        
        if map[nextIndex.0][nextIndex.1] == "." {
            pos = nextIndex
        }
        else if map[nextIndex.0][nextIndex.1] == "#" || map[nextIndex.0][nextIndex.1] == "0" {
            currentDirection = currentDirection.nextDirection
        }
    }
    
    func part1() {
        var set: Set<[Int]> = .init()
        set.insert([start.0, start.1])

        var finished = false
        var currentDirection = startDirection
        var currentPosition = start {
            didSet {
                set.insert([currentPosition.0, currentPosition.1])
            }
        }

        while !finished {
            nextMove(map: map,
                     currentDirection: &currentDirection,
                     pos: &currentPosition,
                     finished: &finished)
        }

        self.set = set
        print(set.count)
    }
    
    func part2() {
        var finished = false
        var currentDirection = startDirection
        var currentPosition = start
        var newObstaclesCount = 0

        set.remove([start.0, start.1])

        for (index, element) in set.enumerated() {
            let i = element[0]
            let j = element[1]
            
            print(index)
            
            map[i][j] = "0"
            currentDirection = startDirection
            currentPosition = start
            finished = false
            
            var count = 0
            
            while !finished {
                nextMove(map: map,
                         currentDirection: &currentDirection,
                         pos: &currentPosition,
                         finished: &finished)
                count += 1
                
                if count > 25000 {
                    newObstaclesCount += 1
                    break
                }
            }
            
            map[i][j] = "."
        }

        print(newObstaclesCount)
    }
}


extension [[String]] {
    var height: Int {
        return count
    }
    
    var width: Int {
        return first?.count ?? 0
    }
}
