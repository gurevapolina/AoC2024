import UIKit

var input =
"""
"""

let strings = input.split(separator: "\n")

var reports: [[Int]] = []

for string in strings {
    let split = string.split(separator: " ", omittingEmptySubsequences: true).compactMap({ Int(String($0)) })
    reports.append(split)
}

func isDecreasing(array: [Int]) -> Bool {
    var count = 0
    for index in 0..<(array.count - 1) {
        if array[index] > array[index + 1] {
            count += 1
        }
    }
    if count >= array.count - 2 {
        return true
    } else {
        return false
    }
}

func isInRange(value1: Int, value2: Int, isDecreasing: Bool) -> Bool {
    if isDecreasing {
        return value1 > value2 && (1...3).contains(value1 - value2)
    } else {
        return value1 < value2 && (1...3).contains(value2 - value1)
    }
}

func isValidArray(array: [Int]) -> Bool {
    let isDecreasing = isDecreasing(array: array)
    var valid = true

    for index in 0..<(array.count - 1) {
        if isInRange(value1: array[index], value2: array[index + 1], isDecreasing: isDecreasing) {
            continue
        } else {
            valid = false
        }
    }
    return valid
}

// PART 1

var result = 0

for report in reports {
    let valid = isValidArray(array: report)

    if valid {
        result += 1
    }
}

print(result)

// PART 2

result = 0

for report in reports {
    removeLoop: for removeAt in 0...(report.count - 1) {
        var array = report
        array.remove(at: removeAt)
        let valid = isValidArray(array: array)
        if valid {
            result += 1
            break removeLoop
        }
    }
}

print(result)
