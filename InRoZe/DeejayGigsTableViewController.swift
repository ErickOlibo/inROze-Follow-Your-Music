//
//  DeejayGigsTableViewController.swift
//  InRoZe
//
//  Created by Erick Olibo on 27/09/2017.
//  Copyright © 2017 Erick Olibo. All rights reserved.
//

import UIKit
import CoreData

class DeejayGigsTableViewController: UITableViewController {
    
    // Core Data model container and context
    var container: NSPersistentContainer? = AppDelegate.appDelegate.persistentContainer
    
    // outlets
    @IBOutlet weak var tableHeaderView: UIView!
    //@IBOutlet weak var upcomingGigsView: UIView!
    //@IBOutlet weak var upcomingGigsLabel: UILabel!
    
    @IBOutlet weak var djProfileImage: UIImageView! { didSet { updateProfileImage() } }
    @IBOutlet weak var djProfileView: UIView! { didSet { updateProfileView() } }
    
    @IBOutlet weak var deejayName: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var gigsMixes: UILabel!
    
    @IBAction func touchedFollow(_ sender: UIButton) {
        pressedFollowed()
    }
    
    
    
    // properties
    let followedRightButton = UIBarButtonItem()
    var artist: Artist? { didSet { updateUI() } }

    private var gigsList: [Event]?
    private var mixesList: [Mixtape]?
    //private var gigMixArr: [[Event]?, [Mixtape]?]

