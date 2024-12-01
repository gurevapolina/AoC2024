import UIKit

var input = 
"""
18102   93258
34171   50404
48236   60718
"""

let strings = input.split(separator: "\n")

// PART 1

var array1: [Int] = []
var array2: [Int] = []

for string in strings {
    let split = string.split(separator: " ", omittingEmptySubsequences: true).map({ Int(String($0)) })
    array1.append(split[0] ?? 0)
    array2.append(split[1] ?? 0)
}

array1 = array1.sorted(by: <)
array2 = array2.sorted(by: <)

var result1 = 0

for index in 0..<array1.count {
    result1 += abs(array1[index] - array2[index])
}

print(result1)

// PART 2

var result2 = 0

for element in array1 {
    result2 += array2.filter({ $0 == element }).count * element
}

print(result2)
