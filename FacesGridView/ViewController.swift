//
//  ViewController.swift
//  FacesGridView
//
//  Created by ahmed tantawy on 14/01/2021.
//

import UIKit

class ViewController: UICollectionViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    var people = [Person]()
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Person", for: indexPath) as? PersonCell else {
            // we failed to get a PersonCell – bail out!
            fatalError("Unable to dequeue PersonCell.")
        }

        //Pull out the person from the people array at the correct position.
        let person = people[indexPath.item]
        cell.name.text   = person.name
        let path = getDocumentsDirectory().appendingPathComponent(person.image)
        cell.image  =

        // if we're still here it means we got a PersonCell, so we can return it
        return cell
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard  let image = info [.editedImage] as? UIImage else {
            return
        }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
       if  let jpegData = image.jpegData(compressionQuality: 0.8){
            
            try? jpegData.write (to: imagePath)
       
        }
        
        let person = Person(name: "unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        
    dismiss(animated: true)
    }
    func getDocumentsDirectory () ->URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPerson))
        
        
    }
    
    
    @objc func addNewPerson(){
        
        let picker = UIImagePickerController()
        
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
        
        
    }
   

}

