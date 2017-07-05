//
//  marvelExtension.swift
//  MarvelProject
//
//  Created by hackeru on 11/05/2017.
//  Copyright © 2017 juda. All rights reserved.
//

import Foundation

extension String{
	var  md5Data : Data {
		get{
			let messageData = self.data(using:.utf8)!
			var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
			
			_ = digestData.withUnsafeMutableBytes {digestBytes in
				messageData.withUnsafeBytes {messageBytes in
					CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
				}
			}
			
			return digestData
		}
	}
	
	var md5HexString : String{
		get{
			return md5Data.map { String(format: "%02hhx", $0) }.joined()
		}
	}
}

extension Dictionary {
	mutating func update(other:Dictionary) {
		for (key,value) in other {
			self.updateValue(value, forKey:key)
		}
	}
}

