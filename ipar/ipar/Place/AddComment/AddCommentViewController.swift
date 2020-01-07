//
//  AddCommentViewController.swift
//  ipar
//
//  Created by Vitaly on 07/01/2020.
//  Copyright © 2020 banda. All rights reserved.
//

import UIKit

protocol AddCommentDelegate: class {
    func commentAdded(_ comment: String)
    func commentCancelled()
}

class AddCommentViewController: UIViewController {

    @IBOutlet weak var commentTextField: UITextView!
    
    
    weak var delegate: AddCommentDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .overCurrentContext
        // Do any additional setup after loading the view.
    }

    @IBAction func addCommentButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.commentAdded(commentTextField.text)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.commentCancelled()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
