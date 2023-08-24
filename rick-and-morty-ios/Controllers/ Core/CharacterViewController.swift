//
//  ChatacterViewController.swift
//  rick-and-morty-ios
//
//  Created by Montserrat Medina on 2023-08-23.
//

import UIKit
import Alamofire
import Kingfisher

class CharacterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    
    //Every time is set this list (fetch specific url) append the result to the complete list of cells
    var charactersResponse : [RMCharacter] = []{
        didSet{
            for character in charactersResponse {
                let viewModel = RMCharacterTableViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImage: character.image,
                    characterSpecie: character.species)
                cellViewModels.append(viewModel)
            }
        }
    }
    
    //Prevent create every time using system power
    var cellViewModels: [RMCharacterTableViewCellViewModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Spinner loading
        spinnerIndicator.startAnimating()
        
        //Set the delegate methods, etc..
        setUpTableView()
        
        fetchCharacters()
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

//MARK: - Tableview design methods
extension CharacterViewController {
    
    private func setUpTableView(){
        ///Hide table view and opacity 0
        tableView.isHidden = true
        tableView.alpha = 0
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        //Remove the margin in the left side of cells
//        self.tableView.contentInset = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0);
    }
}


// MARK: - Tableview Delegate Methods
extension CharacterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellViewModels.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        //Obtener la informacion del array
        let characterViewModel = cellViewModels[indexPath.row]
        
        // Fill the cell fields with the data
        cell.fillFields(with: characterViewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

// MARK: - API Fetch
extension CharacterViewController {
    func fetchCharacters() {
        
        //Get the url
        guard let urlRequest = APIRequest.listAllCharactersURL else {
            print("Failed to get url for request")
            return
        }
        
        // Make the request with Alamofire
        AF.request(urlRequest)
            .validate()
            .responseDecodable(of: ApiGetAllCharactersResponse.self) {
                // Weak self prevents closures from causing memory leaks in app
                [weak self] (response) in
                
                switch response.result {
                case .success(let model):
                    
                    //Get the results and info from response
                    let results = model.results
                    let info = model.info
                    
                    self?.charactersResponse = results
                    
                    // Reload the data and show the tableView
                    self?.didLoadInicialCharacters()
                    
                case .failure(let error):
                    print("Error fetching characters: \(error)")
                }
                
            }
    }
    
    /// Function that reloads the data in the tableView, stop and hide loading spinner and show tableView
    func didLoadInicialCharacters(){
        self.spinnerIndicator.stopAnimating()
        self.tableView.isHidden = false
        
        // Update tableView when has the data
        self.tableView.reloadData() //Initial Fetch
        
        // Animate when show tableview
        UIView.animate(withDuration: 0.4) {
            self.tableView.alpha = 1
        }
    }
    
}
