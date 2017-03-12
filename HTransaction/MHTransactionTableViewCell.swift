//
//  MHTransactionTableViewCell.swift
//  HTransaction
//
//  Created by TUAN ANH on 3/12/17.
//  Copyright © 2017 H-Transaction. All rights reserved.
//

import UIKit

class MHTransactionTableViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var MemoLabel: UILabel!
    @IBOutlet weak var AmountLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    var hTransaction: HTransaction!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(hTransaction: HTransaction) {
        self.hTransaction = hTransaction
        
        // Set the labels and textView.
        
        self.NameLabel.text = hTransaction.hTransactionName
        self.MemoLabel.text = hTransaction.hTransactionMemo
        self.AmountLabel.text = String(hTransaction.hTransactionAmount)
        if let url = NSURL(string: hTransaction.hTransactionImage) {
            if let data = NSData(contentsOfURL: url) {
                self.ImageView.image = UIImage(data: data)
            }        
        }
        //self.ImageView.image = hTransaction.hTransactionImage
    }

}
