import Foundation

let input =
"""
"""

// PART 1

enum Direction: String {
    static let all: [Direction] = [.leftUp, .up, .rightUp, .right, .rightDown, .down, .leftDown, .left]

    case leftUp
    case up
    case rightUp
    case right
    case rightDown
    case down
    case leftDown
    case left

    func index(_ i: Int, _ j: Int) -> (Int, Int) {
        switch self {
        case .leftUp:
            return (i - 1, j - 1)
        case .up:
            return (i - 1, j)
        case .rightUp:
            return (i - 1, j + 1)
        case .right:
            return (i, j + 1)
        case .rightDown:
            return (i + 1, j + 1)
        case .down:
            return (i + 1, j)
        case .leftDown:
            return (i + 1, j - 1)
        case .left:
            return (i, j - 1)
        }
    }

}

extension String {
    var next: String? {
        if self == "X" {
            return "M"
        }
        if self == "M" {
            return "A"
        }
        if self == "A" {
            return "S"
        }
        if self == "A" {
            return nil
        }
        return nil
    }
}

let strings = input.split(separator: "\n", omittingEmptySubsequences: true)
    .map({
        String($0)
            .split(separator: "", omittingEmptySubsequences: true)
            .map({ String($0)})
    })
let width = strings.first?.count ?? 0
let height = strings.count

func findNext(strings: [[String]], i: Int, j: Int, direction: Direction? = nil, result: inout Int) {
    guard let next = strings[i][j].next else  {
        result += 1
        return
    }

    let directions: [Direction]

    if let direction {
        directions = [direction]
    } else {
        directions = Direction.all
    }

    for direction in directions {
        let pair = direction.index(i, j)
        if pair.0 >= 0 && pair.1 >= 0 && pair.0 <= (height - 1) && pair.1 <= (width - 1) {
            if strings[pair.0][pair.1] == next {
                findNext(strings: strings, i: pair.0, j: pair.1, direction: direction, result: &result)
            }
        }
    }
}

var result = 0

for i in 0..<strings.count {
    for j in 0..<strings[i].count {
        if strings[i][j] == "X" {
            findNext(strings: strings, i: i, j: j, result: &result)
        }
    }
}

print(result)

// PART 2

func matchesRight(strings: [[String]], i: Int, j: Int) -> Bool {
    guard i <= (height - 3) && j <= (width - 3) else { return false }

    return strings[i][j] == "M"
        && strings[i + 1][j + 1] == "A"
        && strings[i + 2][j + 2] == "S"
        && strings[i + 2][j] == "M"
        && strings[i][j + 2] == "S"
}

func matchesLeft(strings: [[String]], i: Int, j: Int) -> Bool {
    guard i <= (height - 3) && (j - 2) >= 0 else { return false }

    return strings[i][j] == "M"
        && strings[i + 1][j - 1] == "A"
        && strings[i + 2][j - 2] == "S"
        && strings[i + 2][j] == "M"
        && strings[i][j - 2] == "S"
}

func matchesTop(strings: [[String]], i: Int, j: Int) -> Bool {
    guard i <= (height - 3) && j <= (width - 3) else { return false }

    return strings[i][j] == "M"
        && strings[i + 1][j + 1] == "A"
        && strings[i + 2][j + 2] == "S"
        && strings[i + 2][j] == "S"
        && strings[i][j + 2] == "M"
}

func matchesBottom(strings: [[String]], i: Int, j: Int) -> Bool {
    guard i - 2 >= 0 && j <= (width - 3) else { return false }

    return strings[i][j] == "M"
        && strings[i - 1][j + 1] == "A"
        && strings[i - 2][j + 2] == "S"
        && strings[i - 2][j] == "S"
        && strings[i][j + 2] == "M"
}


var result2 = 0

for i in 0..<strings.count {
    for j in 0..<strings[i].count {
        if strings[i][j] == "M" {
            if matchesRight(strings: strings, i: i, j: j) {
                result2 += 1
            }
            if matchesLeft(strings: strings, i: i, j: j) {
                result2 += 1
            }
            if matchesTop(strings: strings, i: i, j: j) {
                result2 += 1
            }
            if matchesBottom(strings: strings, i: i, j: j) {
                result2 += 1
            }
        }
    }
}

print(result2)