    // ** View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        // navigation bar see Extension below
        navigationController?.delegate = self
        self.navigationController?.navigationBar.tintColor = Colors.logoRed
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: (UIImage(named: "2_Follows")?.withRenderingMode(.alwaysTemplate))!, style: .plain, target: self, action: #selector(pressedFollowed))
        //upcomingGigsView.backgroundColor = Colors.logoRed
        setDeejayImage()
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // set the status and color of rightButton
        updateFollowedButton()
        updateDJInfo()
        updateGigsMixesCount()
        //setDeejayImage()
    }
    
    // ** Methods
    private func updateGigsMixesCount() {
        // count from the Core data the number of gigs and mixtapes by this DJ
        // the format should be 12Gs / 61Ms
        //guard let gigs = artist?.gigs?.count else { return }
        //guard let mixes = artist?.mixes?.count else { return }

        //gigsMixes.text = "\(gigs)Gs / \(mixes)Ms"
        gigsMixes.text = "\(gigsList?.count ?? 0)Gs / \(mixesList?.count ?? 0)Ms"


    }
    
    
    private func setDeejayImage() {
        guard let dj = artist else { return }
        guard let picURL = preferedProfilePictureURL(for: dj) else { return }
        djProfileImage.kf.setImage(with: URL(string: picURL), options: [.backgroundDecode])
        
    }
    
    private func updateProfileImage () {
        djProfileImage.layer.masksToBounds = true
        djProfileImage.layer.cornerRadius = 25.0
        djProfileImage.layer.borderColor = UIColor.gray.cgColor
        djProfileImage.layer.borderWidth = 0.333
    }
    
    private func updateProfileView () {
        djProfileView.backgroundColor = .white
        djProfileView.layer.masksToBounds = true
        djProfileView.layer.cornerRadius = 30.0
        djProfileView.layer.borderColor = Colors.logoRed.cgColor
        djProfileView.layer.borderWidth = 2.0
    }
    
    
    @objc private func pressedFollowed() {
        if let context = container?.viewContext {
            context.perform {
                if let artistState = Artist.currentIsFollowedState(for: self.artist!.id!, in: context) {
                    self.artist!.isFollowed = !artistState
                    self.updateFollowedButton()
                    self.changeState()
                }
            }
        } 
    }
    
    private func changeState() {
        // change state of isFollowed
        container?.performBackgroundTask{ context in
            let success = Artist.changeIsFollowed(for: self.artist!.id!, in: context)
            if (success) {
                //print("[DeejayGigsTableViewController in pressedFollowed] - isFollowed CHANGED")
            } else {
                print("[pressedFollowed] - FAILED")
            }
        }
    }
    

    
    private func updateDJInfo() {
        guard let artistName = artist?.name else { return }
        guard let artistCountry = artist?.country else { return }
        deejayName.text = artistName
        countryName.text = artistCountry
    }
    
    
    private func updateFollowedButton() {
        // Update profile
        if (artist!.isFollowed) {
            navigationItem.rightBarButtonItem?.image = (UIImage(named: "2_FollowsFilled")?.withRenderingMode(.alwaysTemplate))!
            navigationItem.rightBarButtonItem?.tintColor = Colors.logoRed
            followButton.setTitle("Followed", for: .normal)
            followButton.backgroundColor = Colors.logoRed
            followButton.setTitleColor(.white, for: .normal)
            followButton.layer.borderColor = Colors.logoRed.cgColor
        } else {
            navigationItem.rightBarButtonItem?.image = (UIImage(named: "2_Follows")?.withRenderingMode(.alwaysTemplate))!
            navigationItem.rightBarButtonItem?.tintColor = .lightGray
            followButton.setTitle("Follow", for: .normal)
            followButton.backgroundColor = .clear
            followButton.setTitleColor(.gray, for: .normal)
            followButton.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    private func updateUI() {
        if let context = container?.viewContext {
            context.perform {
                self.mixesList = Artist.findPerformingMixtapes(for: self.artist!, in: context)
                self.gigsList = Artist.findPerformingEvents(for: self.artist!, in: context)
                if let currentState = Artist.currentIsFollowedState(for: self.artist!.id!, in: context) {
                    self.artist!.isFollowed = currentState
                }
                self.tableView.reloadData()
                self.gigsMixes.text = "\(self.gigsList?.count ?? 0)Gs / \(self.mixesList?.count ?? 0)Ms"
            }
        }
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == 0) {
            return gigsList?.count ?? 0
        } else {
            return mixesList?.count ?? 0
        }
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: DeejayGigsCell.identifier, for: indexPath) as! DeejayGigsCell
            cell.tag = indexPath.row
            cell.selectionStyle = .none
            if let event = gigsList?[indexPath.row]  {
                cell.event = event
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DeejayMixesCell.identifier, for: indexPath) as! DeejayMixesCell
            cell.tag = indexPath.row
            cell.selectionStyle = .none
            if let mixtape = mixesList?[indexPath.row] {
                cell.mixtape = mixtape
            }
            return cell
        }
        
    }
    
    // Views for section
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Colors.logoRed
        var text = ""
        let textLabel = UILabel()
        let attributeOne =  [ NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 18.0)!, NSAttributedStringKey.foregroundColor: UIColor.white ]
        
        if (section == 0) {
            text = "GIGS"
        } else {
            text = "MIXTAPES"
        }
        let attrText = NSAttributedString(string: text, attributes: attributeOne)
        textLabel.attributedText = attrText
        textLabel.frame = CGRect(x: 0, y: 0, width: CellSize.phoneSizeWidth, height: 30)
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
        
        if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
            return view
        } else {
            textLabel.text = nil
            view.backgroundColor = .lightGray
            return view
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
            return 30.0
        } else {
            return 0.333
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (indexPath.section == 0) ?  60.0 :  120.0
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Event in Deejay list nr: [\(indexPath.row)]")
    }

    // List of segue to be done here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Gig Cell To Info") {
            guard let gigCell = sender as? DeejayGigsCell else { return }
            guard let destination = segue.destination as? EventInfoViewController else { return }
            destination.event = gigCell.event
            destination.navigationItem.title = gigCell.event?.location?.name ?? ""
        }
    }

}


extension DeejayGigsTableViewController:  UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
//        if ((viewController as? EventsViewController) != nil) {
//            print("back to Events")
//        }
//    }
    
}


