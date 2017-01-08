//
//  TableViewController.swift
//  ColmeiaApp
//
//  Created by Lynneker Souza on 1/8/17.
//  Copyright © 2017 Lynneker Souza. All rights reserved.
//

import UIKit
import Parse

class TableViewController: UITableViewController, UISearchResultsUpdating {
    
    let cellIdentifier = "Cell"
    var professores: Array<Professor> = []
    var todosProfessores: Array<Professor> = []
    
    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getProfessores()
        
        // Initializing with searchResultsController set to nil means that
        // searchController will use this view controller to display the search results
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Busca de Professores"
        //searchController.searchBar.scopeButtonTitles = ["Nome","Matérias"]
        
        
        // If we are using this same view controller to present the results
        // dimming it out wouldn't make sense. Should probably only set
        // this to yes if using another controller to display the search results.
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.sizeToFit()
        tableView.tableHeaderView = searchController.searchBar
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchController.searchBar.endEditing(true)
        SCLAlertView().showInfo("Curriculo da(o) \(professores[indexPath.row].name!)", subTitle: "\(professores[indexPath.row].curriculum!)")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return professores.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TableViewCell
        // Configure the cell...
        
        cell.professor =  professores[indexPath.row]
        cell.updateLabels()

        return cell
    }
    
    func getProfessores(){
        let query = PFQuery(className:"Professores")
        query.findObjectsInBackground { (objects, error) -> Void in
            if error == nil {
                for object in objects! {
                    let newProfessor = Professor(professor: object)
                    
                    if let imagem = object["imagem"] as? PFFile {
                        imagem.getDataInBackground {(data, error) in
                            if let _ = error {
                                print(error ?? "Error on picture.")
                            } else if let data = data, let image = UIImage(data: data) {
                                newProfessor.picture =  image
                                self.professores.append(newProfessor)
                                self.todosProfessores = self.professores
                                self.tableView.reloadData()
                            }
                        }
                        
                    }
                }
                
            } else {
                print(error ?? "Erro")
            }
        }
    }
    
    func filterContentForSearchText(searchText: String, scope: Int) {
        // Filter the array using the filter method
          professores = searchText.isEmpty ? todosProfessores : professores.filter({(prof: Professor) -> Bool in
            
            var fieldToSearch: String?
            switch (scope) {
            case (0):
                fieldToSearch = prof.name
            case (1):
                fieldToSearch = prof.subject
            default:
                fieldToSearch = nil
            }
            return fieldToSearch!.lowercased().range(of: searchText.lowercased()) != nil
        })
        tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            
            professores = todosProfessores
            professores = searchText.isEmpty ? todosProfessores : professores.filter({(prof: Professor) -> Bool in
                return prof.name.lowercased().range(of: searchText.lowercased()) != nil
            })
            
            
            tableView.reloadData()
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
