//
//  ViewController.swift
//  MarvelProject
//
//  Created by hackeru on 11/05/2017.
//  Copyright © 2017 juda. All rights reserved.
//

import UIKit
import CCBottomRefreshControl


class MainViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate, UITableViewDelegate {
	
	var tableArray : [MarvelCharacter] = []
	var term : String = ""
	var page : Int = 1
    
    var searchController : UISearchController!
    var resultsController = UITableViewController()
	
	
	weak var refreshControl : UIRefreshControl?
	
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
        
        
        let image : UIImage = UIImage(named: "MarvelLogo.png")!
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        self.navigationItem.titleView = imageView
		
		let control = UIRefreshControl()
		control.addTarget(self, action: #selector(refresh), for: .valueChanged)
		tableView.addSubview(control)
		refreshControl = control
		
		let bControl = UIRefreshControl()
		bControl.triggerVerticalOffset = 100
		bControl.addTarget(self, action: #selector(nextPage), for: .valueChanged)
		tableView.bottomRefreshControl = bControl
        
        self.navigationController?.navigationBar.barTintColor = UIColor.red
		
       
        
	}
    
    func checkIfEmpty(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: {
        
        if self.tableArray.isEmpty {
            if self.tableArray.count == 0{
            
            let alertController = UIAlertController(title: "Alert", message: "No Results Found", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
           }
         }
        })
    
    
    }
    
	

	
	func nextPage(){
		page += 1
		getData()
		
	}
	
	func refresh(){
		page = 1
		getData()
	}
	
	func getData(){
		
		MarvelAPIManager.manager.search(term: term) { (marvels, title) in
			self.refreshControl?.endRefreshing()
			self.tableView.bottomRefreshControl?.endRefreshing()
			
			self.tableArray = marvels
			
			self.tableView.reloadData()
			
			self.navigationItem.title = title
		}
		
		
	}
    
    
    //MARK: - SearchBar Delegate
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		
		searchBar.text = ""
		searchBar.resignFirstResponder()
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		term = searchBar.text ?? ""
		page = 1
		
		getData()
		
		searchBar.resignFirstResponder()
        
        checkIfEmpty()
        
    }
        
    

	
	//MARK: - TableView Data Source
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return tableArray.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ItemCell
		
		cell.configure(with: tableArray[indexPath.row])
        
		
		
		return cell
	}
    
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
    
    
    //MARK: - Navigation
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailesSegue",
            let indexPath = tableView.indexPathForSelectedRow,
			let nextVC = segue.destination as? DetailsViewController{
			
			let obj = tableArray[indexPath.row]
            nextVC.item = obj
			
            
        }
    }
	

	

}

