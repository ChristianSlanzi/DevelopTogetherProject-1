//
//  RecipeBook.swift
//  RecipeBook
//
//  Created by Christian Slanzi on 09.05.21.
//

import Foundation

public class RecipeBook: NSObject {
    
    public var categories: [RecipeCategory]?
    
    public override init() {
        super.init()
        
        categories = [RecipeCategory]()
    }
    
    public func load(filePath: String?) {
        
        guard let path = filePath,
              let array = NSArray(contentsOfFile: path) as [AnyObject]? else { return }
        
        for item in array {
            guard let dictionary = item as? [String : AnyObject] else {
                continue
            }
            
            if let category = RecipeCategory(dictionary) {
                categories?.append(category)
            }
        }
    }
}
