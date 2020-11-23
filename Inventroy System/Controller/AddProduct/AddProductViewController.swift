//
//  AddProductViewController.swift
//  Inventroy System
//
//  Created by Ahmed Nasr on 11/23/20.
//
import UIKit
import CoreData
class AddProductViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var productImageView: UIImageView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var idUserDefauls = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func chooseImageOnClick(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
    @IBAction func saveProductOnClick(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty,let price = priceTextField.text, !price.isEmpty, let quantity = quantityTextField.text, !quantity.isEmpty, let image = productImageView.image  else {
            //show error messege
            return
        }
        print("Success")
        //Save Data
        let product = Product(context: self.context)
        let id = getID()
        setID(id: id + 1)
        product.productID = Int64(id + 1)
        idUserDefauls += 1
        product.productName = name
        product.productPrice = Int64(price) ?? 0
        product.productQuantity = Int64(quantity) ?? 0
        let dataImage = image.jpegData(compressionQuality: 0.5)
        product.productImage = dataImage
        do{
            try self.context.save()
            print("Save Data Is Success")
            navigationController?.popViewController(animated: true)
        }catch{
            print("Error When Save Product: \(error.localizedDescription)")
        }
    }
}
extension AddProductViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        dismiss(animated: true, completion: nil)
        let imagePickerView = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        productImageView.image = imagePickerView
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
}
extension AddProductViewController{
    func setID(id: Int){
        UserDefaults.standard.set(id, forKey: "productID")
    }
    func getID()->Int{
        guard let id = UserDefaults.standard.object(forKey: "productID") else { return 0 }
        return id as! Int
    }
}
extension AddProductViewController{
    func deleteAllData() {
        do{
            //1- fetch all data
            let results = try self.context.fetch(Product.fetchRequest())
            for res in results{
                //2- delete
                self.context.delete(res as! NSManagedObject)
            }
        }catch{
            print("Error in deleteAllDataOnClick function: ", error.localizedDescription)
        }
        do{
            //3- save change
            try self.context.save()
        }catch{
            print(error.localizedDescription)
        }
        //4- realod data in tableView
        //self.fetchData()
    }
}
