//
//  ProfileViewController.swift
//  DeskAssignment
//
//  Created by Rahul Mahajan on 28/03/19.
//  Copyright © 2019 Rahul Mahajan. All rights reserved.
//

import UIKit

enum TextFieldTag : Int{
    case email = 0
    case hobby = 1
    case doj = 2
    case username = 100
}

class ProfileViewController: UIViewController {

    
    //MARK: IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var userImageButton: UIButton!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateSelectionButton: UIButton!
    @IBOutlet weak var dateViewHeightConstraint: NSLayoutConstraint!
    
    //MARK: Properties
    let profileViewModel = ProfileViewModel()
    let minHeaderHeight = CGFloat(56)
    let maxHeaderHeight = CGFloat(106)
    let maxDateViewHeight = CGFloat(256.0)
    var previousScrollOffset = CGFloat(0.0)
    
    
    //MARK: ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        shouldHideDatePicker(true)
        profileViewModel.setup()
        if let username = profileViewModel.usernameField.value as? String {
            usernameTextField.text = username
        }
        else{
            usernameTextField.placeholder = Constants.usernamePlaceholder
        }
    }
    
    //MAK: keyboard notifications
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if tableViewBottomConstraint.constant == 0{
                tableViewBottomConstraint.constant -= keyboardSize.height
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if tableViewBottomConstraint.constant != 0{
                tableViewBottomConstraint.constant += keyboardSize.height
            }
        }
    }
    
    func isEmailValid(_ email: String) -> Bool{
        let regEx = "[A-Z0-9a-z._%+]+@[A-Za-z0-9.]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regEx)
        if (predicate.evaluate(with: email) == false) {
            let alert = UIAlertController(title: "Email Error!", message: "Please enter valid email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:nil))
            self.present(alert, animated: true)
            return false
        }
        return true
    }
    
    func finishEditing(){
        shouldHideDatePicker(true)
        view.endEditing(true)
    }

    func shouldHideDatePicker(_ hide : Bool){
        UIView.animate(withDuration: 0.2) {
            self.dateViewHeightConstraint.constant = (hide ? 0.0 : self.maxDateViewHeight)
        }
    }

    func reloadTableView(){
        profileViewModel.setup()
        tableView.reloadData()
    }

    @IBAction func dateSelectionDoneAction(_ sender: UIButton) {
        finishEditing()
        let date = datePicker.date
        Global.shared.setUserInfo(key: Constants.doj, value: date)
        reloadTableView()
    }
    
    @IBAction func userImageSelectionTapped(_ sender: UIButton) {
        openCamera()
    }
    
}

extension ProfileViewController : UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - previousScrollOffset
        let isScrollingDown = scrollDiff > 0
        let isScrollingUp = scrollDiff < 0
        if isScrollingUp {
            shrinkHeader(shrink: false)
        }
        if isScrollingDown {
            shrinkHeader(shrink: true)
        }
        previousScrollOffset = scrollView.contentOffset.y
       
    }
    
    func shrinkHeader(shrink : Bool){
        if shrink{
            if headerHeightConstraint.constant > minHeaderHeight{
                UIView.animate(withDuration: 0.1) {
                    self.headerHeightConstraint.constant -= 2
                    self.view.layoutIfNeeded()
                }
            }
        }
        else{
            if headerHeightConstraint.constant < maxHeaderHeight{
                UIView.animate(withDuration: 0.1) {
                    self.headerHeightConstraint.constant += 2
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
}

extension ProfileViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileViewModel.userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profileCell = tableView.dequeueReusableCell(withIdentifier: Constants.profileCellIdentifier, for: indexPath) as! ProfileTableViewCell
        let datafield = profileViewModel.userData[indexPath.row]
        profileCell.nameLabel.text = datafield.name
        profileCell.valueTextField.tag = indexPath.row
        if let value = datafield.value as? String{
            profileCell.valueTextField.text = value
        }
        else{
            profileCell.valueTextField.placeholder = datafield.placeholder
        }
        return profileCell
    }
}

extension ProfileViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == TextFieldTag.doj.rawValue{
            shouldHideDatePicker(false)
            return false
        }
        shouldHideDatePicker(true)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        shouldHideDatePicker(true)
        setDataFrom(textField: textField)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        setDataFrom(textField: textField)
    }
    
    func setDataFrom(textField : UITextField){
        if let tag = TextFieldTag(rawValue: textField.tag){
            let trimmedText = textField.text?.trimmingCharacters(in: CharacterSet.whitespaces)
            switch  tag {
            case .email:
                if let email = trimmedText, isEmailValid(email){
                    Global.shared.setUserInfo(key: Constants.email, value: email)
                }
            case .hobby:
                if let hobby = trimmedText{
                    Global.shared.setUserInfo(key: Constants.hobby, value: hobby)
                }
            case .username:
                if let username = trimmedText{
                    Global.shared.setUserInfo(key: Constants.username, value: username)
                }
            case .doj:
                if let dojText = trimmedText,
                    let date = Utility.dateFromString(string: dojText){
                    Global.shared.setUserInfo(key: Constants.doj, value: date)
                }
            }
        }
    }
}


extension ProfileViewController : UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - UIImagePickerControllerDelegate delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        Utility.circularView(view: userImageButton)
        userImageButton.setImage(selectedImage, for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
