//
//  NotesViewModel.swift
//  NotesApp
//
//  Created by ELİF ÇAĞIL on 17.04.2025.
//
import Foundation
import CoreData
import UIKit

class NotesViewModel {
    
    var notesList:[Note] = []{
        didSet {
            onItemsUpdated?()
        }
    }
    var onItemsUpdated: (() -> Void)?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    func FetchNotes(){
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "timestamp", ascending: false) //ascending true -> en yeniyi alta alır
        request.sortDescriptors = [sortDescriptor]
        
        do{
            notesList = try context.fetch(request)
        }catch{
            print("Notlar Alınamadı")
        }
        
    }
    
    func SaveMode(isDarkMode:Bool){
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }
    
    
    func deleteItem(item:Note){
        context.delete(item)
        SaveContext()
        FetchNotes()
        
        
    }
    func SaveContext(){
        if context.hasChanges {
            do{
                try context.save()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}
