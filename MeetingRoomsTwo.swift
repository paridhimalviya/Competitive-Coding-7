//
//  MeetingRoomsTwo.swift
//  DSA-Practice
//
//  Created by Paridhi Malviya on 2/9/26.
//

class MeetingRoomTwo {
    
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

        func peek() -> T? {
            return elements.first
        }

        func enqueue(_ value: T) {
            elements.append(value)
            heapifyUp(from: elements.count - 1)
        }

        func heapifyUp(from index: Int) {
            var childIndex = index

            var parentIndex = (childIndex - 1) / 2
            while(childIndex > 0 && sort(elements[childIndex], elements[parentIndex])) {
                //swap
                elements.swapAt(childIndex, parentIndex)
                childIndex = parentIndex
                parentIndex = (childIndex - 1) / 2
            }
        }

        func dequeue() -> T? {
            if (elements.isEmpty) {
                return nil
            }

            elements.swapAt(0, elements.count - 1)
            let r = elements.removeLast()
            heapifyDown(from: 0)
            return r
        }

        func heapifyDown(from index: Int) {
            var parentIndex = index
            var leftChidlIndex = 2 * parentIndex + 1

            while(leftChidlIndex < count) {

                var childIndex = leftChidlIndex
                var rightChildIndex = leftChidlIndex + 1

                if (rightChildIndex < count && sort(elements[rightChildIndex], elements[leftChidlIndex])) {
                    childIndex = rightChildIndex
                }
                if(sort(elements[parentIndex], elements[childIndex])) {
                    break
                }

                elements.swapAt(childIndex, parentIndex)
                parentIndex = childIndex
                leftChidlIndex = 2 * parentIndex + 1
            }
        }
    }

    func minMeetingRooms(_ intervals: [[Int]]) -> Int {
        guard !intervals.isEmpty else {
            return 0
        }
        let sortedIntervals = intervals.sorted(by: {(a, b) in
            return a[0] < b[0]
        })

        var pq = PriorityQueue<Int>(sort: { (a, b) in
            return a < b
        })

        for interval in sortedIntervals {
            let startTime = interval[0]
            let endTime = interval[1]

            if let earliestEnd = pq.peek() {
                if (earliestEnd <= startTime) {
                    let _ = pq.dequeue()
                }
            }
            pq.enqueue(endTime)
        }

        return pq.count
    }
}
