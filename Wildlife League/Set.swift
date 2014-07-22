//
//  Set.swift
//  Wildlife League
//
//  Created by allenlin on 7/8/14.
//  Copyright (c) 2014 Raccoonism. All rights reserved.
//

import Foundation

class Set<T : Hashable> : Sequence, Printable {
    var dictionary : Dictionary<T,Bool>
    
    func addElement(obj:T){
        
        dictionary[obj] = true
    }
    
    func removeElement(obj:T){
        dictionary[obj] = nil
    }
    
    func allElements () -> [T] {
        return Array(dictionary.keys)
    }
    
    func count () -> Int {
        return self.allElements().count
    }
    
    init(){
        dictionary = Dictionary<T,Bool>()
    }
    
    func generate () -> IndexingGenerator<Array<T>> {
        return allElements().generate()
    }
    
    
    func containsObject (obj:T) -> Bool{
        return dictionary[obj] == true
    }
    
    func union (set :Set) {
        for key in set.dictionary.keys {
            self.dictionary[key] = true
        }
    }
    
    func intersect (set :Set) {
        for key in self.dictionary.keys{
            if (set.dictionary[key]==nil){
                self.dictionary[key] = nil
            }
            else{
                self.dictionary[key] = true
            }
        }
    }
    
    func isIntersected (set :Set) -> Bool {
        var selfCopy = self.copy()
        selfCopy.intersect(set)
        return selfCopy.dictionary.count>0
    }
    
    subscript (index :Int) -> T? {
        get{
            return allElements()[index]
        }
    }
    
    var description :String {
        get{
            var desc = String()
            for key in dictionary.keys {
            desc += "\(key), \n"
            }
            return desc
        }
    }
    
    func copy() -> Set<T>{
        var set = Set<T>()
        set.dictionary = Dictionary()
        for key in self.dictionary.keys {
            set.dictionary[key] = true
        }
        return set
    }
}