//
//  ViewController.swift
//  rick-and-morty-ios
//
//  Created by Montserrat Medina on 2023-08-23.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var responseCharacters : ApiCharactersResponse?
    
    
    enum api : String {
        case characters = "https://rickandmortyapi.com/api/character"
        case locations = "https://rickandmortyapi.com/api/location"
        case episodes = "https://rickandmortyapi.com/api/episode"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCharacters(url: nil)
        
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: CustomTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        cleanTableSeparator()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.responseCharacters?.all.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Obtener la informacion del array
        let character = responseCharacters?.all[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        cell.nameField.text = character?.name
        cell.iconStatus.text = character?.status == "Alive" ? "🟢" : "⚪️"
        cell.statusField.text = character?.status
        cell.specieField.text = character?.species
        
        //Imagen del caracter
        let urlNoImage = "https://lppm.upnjatim.ac.id/assets/img/nophoto.png"
        let urlImage = URL(string: character?.image ?? urlNoImage)
        cell.imageField.kf.setImage(with: urlImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
   
    
}

//MARK: - Table separator design
extension ViewController {
    func cleanTableSeparator() {
        tableView.backgroundColor = .clear
    }
}

// MARK: - API Fetch
extension ViewController {
    func fetchCharacters(url : String?) {
        
        AF.request((url != nil) ? url! : api.characters.rawValue)
            .validate()
            .responseDecodable(of: ApiCharactersResponse.self) {
                (response) in
                
                switch response.result {
                case .success(let apiResponse):
                    
                    //Si no se pasa ninguna url es el inicio
                    if url == nil {
                        self.responseCharacters = apiResponse
                    }else{
                        //Seguir agregando a la lista
                        self.responseCharacters?.all.append(contentsOf: apiResponse.all)
                    }
                    
                    // Actualizar la tabla cuando tengas los datos
                    self.tableView.reloadData()
                    
                    //Volver a llamar a la funcion hasta que se obtengan todos los caracteres
                    if apiResponse.info.nextPage != nil {
                        self.fetchCharacters(url: apiResponse.info.nextPage)
                    }
                    
                case .failure(let error):
                    print("Error fetching charactes: \(error)")
                }
                
            }
    }
}


