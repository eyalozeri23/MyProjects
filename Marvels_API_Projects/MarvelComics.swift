//
//  MarvelComics.swift
//  MarvelProject
//
//  Created by hackeru on 18/05/2017.
//  Copyright © 2017 juda. All rights reserved.
//

import UIKit

class MarvelComics: NSObject {
	
	let heroIdForComics : Int
	
	let title : String?
	let thumbnailComic : String?
	let desc : String?
	
	init?(_ dict : [String:Any]) {
		
		guard let heroIdForComics = dict["id"] as? Int else {
			return nil
		}
		
		self.heroIdForComics = heroIdForComics
		
		self.title = dict["title"] as? String
		self.desc = dict["description"] as? String
		
		if let thumbDict = dict["thumbnail"] as? [String: Any],
			let path = thumbDict["path"] as? String,
			let fileExtension = thumbDict["extension"] as? String{
			thumbnailComic = path + "." + fileExtension
			
		} else {
			self.thumbnailComic = nil
		}
		
		super.init()
		
	}
	

}
