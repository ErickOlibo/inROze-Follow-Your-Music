//
//  EventTableViewCell.swift
//  InRoZe
//
//  Created by Erick Olibo on 22/09/2017.
//  Copyright © 2017 Erick Olibo. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell
{
    @IBOutlet weak var cellView: UIView!

    // outlets to the UI components in the custom UITableViewCell
    @IBOutlet weak var locationCover: UIImageView! {
        didSet {
            locationCover.layer.masksToBounds = true
            locationCover.layer.borderWidth = 0.5
            locationCover.layer.borderColor = UIColor.black.cgColor
            locationCover.layer.cornerRadius = locationCover.bounds.width / 2
        }
    }
    @IBOutlet weak var eventCover: UIImageView! {
        didSet {
            eventCover.layer.masksToBounds = true
            eventCover.layer.borderWidth = 0.5
            eventCover.layer.borderColor = UIColor.black.cgColor
            eventCover.layer.cornerRadius = 10
        }
    }
    
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventTimeLocation: UILabel!
    
    // public API of this TableViewCell subclass
    var event: Event? { didSet { updateUI() } }
    
    
    
    
    private func updateUI() {
        print("Cell View Size: \(cellView.bounds.size)")
        //let performersCount = event?.performers?.count ?? 0
        //adjustCellHeight(hasDJs: performersCount > 0)
        print("Event cell is on updateUI")
    }
    
//    private func adjustCellHeight(hasDJs: Bool) {
//        let offsetFromEventCoverBottom: CGFloat = 10
//        let offsetFromDJsListView = offsetFromEventCoverBottom
//        let bottomEventCover = eventCover.bounds.size.height * 0.5 + eventCover.center.y
//        let heightForDJsListView: CGFloat = 50
//        cellView.bounds.size.height = bottomEventCover + offsetFromEventCoverBottom
//        if (hasDJs) {
//            cellView.bounds.size.height += heightForDJsListView + offsetFromDJsListView
//            print("hasDJs - > Size Cell: \(cellView.bounds.size)")
//        } else {
//            print("NO DJ - > Size Cell: \(cellView.bounds.size)")
//        }
//    }
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
 */

}
