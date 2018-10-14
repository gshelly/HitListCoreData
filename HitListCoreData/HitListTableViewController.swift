//
//  HitListTableViewController.swift
//  HitListCoreData
//
//  Created by shelly.gupta on 7/1/18.
//  Copyright © 2018 shelly.gupta. All rights reserved.
//

import UIKit
import CoreData

class HitListTableViewController: UITableViewController {

//    var names = [NSManagedObject]()
    var names = [Person]()
    var managedObjectContext: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
        loadData()
    }

    func loadData() {
        //let request: NSFetchRequest<NSManagedObject> = NSFetchRequest(entityName: "Person")
        let request: NSFetchRequest<Person> = Person.fetchRequest()
        do {
            let result = try managedObjectContext?.fetch(request)
            names = result!
            tableView.reloadData()
        }
        catch {
            fatalError("Error in retreiving data")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Person Hit List", message: "Who's the next Person?", preferredStyle: .alert)
        alertController.addTextField { (textField) in
        
        }
        
        let addAction = UIAlertAction(title: "ADD", style: .default) { [weak self](alert) in
//            let textField = alertController.textFields?.first
           // self?.names.append((textField?.text)!)
            
            guard let nameText = alertController.textFields?.first?.text, nameText != "" else {
                return
            }
            /*
            let entity = NSEntityDescription.entity(forEntityName: "Person", in: (self?.managedObjectContext)!)
            
            let name = NSManagedObject(entity: entity!, insertInto: self?.managedObjectContext)
            name.setValue(nameText, forKey: "name") */
            let person = Person(context: (self?.managedObjectContext)!)
            person.name = nameText
            
            do {
                try self?.managedObjectContext?.save()
            }
            catch {
                fatalError("Error in storing the data")
            }
            
            self?.loadData()
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancel)
        present(alertController, animated: true, completion: nil)
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)

        let personName = names[indexPath.row]
        cell.textLabel?.text = personName.name

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
