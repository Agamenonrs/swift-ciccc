//
//  CheapestFlightsWithinKStops.swift
//  ShortestPahAssignment
//
//  Created by Agamenon Rocha Dos Santos on 08/08/20.
//  Copyright © 2020 Agamenon. All rights reserved.
//

import Foundation

func findCheapestPrice(_ n: Int, _ flights: [[Int]], _ src: Int, _ dst: Int, _ K: Int) -> Int {
    
    var adj = [[Edge]](repeating: [], count: n)
    for flight in flights{
        adj[flight[0]].append(Edge(v: flight[1], w: flight[2], stop: 0))
    }
    var dist = [Int](repeating: Int.max, count: n)
    dist[src] = 0
    var pq = IndexPriorityQueue<Edge>(<)
    for edge in adj[src] {
        pq.enqueue(Edge(v: edge.v, w:edge.w, stop: 0))
    }
    var count = -1
    var result = Int.max
    //var x: [[Int]] = []
    while let edge = pq.dequeue(){
       
       if edge.v == dst{
        //print(edge)
        if edge.stop <= K {
                //x.append([count,edge.w])
                if edge.w < result{
                    result = edge.w
                }
            
            }
            
        }
        
        if dist[edge.v] > edge.w {
            count += 1
            dist[edge.v] = edge.w
            //edge.addStop()
            for e in adj[edge.v]{
                pq.enqueue(Edge(v: e.v, w: e.w + edge.w ,stop: edge.stop + 1))
            }
        }
    }
    //print(x)
    return  result < Int.max ? result : -1
    
}

struct Edge {
    var v: Int
    var w: Int
    var stop: Int = 0
}
extension Edge : Comparable {
    static func <(lhs: Edge, rhs: Edge) -> Bool {
        return lhs.w < rhs.w
    }
}
extension Edge : Hashable {}

public struct IndexPriorityQueue<Key: Comparable & Hashable> {
  /// the array that stores the heap's nodes
  private(set) var elements = [Key]()
  /// determines whether this is a max-heap(>) or min-heap(<)
  private var order: (Key, Key) -> Bool
  /// dictionary from elements to its heap position(index) in the `elements` array
  private var indices = [Key: Int]()
  
  /// Returns true if this priority queue is empty
  public var isEmpty: Bool {
    return elements.isEmpty
  }
  
  /// Returns the number of keys on this priority queue.
  public var count: Int {
    return elements.count
  }
  
  /// Returns the min or max key O(1)
  public var peek: Key? {
    return elements.first
  }
  
  /// Initializes an empty indexed priority queue with indices
  /// - Parameter order: order of priority queue (`min <` or `max >`)
  public init(_ order: @escaping (Key, Key) -> Bool) {
    self.order = order
  }
  
  /// Returns the index of the given key element. (amortized constant time **O(1)**)
  /// - Parameter key: key element
  /// - Returns: the index of the given key element
  public func index(of key: Key) -> Int? {
    return indices[key]
  }
  
  /// Is `key` on this priority queue? **O(1)**
  /// - Parameter key: key element
  /// - Returns: `true` if key exists on this priority queue; `false` otherwise.
  public func contains(key: Key) -> Bool {
    return indices[key] != nil
  }
  
  /// Enqueue key element on this priority queue. **O (log N)**
  /// - Parameter key: key element
  public mutating func enqueue(_ key: Key) {
    guard !contains(key: key) else { return }
    elements.append(key)
    indices[key] = elements.count - 1
    siftUp(from: elements.count - 1)
  }
  
  /// Dequeue the root node on this priority queue. **O(log N)**
  /// - Returns: the root node if the priority queue is not empty
  @discardableResult
  public mutating func dequeue() -> Key? {
    if isEmpty { return nil }
    let peek = self.peek!
    swapAt(0, count - 1)
    elements.remove(at: count - 1)
    indices[peek] = nil
    siftDown(from: 0)
    return peek
  }
  
  /// Update the old key to the new key value. **O(log N)**
  /// - Parameters:
  ///   - oldKey: old key
  ///   - newKey: new key
  public mutating func update(oldKey: Key, to newKey: Key) {
    guard let index = indices[oldKey] else { return }
    elements[index] = newKey
    siftDown(from: index)
    siftUp(from: index)
  }
  
  /// Delete the key at index `i` in this priority queue. **O(log N)**
  /// - Parameter i: index of the key to delete
  public mutating func delete(at i: Int) {
    swapAt(i, count - 1)
    elements.remove(at: count - 1)
    indices[elements[i]] = nil
    siftUp(from: i)
    siftDown(from: i)
  }
  
  /**
   Private helper methods
   */
  private mutating func siftUp(from i: Int) {
    var i = i
    while i > 0 && order(elements[parent(of: i)], elements[i]) {
      swapAt(parent(of: i), i)
      i = parent(of: i)
    }
  }
  
  private mutating func siftDown(from i: Int) {
    var i = i
    while left(of: i) < count {
      var j = left(of: i)
      if j < count - 1 && order(elements[j], elements[j + 1]) {
        j += 1
      }
      if !order(elements[i], elements[j]) { break }
      swapAt(i, j)
      i = j
    }
  }
  
  private mutating func swapAt(_ i: Int, _ j: Int) {
    elements.swapAt(i, j)
    indices[elements[i]] = i
    indices[elements[j]] = j
  }
  
  @inline(__always) private func parent(of index: Int) -> Int {
    return (index - 1) / 2
  }
  
  @inline(__always) private func left(of index: Int) -> Int {
    return 2 * index + 1
  }
  
  @inline(__always) private func right(of index: Int) -> Int {
    return 2 * index + 2
  }
}

