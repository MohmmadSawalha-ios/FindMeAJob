//
//  JobCell.swift
//  JobFinder.MSawalha
//
//  Created by apple on 3/30/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Kingfisher
class JobCell: UITableViewCell {

    @IBOutlet weak private var lblPostDate: UILabel!
    @IBOutlet weak private var lblCompanyName: UILabel!
    @IBOutlet weak private var lblJobTitle: UILabel!
    @IBOutlet weak private var lblLocation: UILabel!
    @IBOutlet weak private var logoView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        logoView.contentMode = .scaleAspectFit
        logoView.clipsToBounds = true
        
        lblPostDate.adjustsFontSizeToFitWidth = true
        lblCompanyName.adjustsFontSizeToFitWidth = true
        lblJobTitle.adjustsFontSizeToFitWidth = true
        lblLocation.adjustsFontSizeToFitWidth = true
        // Initialization code
    }

    override func prepareForReuse() {
        lblPostDate.text = String()
        lblCompanyName.text = String()
        lblJobTitle.text = String()
        lblLocation.text = String()
        logoView.image = UIImage(named: "DefaultPlaceHolder")
        super.prepareForReuse()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func configure(with job: ConfigurableJob) {
        lblPostDate.text = (job.postDate ?? "Date Not Found").toDate(using: .DDMMYYSlashed)
        lblCompanyName.text = job.companyName ?? ""
        lblJobTitle.text = job.jobTitle ?? ""
        lblLocation.text = job.location ?? ""
        if let url = URL(string: job.logo ?? "") { // this could be the placeholder URL, but for now its handled locally.
            logoView.kf.setImage(with: url)
        } else  {
            logoView.image = UIImage(named: "DefaultPlaceHolder")
        }
    }
}
