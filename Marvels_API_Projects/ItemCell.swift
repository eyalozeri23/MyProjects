//
//  itemCellTableViewCell.swift
//  MarvelProject
//
//  Created by hackeru on 15/05/2017.
//  Copyright © 2017 juda. All rights reserved.
//

import UIKit
import SDWebImage

class ItemCell: UITableViewCell {
	
    
    @IBOutlet weak var heroImage: UIImageView!
	@IBOutlet weak var name: UILabel!
	
	func configure (with item : MarvelCharacter){
	
	let fullName = (item.name ?? "")
	name.text = fullName
        if let url = URL(string : item.thumbUrlString!){
            heroImage.sd_setImage(with: url)
		} else{
			heroImage.sd_cancelCurrentImageLoad()
			heroImage.image = nil
		}
		
		
	}
	
	
	
	
	
	
		
	
	
}
