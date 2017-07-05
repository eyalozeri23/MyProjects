//
//  MarvelAPIManager.swift
//  MarvelProject
//
//  Created by hackeru on 11/05/2017.
//  Copyright © 2017 juda. All rights reserved.
//

import UIKit
import Alamofire


class MarvelAPIManager: NSObject {
	
	static let manager = MarvelAPIManager()
	
	let privateKey = "2765be81830c05b8d3b35be6f3a793d9ca1c3f60"
	let publicKey = "fa9c824c867a496c0110d0903b2eaf7e"
	
	let baseURL = "http://gateway.marvel.com/v1/"
	
	func baseParams() -> [String:Any]{
		let ts = Int(Date().timeIntervalSince1970)
		
		let strForHash = "\(ts)"+privateKey+publicKey
		
		let params : [String:Any] = [
			"ts":ts,
			"apikey" : publicKey,
			"hash" : strForHash.md5HexString
		]
		
		return params
	}

	
	func getComics( by id : String, callback : @escaping ([MarvelComics], String?) ->Void){
		
		self.marvelRequest(with: "public/characters/" + id + "/comics", params: [:]) { (json, error) in
			guard let json = json else{
				callback([],error?.localizedDescription)
				return
			}
			
			
			guard let data = json["data"] as? [String:Any],
			let dictArray = data["results"] as? [[String:Any]]
			else{
				let msg = json["Error"] as? String
				callback([],msg)
				return
			}
			
			var finalArray : [MarvelComics] = []
			
			for dict in dictArray{
				if let obj = MarvelComics(dict){
					finalArray.append(obj)
					
				}
			}
			
			callback(finalArray, json["totalResults"] as? String)
			
		}
	}
	
	func Charcter(starting : String, callback : @escaping ([MarvelCharacter],String?) -> Void) {
		
		self.marvelRequest(with: "public/characters", params: ["nameStartsWith":starting]) { (json, error) in
			guard let json = json else{
				callback([],error?.localizedDescription)
				return
			}
			
			
			guard let dictArray = json["Search"] as? [[String:Any]] else{
				let msg = json["Error"] as? String
				callback([],msg)
				return
			}
			
			var finalArray : [MarvelCharacter] = []
			
			for dict in dictArray{
				if let obj = MarvelCharacter(dict){
					finalArray.append(obj)
				}
			}
			
			callback(finalArray, json["totalResults"] as? String)
			
		}
		
	}
	
	func marvelRequest(with suffix : String, params : [String:Any]?, completion : @escaping (_ json : [String:Any]?, _ error : Error?) -> Void){
		
		let url = baseURL + suffix
		
		var bigParams = baseParams()
		if let params = params{
			bigParams.update(other: params)
			
		}
		
		Alamofire.request(url, method: .get, parameters: bigParams).responseJSON { (res) in
			guard let json = res.result.value as? [String:Any] else{
				completion(nil, res.result.error)
				return
			}
			
			
			completion(json,nil)
		}
		
	}
    
    func getDetails(of id : String, callback : @escaping (MarvelCharacter?,String?)->Void)                                                                                               {
        
        Alamofire.request(self.baseURL, method: .get, parameters: ["id":id]).responseJSON { (response) in
            
            guard let JSON = response.result.value as? [String:Any] else{
                callback(nil,response.result.error?.localizedDescription)
                return
            }
            
            guard let str = JSON["Response"] as? String, str == "True" else{
                let msg = JSON["Error"] as? String
                callback(nil,msg)
                return
            }
            
            let obj = MarvelCharacter(JSON)
            
            callback(obj,nil)
            
        
        }
    }
    
	
	func search(term : String, callback : @escaping ([MarvelCharacter],String?)->Void){
		let param: [String : Any] = [
			"nameStartsWith" : term
		]
		
		self.marvelRequest(with: "public/characters", params: param) { (json, error) in
			guard let json = json else{
				callback([],error?.localizedDescription)
				return
			}
			
			
			guard let data = json["data"] as? [String:Any],
			let results = data["results"] as? [[String:Any]]
			else{
				let msg = json["status"] as? String
				callback([],msg)
				return
			}
			
			var finalArray : [MarvelCharacter] = []
			
			for dict in results{
				if let obj = MarvelCharacter(dict){
					finalArray.append(obj)
				}
			}
			
			callback(finalArray, (json["total"] as? Int)?.description)
            
                
           }
			
		}
	
		
	
    }


  
