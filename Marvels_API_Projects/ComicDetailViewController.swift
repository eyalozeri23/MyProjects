//
//  ComicDetailViewController.swift
//  MarvelProject
//
//  Created by hackeru on 18/05/2017.
//  Copyright © 2017 juda. All rights reserved.
//

import UIKit

class ComicDetailViewController: UIViewController {
	
	var item : MarvelComics?

	@IBOutlet weak var comicsText: UITextView!
	@IBOutlet weak var comicsImage: UIImageView!
    
    
    func saveComicsPhotoToGallery(){
        
        // save image to photo gallery
        UIImageWriteToSavedPhotosAlbum(self.comicsImage.image!, nil, nil, nil)
        
        let alertController = UIAlertController(title: "Alert", message: "Photo Saved", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func shareComicsDescription(){
        
        let textToShare =  self.item?.desc
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [textToShare!], applicationActivities: nil)
        let currentViewController : UIViewController = (UIApplication.shared.keyWindow?.rootViewController)!
        
        currentViewController.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: - IBAction
    
    @IBAction func sharedComicsAction(_ sender: UIBarButtonItem) {
        
        //MARK: - AlertActionSheet 
        
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        
        let saveAction = UIAlertAction(title: "Save Photo", style: .default) { (action) in
            
           self.saveComicsPhotoToGallery()
            
        }
        let shareAction = UIAlertAction(title: "Share Text", style: .default) { (action) in
            
            self.shareComicsDescription()
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        optionMenu.addAction(shareAction)
        optionMenu.addAction(saveAction)
        optionMenu.addAction(cancelAction)
        self.present(optionMenu, animated: true, completion: nil)
        
    }
    
	
    override func viewDidLoad() {
        super.viewDidLoad()
    
    
        
		navigationItem.title = item?.title
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
		
		if let urlString = item?.thumbnailComic,
			let url = URL(string: urlString){
			comicsImage.sd_setImage(with: url)
		}
		
		comicsText.text = item?.desc
        
        if item?.desc != nil{
            if (item?.desc!.isEmpty)!{
                comicsText.text = "No Details"
            }
        }
		

	
    }

	
    
}
