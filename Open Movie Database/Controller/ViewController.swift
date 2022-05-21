//
//  ViewController.swift
//  Open Movie Database
//
//  Created by Chandresh Kachariya on 03/06/21.
//

import UIKit
import SDWebImage

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    /***************UISearchBar*****************/
    @IBOutlet weak var searchBar: UISearchBar!
    
    /***************UITableView*****************/
    @IBOutlet weak var tblDisplayIMDB: UITableView!
    
    /***************Objects*****************/
    var viewModel = SearchViewModel()
    var searchString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        initSetup()
    }
    
    func initSetup() {
        
        searchBar.delegate = self
        
        tblDisplayIMDB.estimatedRowHeight = 44
        tblDisplayIMDB.dataSource = self
        tblDisplayIMDB.delegate = self
        tblDisplayIMDB.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)

        tblDisplayIMDB.tableFooterView = UIView.init()
    }

    //MARK:- API
    func requestSearchResults() {
        viewModel.fetchSearchResults(searchString, apikey: "30639e02", page: 1) { status in
            switch status {
            case Key.API.status.success.rawValue:
                DispatchQueue.main.async { [self] in
                    print("Success")
                    print("Total search:- \(viewModel.searchResultList?.search?.count ?? 0)")
                    
                    tblDisplayIMDB.reloadData()
                }
            case Key.API.status.unauthorized.rawValue:
                print("Unauthorized")
            default:
                print(status)
            }
        } failure: { (error) in
            DispatchQueue.main.async {
                print("Data not found")
            }
            print(error)
        }
    }
    
    //MARK:- UISearchBar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("searchText \(searchText)")
        searchString = searchText
        requestSearchResults()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("searchText \(searchBar.text)")
        searchBar.resignFirstResponder()
    }
    
    // MARK: - UITableView
    let reuseIdentifier = "SearchResultsTVCell"

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResultList?.search?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchResultsTVCell
        
        cell.setupdata(objInfo: (viewModel.searchResultList?.search?[indexPath.row])!)
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension UIImageView {
    
    func getImage(url: String, placeholderImage:  UIImage?,
                  success:@escaping (_ _result : Any? ) -> Void,
                  failer:@escaping (_ _result : Any? ) -> Void) {
        
        self.sd_setImage(with: URL(string: url), placeholderImage:  placeholderImage, options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
            // your rest code
            if error == nil {
                self.image = image
                success(true)
            }else {
                failer(false)
            }
        })
        
    }
}
