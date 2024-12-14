import Foundation
import UIKit

class ViewController: UIViewController {
    
    let input =
    """
    """
    
    var height = 103
    var width = 101
    
    let testInput =
    """
    p=0,4 v=3,-3
    p=6,3 v=-1,-3
    p=10,3 v=-1,2
    p=2,0 v=2,-1
    p=0,0 v=1,3
    p=3,0 v=-2,-2
    p=7,6 v=-1,-3
    p=3,0 v=-1,-2
    p=9,3 v=2,3
    p=7,3 v=-1,2
    p=2,4 v=2,-3
    p=9,5 v=-3,-3
    """
    
    let testHeight = 7
    let testWidth = 11

    override func viewDidLoad() {
        super.viewDidLoad()
        
        parse()
        part1()
        part2()
    }
    
    var strings: [String] = []
    var robots: [Robot] = []
    
    func parse() {
//        strings = testInput.split(separator: "\n", omittingEmptySubsequences: true)
        strings = input.split(separator: "\n", omittingEmptySubsequences: true)
            .map({ String($0) })
        
        let robots = strings.map { string -> Robot in
            let parts = string.components(separatedBy: " ")
            let position = parts[0].components(separatedBy: "=")[1].components(separatedBy: ",").map({ Int($0)! })
            let velocity = parts[1].components(separatedBy: "=")[1].components(separatedBy: ",").map({ Int($0)! })
            return Robot(position: (position[0], position[1]), velocity: (velocity[0], velocity[1]))
        }
        
        self.robots = robots
        
//        height = testHeight
//        width = testWidth
    }
    
    func positionAfter(robot: Robot, seconds: Int) -> Point {
        var x = robot.position.x + (robot.velocity.x * seconds)
        var y = robot.position.y + (robot.velocity.y * seconds)
        
        x = x % width
        y = y % height
        
        if x < 0 {
            x = width + x
        }
        if y < 0 {
            y = height + y
        }
        
        return (x, y)
    }
    
    func quadrand(point: Point) -> Quadrant? {
        if point.x == width / 2 && point.y == height / 2 {
            return nil
        }
        if point.x < width / 2 && point.y < height / 2 {
            return .upLeft
        }
        if point.x > width / 2 && point.y < height / 2 {
            return .upRight
        }
        if point.x < width / 2 && point.y > height / 2 {
            return .downLeft
        }
        if point.x > width / 2 && point.y > height / 2 {
            return .downRight
        }
        return nil
    }
    
    func part1() {
        var dict: [Quadrant: Int] = [:]
        for robot in robots {
            let position = positionAfter(robot: robot, seconds: 100)
            if let quadrant = quadrand(point: position) {
                if let count = dict[quadrant] {
                    dict[quadrant] = count + 1
                } else {
                    dict[quadrant] = 1
                }
            }
        }

        let result = dict.values.reduce(1, { $0 * $1 })
        print(result)
    }
    
    
    func printGrid(points: [Point]) -> Bool {
        var grid = Array(repeating: Array(repeating: ".", count: width), count: height)
        
        for point in points {
            grid[point.y][point.x] = "#"
        }
        
        var contains = false
        
        for row in grid {
            if row.joined().contains("#####################") {
                contains = true
            }
        }
        
        guard contains else {
            return false
        }
        
        for row in grid {
            print(row.joined())
        }
        
        return true
    }
    
    func part2() {
        for i in 1...200000 {
            var positions: [Point] = []
            for robot in robots {
                let position = positionAfter(robot: robot, seconds: i)
                positions.append(position)
            }
            if printGrid(points: positions) {
                print(i)
                return
            }
        }
    }
}

enum Quadrant {
    case upLeft
    case upRight
    case downLeft
    case downRight
}

struct Robot {
    var position: Point
    var velocity: Point
}

typealias Point = (x: Int, y: Int)

