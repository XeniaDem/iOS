//
//  NoteViewController.swift
//  scbjcbjs
//
//  Created by Ксения Демиденко on 28.10.2021.
//

import UIKit
import CoreData
class NoteViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    var outputVC: ViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(barButtonSystemItem: .done, target: self, action:
                        #selector(didTapSaveNote(button:)))
        
    }
    @objc func didTapSaveNote(button: UIBarButtonItem) {
        let title = titleTextField.text ?? ""
        let descriptionText = textView.text ?? ""
        if !title.isEmpty {
            let newNote = Note(context: outputVC.context)
            newNote.title = title
            newNote.descriptionText = descriptionText
            if #available(iOS 15, *) {
                newNote.creationDate = Date.now
            } else {
                newNote.creationDate = Date()
            }
            outputVC.saveChanges()
        }
        self.navigationController?.popViewController(animated: true)
    }
}

