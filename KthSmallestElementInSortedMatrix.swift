//
//  KthSmallestElementInSortedMatrix.swift
//  DSA-Practice
//
//  Created by Paridhi Malviya on 2/9/26.
//


class Solution {
    
    class PriorityQueue<T> {
        var elements: [T] = []

        let sort: (T, T) -> Bool

        init(sort: @escaping (T, T) -> Bool) {
            self.sort = sort
        }

        var isEmpty: Bool {
            return elements.isEmpty
        }

        var count: Int {
            return elements.count
        }

        var peek: T? {
            return elements.first
        }

        func enqueue(_ value: T) {
            elements.append(value)
            heapifyUp(from: elements.count - 1)
        }

        func heapifyUp(from index: Int) {
            var childIndex = index
            var parentIndex = (childIndex - 1) / 2

            while (childIndex > 0 && sort(elements[childIndex], elements[parentIndex])) {
                elements.swapAt(childIndex, parentIndex)
                childIndex = parentIndex
                parentIndex = (childIndex - 1) / 2
            }
        }

        func dequeue() -> T? {
            elements.swapAt(0, elements.count - 1)
            let r = elements.removeLast()
            heapifyDown(from: 0)
            return r
        }

        func heapifyDown(from index: Int) {
            var parentIndex = index
            var leftChildIndex = (2 * parentIndex) + 1
            while (leftChildIndex < count) {

                var childIndex = leftChildIndex
                var rightChildIndex = leftChildIndex + 1

                if (rightChildIndex < count && sort(elements[rightChildIndex], elements[leftChildIndex])) {
                    childIndex = rightChildIndex
                }

                if (sort(elements[parentIndex], elements[childIndex])) {
                    break
                }

                elements.swapAt(childIndex, parentIndex)
                parentIndex = childIndex
                leftChildIndex = 2 * parentIndex + 1
            }
        }
    }

    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        
        var pq = PriorityQueue<Int>(sort: >)

        let m = matrix.count
        let n = matrix[0].count

        for i in 0..<m {
            for j in 0..<n {
                pq.enqueue(matrix[i][j])
                if (pq.count > k) {
                    let _ = pq.dequeue()
                }
            }
        }
        return pq.peek!
    }
}
