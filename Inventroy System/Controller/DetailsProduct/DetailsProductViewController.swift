//
//  DetailsProductViewController.swift
//  Inventroy System
//
//  Created by Ahmed Nasr on 11/23/20.
//
import UIKit
import CoreData
class DetailsProductViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    
    var idProduct: Int64?
    var nameProduct: String?
    var priceProduct: Int64?
    var quantityProduct: Int64?
    var products = [Product]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValueInLabel()
        fetchImageProduct()
        addBarButtonItem()
    }
    func setValueInLabel(){
        nameLabel.text = nameProduct
        priceLabel.text = String(priceProduct ?? 0)
        quantityLabel.text = String(quantityProduct ?? 0)
    }
    @IBAction func increaseQuantityOnClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Increase Quantity", message: "", preferredStyle: .alert)
        alert.addTextField()
        let cancelButton = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
            //save incraese
            guard let increaseQuantity = Int(alert.textFields?[0].text ?? ""), let currentQuantity = Int(self.quantityLabel.text ?? "") else {return}
            let newQuantity: Int = currentQuantity + increaseQuantity
            self.quantityLabel.text = String(newQuantity)
            self.editQuantity(quantity: newQuantity)
        }
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func decreaseQuantityOnClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Decrease Quantity", message: "", preferredStyle: .alert)
        alert.addTextField()
        let cancelButton = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        let okButton = UIAlertAction(title: "Ok", style: .default) { (_) in
            //save decraese
            guard let decreaseQuantity = Int(alert.textFields?[0].text ?? ""), let currentQuantity = Int(self.quantityLabel.text ?? "") else {return}
            let newQuantity: Int = currentQuantity - decreaseQuantity
            if newQuantity < 0 {
                print("Quantity mustn't less than 0")
                return
            }
            self.quantityLabel.text = String(newQuantity)
            self.editQuantity(quantity: newQuantity)
        }
        alert.addAction(cancelButton)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
extension DetailsProductViewController{
    func fetchImageProduct(){
        do{
            self.products = try self.context.fetch(Product.fetchRequest())
            for i in 0..<products.count{
                if products[i].productID  == idProduct{
                    productImage.image = UIImage(data: products[i].productImage!)
                }
            }
        }catch{
            print("Error in fetchData function: ", error.localizedDescription)
        }
    }
    func editQuantity(quantity: Int){
        for i in 0..<products.count{
            if products[i].productID  == idProduct{
                products[i].productQuantity = Int64(quantity)
            }
        }
        try! self.context.save()
    }
    func addBarButtonItem(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "delete item", style: .plain, target: self, action: #selector(deleteItem))
    }
    @objc func deleteItem(){
        let alert = UIAlertController(title: "Delete This Product", message: "", preferredStyle: .alert)
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let deleteButton = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            //delete item
            self.deleteProduct()
        }
        alert.addAction(cancelButton)
        alert.addAction(deleteButton)
        present(alert, animated: true, completion: nil)
    }
    func deleteProduct(){
        for i in 0..<products.count{
            if products[i].productID  == idProduct{
                self.context.delete(self.products[i])
                do{
                    try self.context.save()
                    print("delete success")
                    navigationController?.popViewController(animated: true)
                }catch{
                    print("error when save delete item \(error.localizedDescription)")
                }
            }
        }
    }
}
