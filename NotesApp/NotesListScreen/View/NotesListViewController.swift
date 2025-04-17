//
//  ViewController.swift
//  NotesApp
//
//  Created by ELİF ÇAĞIL on 17.04.2025.
//

import UIKit
import CoreData

class NotesListViewController: UIViewController {
    
    @IBOutlet weak var AddButton: UIBarButtonItem!
    @IBOutlet weak var switchButton: UIBarButtonItem!
    @IBOutlet weak var notesTableView: UITableView!
    
    var viewModel = NotesViewModel()

    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.delegate = self
        notesTableView.dataSource = self
        
        view.backgroundColor = .systemBackground
        notesTableView.backgroundColor = .systemBackground
        applySavedMode()
        Update()
    }
    
    func Update(){
        viewModel.onItemsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.notesTableView.reloadData()
            }
        }
    }
    
    @IBAction func toggleButton(_ sender: UIBarButtonItem) {
    
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else { return }
        let currentStyle = window.overrideUserInterfaceStyle
        let newStyle: UIUserInterfaceStyle = currentStyle == .dark ? .light : .dark
        UIView.transition(with: window, duration: 0.4, options: [.transitionCrossDissolve],animations: {
            window.overrideUserInterfaceStyle = newStyle
            
        },completion: nil)
        let newIcon = (newStyle == .dark) ? "moon.fill" : "moon"
        sender.image = UIImage(systemName: newIcon)
        
        viewModel.SaveMode(isDarkMode: newStyle == .dark)
    }
    func UpdateButtonsColor(){
        let isdarkMode = traitCollection.userInterfaceStyle == .dark
        let buttonColor = isdarkMode ? UIColor.systemYellow : UIColor.systemBlue
        switchButton.tintColor = buttonColor
        AddButton.tintColor = buttonColor
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.FetchNotes()
        UpdateButtonsColor()
        
    
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        UpdateButtonsColor()
    }
    
   
    func applySavedMode() {
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")

        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first
        else { return }

        window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        switchButton.image = UIImage(systemName: isDarkMode ? "moon.fill" : "moon")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let note = sender as? Note
        if segue.identifier == "showDetail"{
            let gidilecekVC = segue.destination as! NotesEditorViewController
            gidilecekVC.note = note!
            let isDarkMode = traitCollection.userInterfaceStyle == .dark
            gidilecekVC.isDarkMode = isDarkMode
        }
    }
}

extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.notesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let notes = viewModel.notesList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell",for: indexPath) as! NotesTableViewCell
        cell.notesTitle.text = notes.title ?? "No Title"
        let content = notes.content ?? ""
        let preview = content.count > 40 ? String(content.prefix(40)) + "..." : content
        cell.NotesSubtitle.text = preview
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: viewModel.notesList[indexPath.row])

    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {(action,view,completionHandler) in
            let item = self.viewModel.notesList[indexPath.row]
            self.viewModel.deleteItem(item:item)
            completionHandler(true)
           
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
