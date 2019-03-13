//
//  FilterView.swift
//  KnightsMaps
//
//  Created by Michael Aoun on 3/10/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import UIKit
protocol FilterViewDelegate {
    func complete(buildingName: String)
}

class FilterView: UIViewController {

    @IBOutlet var searchBarView: UISearchBar!
    @IBOutlet var tbView: UITableView!
    
    var buildingArray: [KMBuilding]!

    var searching = false
    var filteredBuildings = [KMBuilding]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func itemSelected(bName: String) {
        print("Selected the cell is: \(bName)")
        delegate?.complete(buildingName: bName)
        dismiss(animated: true) {
            // when the view has completely dismissed
        }
    }
    
    //This is called when you tap on a specific row in the search
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            itemSelected(bName: filteredBuildings[indexPath.row].name)
        } else {
            itemSelected(bName: buildingArray[indexPath.row].name)

        }
    }
    
    var delegate: FilterViewDelegate?
    
}   //end of FilterView

extension FilterView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
           return filteredBuildings.count
        } else {
            return buildingArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FilterViewTableCell
        if searching {
            cell?.textLabel?.text = filteredBuildings[indexPath.row].name
            cell?.detailTextLabel?.text = filteredBuildings[indexPath.row].acronym
        } else {
            cell?.textLabel?.text = buildingArray[indexPath.row].name
            cell?.detailTextLabel?.text = buildingArray[indexPath.row].acronym
        }
        return cell!
    }
    
}

extension FilterView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        filteredBuildings = buildingArray.filter({$0.name.lowercased().prefix(searchText.count) == searchText.lowercased() || $0.acronym.lowercased().prefix(searchText.count) == searchText.lowercased()})
        
        tbView.reloadData()
    }
    
}

//test building array
/*
 let buildingArr2 = [KMBuilding(name: "Engineering 1", acronym: "ENG1", latitude: 100, longitude: 100, info: "blah", type:"building"),
 KMBuilding(name: "Engineering 2", acronym: "ENG2", latitude: 100, longitude: 100, info: "blah", type:"building"),
 KMBuilding(name: "Business Administration 1", acronym: "BA1", latitude: 100, longitude: 100, info: "blah", type:"building"),
 KMBuilding(name: "Classroom Building 1", acronym: "CB1", latitude: 100, longitude: 100, info: "blah", type:"building"),
 KMBuilding(name: "Classroom Building 2", acronym: "CB2", latitude: 100, longitude: 100, info: "blah", type:"building"),
 KMBuilding(name: "Harrison Engineering Center", acronym: "HEC", latitude: 100, longitude: 100, info: "blah", type:"building"),
 KMBuilding(name: "Visual Arts Building", acronym: "VAB", latitude: 100, longitude: 100, info: "blah", type:"building")]
 */
