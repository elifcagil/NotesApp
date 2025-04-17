//
//  NotesEditorViewController.swift
//  NotesApp
//
//  Created by ELİF ÇAĞIL on 17.04.2025.
//

import UIKit

class NotesEditorViewController: UIViewController {
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var NotesTitle: UITextField!
    
    @IBOutlet weak var NotesContent: UITextView!
    
    var note : Note?
    var isDarkMode : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateButtonsColor()
        view.backgroundColor = .systemBackground
        title = note == nil ? "New Note" : "Edit Note"
        GelenNot()
       
        
    }
    
    func GelenNot(){
        if let gelenNot = note{
            NotesTitle.text = gelenNot.title
            NotesContent.text = gelenNot.content
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        UpdateButtonsColor()
    }
    
    func ShowAlert(){
        
        guard let content = NotesContent.text , !content.trimmingCharacters(in: .whitespaces).isEmpty else{
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
                   let buttonColor = isDarkMode ? UIColor.systemYellow : UIColor.systemBlue
            let alert = UIAlertController(title: "Empty Note", message: "Notes musn't be empty", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            alert.view.tintColor = buttonColor

            present(alert,animated: true)
            
            return
        }
        
    }
    
    func UpdateButtonsColor(){
        let isdarkMode = traitCollection.userInterfaceStyle == .dark
        let buttonColor = isdarkMode ? UIColor.systemYellow : UIColor.systemBlue
        navigationController?.navigationBar.tintColor = buttonColor
        
        
        
        
        
    }
    
    @IBAction func saveNotesButton(_ sender: Any) {
        if let content = NotesContent.text,!content.trimmingCharacters(in: .whitespaces).isEmpty {
            
            
            
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            
            if let existingNote = note{
                existingNote.content = content
                existingNote.title = NotesTitle.text ?? "No Title"
            }else{
                let newNote = Note(context: context)
                newNote.content = content
                newNote.title = NotesTitle.text ?? "No Title"
                newNote.timestamp = Date()
            }
            do{
                try context.save()
                navigationController?.popViewController(animated: true)
            }catch{
                print(error.localizedDescription)
            }
        }
        else {
            ShowAlert()
        }}
        
        
        
    }

