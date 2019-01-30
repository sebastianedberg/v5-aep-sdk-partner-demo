//
//  CaasViewController.swift
//  v5mobile
//
//  Created by max on 2018-10-05.
//  Copyright © 2018 max. All rights reserved.
//

import Foundation
import UIKit
import MapKit

import ACPCore
import ACPAnalytics

class CaasViewController: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var serverTextField: UITextField!
    @IBOutlet weak var pathTextField: UITextField!
    @IBOutlet weak var connectBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    
    /**
     * Array of CaasLocation
     */
    var locations = [CaasLocation]()
    /**
     * Default server url
     */
    var serverUrl = "http://localhost:4503"
    /**
     * Default endpoint path
     */
    var path = "/we-retail/api/locations.model.json"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        /**
         * Send default state view for this view.
         */
        ACPCore.trackState("CaasView", data: ["category": "caas"])
        
        self.setCaasEndpoint()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    /**
     * @brief Load the caas endpoint from the user defaults
     */
    private func setCaasEndpoint() -> Void {
        let defaults = UserDefaults.standard
        if let caasEndpointServer = defaults.string(forKey: "caasEndpointServer") {
            serverTextField.text = caasEndpointServer
        }
        if let caasEndpointPath = defaults.string(forKey: "caasEndpointPath") {
            pathTextField.text = caasEndpointPath
        }
    }
    
    /**
     * @brief Persist the caas endpoint from the input fields.
     * @return url String CaasEndpoint
     */
    private func saveCaasEndpoint() -> String {
        
        self.serverUrl = serverTextField.text ?? self.serverUrl
        let path = pathTextField.text ?? self.path
        let url =  self.serverUrl + path
        
        let defaults = UserDefaults.standard
        defaults.set(url, forKey: "caasEndpoint")
        defaults.set(self.serverUrl, forKey: "caasEndpointServer")
        defaults.set(path, forKey: "caasEndpointPath")
        
        return url
    }
    /**
     * @brief Load all location content fragments from the given JSON endpoint
        and render the result in the tableView.
     */
    private func getLocations() {
        
        let url = self.saveCaasEndpoint()
        
        print("CaaS endpoint: \(url)")
        
        
        CaasLocation.callAemCaasService(with: url) { locations in
            self.locations = locations
            DispatchQueue.main.async { [unowned self] in
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func callCaas(_ sender: Any) {
        /**
         * Send default action.
         */
        ACPCore.trackAction("CaasAction", data: ["action": "locations"])
        self.getLocations()
    }
    /**
     * @return Amount of location
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    /**
     * @brief Render the tableView header
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "AEM Response"
    }
    /**
     * @brief Render the location title
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        cell.textLabel?.text = self.locations[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /**
         * Map annotation
         */
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        /**
         * Selected location row item
         */
        let fd: CaasLocation = self.locations[indexPath.row]
        /**
         * LocationCoordinate
         */
        let cllc: CLLocationCoordinate2D = CLLocationCoordinate2DMake(fd.coordinates.latitude, fd.coordinates.longitude)
        myAnnotation.coordinate = cllc
        myAnnotation.title = "Current location"
        self.mapView.addAnnotation(myAnnotation)
        self.mapView.setCenter(cllc, animated: true)
        /**
         * Thumbnail url
         */
        let imageUrl = self.serverUrl + fd.thumbnailUrl
        let url = URL(string: imageUrl)
        /**
         * Load the actual image
         */
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url!) {
                DispatchQueue.main.async { [unowned self] in
                    self.imageView.image = UIImage(data: data)
                }
            } else {
                print("Image does not exist")
            }
        }
        /**
         * Send location selection action and selected item as context data loc_sel
         */
        ACPCore.trackAction("LocationSelection", data: ["loc_sel": fd.title])
    }
    
}
