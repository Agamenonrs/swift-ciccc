//
//  LCA2.swift
//  LCAAssignment
//
//  Created by Agamenon Rocha Dos Santos on 19/07/20.
//  Copyright © 2020 Agamenon. All rights reserved.
//

import Foundation

//
//  LCA.swift
//  LCAAssignment
//
//  Created by Agamenon Rocha Dos Santos on 19/07/20.
//  Copyright © 2020 Agamenon. All rights reserved.
//

import Foundation
/*
 input
 
15
1 2
1 3
2 4
3 7
6 2
3 8
4 9
2 5
5 11
7 13
10 4
11 15
12 5
14 7
6
6 11
10 9
2 6
7 6
8 13
8 15

15
1 2
1 3
2 4
3 7
6 2
3 8
4 9
2 5
5 11
7 13
10 4
11 15
12 5
14 7
1
6 11
 

 */


func findLCA2(){
    print("begin")
    // # of vertices
    //let n = Int(readLine()!)!
    let n = 15
    // # of edges
    let m = n - 1
    
    //adjacency list
    //var adjList = [[Int]](repeating: [], count: n + 1)
    var adjList = [[], [2, 3], [1, 4, 6, 5], [1, 7, 8], [2, 9, 10], [2, 11, 12], [2], [3, 13, 14], [3], [4], [4], [5, 15], [5], [7], [7], [11]]
//    for _ in 0..<m {
//        let edge = readLine()!.split(separator: " ")
//        let u = Int(edge[0])!
//        let v = Int(edge[1])!
//        adjList[u].append(v)
//        adjList[v].append(u)
//    }
    
    //let edgesToCheck = Int(readLine()!)!
    let edgesToCheck = 1
    //var edgesToCheckList = [[[Int]](repeating: [], count: edgesToCheck)]
    let edgesToCheckList = [[6,11]]
//    for index in 0..<edgesToCheck {
//        let edge = readLine()!.split(separator: " ")
//        let u = Int(edge[0])!
//        let v = Int(edge[1])!
//        edgesToCheckList[index].append(u)
//        edgesToCheckList[index].append(v)
//    }
    print("fill the list")
    //print(adjList)
    print("")
    //print(edgesToCheckList)
    
    
    func dfs(start: Int, adjList: inout [[Int]], visited: inout [Bool], p:Int, q:Int, _ foundP: inout Bool, _ foundQ: inout Bool,
             _ arrayP: inout [Int], _ arrayQ: inout [Int]){
        visited[start] = true
        for v in adjList[start] {
            if !visited[v] && !( foundP && foundQ)  {
                if v == p {
                    foundP = true
                }
                if v == q {
                    foundQ = true
                }
                dfs(start: v, adjList: &adjList, visited: &visited, p:p,q:q,&foundP,&foundQ, &arrayP,&arrayQ)
                if foundP {
                    arrayP.append(start)
                }
                if foundQ {
                    arrayQ.append(start)
                }
                if foundP && foundQ  {
                    print(start)
                }
            }
        }
    }
    
    var visited = [Bool](repeating: false, count: n + 1)
    var foundP = false
    var foundQ = false
    var arrayP: [Int] = []
    var arrayQ: [Int] = []
    dfs(start: 1, adjList: &adjList, visited: &visited,p: 6,q: 11, &foundP, &foundQ, &arrayP, &arrayQ)
    
    print(arrayP)
    print(arrayQ)
        
}




