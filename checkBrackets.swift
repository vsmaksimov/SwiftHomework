import Foundation

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element? {
        return items.popLast()
    }

    func top() -> Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }

    func isEmpty() -> Bool {
        return items.isEmpty
    }
}

func checkBrackets(string: String) -> Int {
    var brackets: [Character: Character] = [
        "{" : "}",
        "[" : "]",
        "(" : ")"
    ]

    var stackForBrackets: Stack<Character> = Stack()
    var stackForIndex: Stack<Int> = Stack()

    for (index, value) in string.enumerated() {
        if brackets.keys.contains(value) {
            stackForBrackets.push(value)
            stackForIndex.push(index)
        }
        else if (brackets.values.contains(value)) {
            if (stackForBrackets.isEmpty() && stackForIndex.isEmpty()) {
                return index + 1
            }
            else {
                guard let top = stackForBrackets.top() else {
                    return index + 1
                 }
                if brackets[top] == value {
                    stackForBrackets.pop()
                    stackForIndex.pop()
                }
                else {
                    return index + 1
                }
            }
        }
    }

    if stackForIndex.isEmpty() {
        return -1
    }
    else {
        return stackForIndex.pop()! + 1
    }
}