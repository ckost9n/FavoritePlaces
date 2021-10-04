//
//  NewPlaceTableViewController.swift
//  FavoritePlaces
//
//  Created by Konstantin on 27.09.2021.
//

import UIKit

class NewPlaceTableViewController: UITableViewController {
    
    var currentPlace: Place!
    var imageIsChanged = false
    var rating = 0.0 {
        didSet {
            updateButtonSelectionState()
        }
    }

    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBOutlet var placeImage: UIImageView!
    
    @IBOutlet var placeName: UITextField!
    @IBOutlet var placeLocation: UITextField!
    @IBOutlet var placeType: UITextField!
    @IBOutlet var buttonCollection: [UIButton]! {
        didSet {
            setupButons()
            updateButtonSelectionState()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        saveButton.isEnabled = false
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()
        
    }
    @IBAction func buttonAction(_ sender: UIButton) {
        
        let index = sender.tag
        let selectedRating = Double(index + 1)
        
        rating = selectedRating == rating ? 0 : selectedRating
        
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private func setupEditScreen() {
        if currentPlace != nil {
            
            setupNavigationBar()
            imageIsChanged = true
            
            guard let data = currentPlace?.imageData, let image = UIImage(data: data) else { return }
            
            placeName.text = currentPlace?.name
            placeLocation.text = currentPlace?.location
            placeType.text = currentPlace?.type
            placeImage.image = image
            placeImage.contentMode = .scaleAspectFill
        }
    }
    
    private func setupNavigationBar() {
        
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        navigationItem.leftBarButtonItem = nil
        title = currentPlace?.name
        saveButton.isEnabled = true
        
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let cameraIcon = UIImage(named: "camera")
            let photoIcon = UIImage(named: "photo")
            
            let actionSheet = UIAlertController(
                title: nil,
                message: nil,
                preferredStyle: .actionSheet
            )
            
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(.camera)
            }
            camera.setValue(cameraIcon, forKey: "image")
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(.photoLibrary)
            }
            photo.setValue(photoIcon, forKey: "image")
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheet.addAction(camera)
            actionSheet.addAction(photo)
            actionSheet.addAction(cancel)
            
            present(actionSheet, animated: true)
        } else {
            view.endEditing(true)
        }
    }
    
    func savePlace() {
        
        let newPlace = Place()
        
        let image = imageIsChanged ? placeImage.image : UIImage(named: "imagePlaceholder")
        
        let imageData = image?.pngData()

        newPlace.name = placeName.text!
        newPlace.location = placeLocation.text
        newPlace.type = placeType.text
        newPlace.imageData = imageData
        
        if currentPlace != nil {
            try! realm.write {
                currentPlace?.name = newPlace.name
                currentPlace?.location = newPlace.location
                currentPlace?.type = newPlace.type
                currentPlace?.imageData = newPlace.imageData
            }
        } else {
            StorageManager.saveObject(newPlace)
        }
        
    }

}

// MARK: - Text Field Delegate

extension NewPlaceTableViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc private func textFieldChanged() {
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
}

// MARK: - Work with image

extension NewPlaceTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(_ source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true
        imageIsChanged = true
        dismiss(animated: true)
    }
    
}

// MARK: - Buttons setup

extension NewPlaceTableViewController {
    func setupButons() {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.orange,
            .font: UIFont.boldSystemFont(ofSize: 40)
        ]
        for button in buttonCollection {
            button.configuration?.baseBackgroundColor = .white
            
            button.setAttributedTitle(NSAttributedString(string: "☆", attributes: attributes), for: .normal)
            button.setAttributedTitle(NSAttributedString(string: "★", attributes: attributes), for: .selected)
            button.setAttributedTitle(NSAttributedString(string: "⭐️", attributes: attributes), for: .highlighted)
            button.setAttributedTitle(NSAttributedString(string: "⭐️", attributes: attributes), for: [.highlighted, .selected])
            
        }
        updateButtonSelectionState()
    }
    
    func updateButtonSelectionState() {
        for (index, button) in buttonCollection.enumerated() {
            button.isSelected = Double(index) < rating
        }
    }
}
