//
//  MarvelCharacter.swift
//  MarvelProject
//
//  Created by hackeru on 11/05/2017.
//  Copyright © 2017 juda. All rights reserved.
//

import UIKit

class MarvelCharacter: NSObject {
    
    let heroId : Int
	
	let name : String?
	let thumbUrlString : String?
	let desc : String?

	
	init?(_ dict : [String:Any]) {
		
        guard let heroId = dict["id"] as? Int else {
            return nil
        }
        
        self.heroId = heroId
        
		self.name = dict["name"] as? String
		self.desc = dict["description"] as? String
		
		if let thumbDict = dict["thumbnail"] as? [String: Any],
			let path = thumbDict["path"] as? String,
			let fileExtension = thumbDict["extension"] as? String{
			thumbUrlString = path + "." + fileExtension
                
		} else {
			self.thumbUrlString = nil
		}
				
		super.init()
		
  }

}
