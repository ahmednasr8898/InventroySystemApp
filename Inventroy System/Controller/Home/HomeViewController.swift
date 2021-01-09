//
//  ViewController.swift
//  Inventroy System
//
//  Created by Ahmed Nasr on 11/23/20.
//
import UIKit
class HomeViewController: UIViewController {

    @IBOutlet weak var productTableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var arrOfProducts = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchData()
    }
    func setUpTableView(){
        productTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        productTableView.dataSource = self
        productTableView.delegate = self
    }
    @IBAction func AddNewProductOnClick(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddProductViewController")
        navigationController?.pushViewController(storyboard, animated: true)
    }
}
extension HomeViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrOfProducts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        let item = arrOfProducts[indexPath.row]
        cell.nameLabel.text = item.productName
        cell.priceLabel.text = String(item.productPrice)
        cell.quantityLabel.text = String(item.productQuantity)
        cell.SaleButton.addAction(UIAction(handler: { (_) in
            if item.productQuantity > 0{
                print("sale product")
                cell.quantityLabel.text = String(item.productQuantity - 1)
                self.arrOfProducts[indexPath.row].productQuantity -= 1
                try! self.context.save()
            }else{
                print("Count is zero")
                cell.quantityLabel.text = ("0")
                self.arrOfProducts[indexPath.row].productQuantity = 0
                try! self.context.save()
            }
        }), for: .touchUpInside)
        return cell
    }
}
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idProduct = arrOfProducts[indexPath.row].productID
        let nameProduct = arrOfProducts[indexPath.row].productName
        let priceProduct = arrOfProducts[indexPath.row].productPrice
        let quantityProduct = arrOfProducts[indexPath.row].productQuantity
        guard let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsProductViewController") as? DetailsProductViewController else{return}
        storyboard.idProduct = idProduct
        storyboard.nameProduct = nameProduct
        storyboard.priceProduct = priceProduct
        storyboard.quantityProduct = quantityProduct
        navigationController?.pushViewController(storyboard, animated: true)
    }
}
extension HomeViewController{
    func fetchData(){
        do{
            self.arrOfProducts = try self.context.fetch(Product.fetchRequest())
            DispatchQueue.main.async {
                self.productTableView.reloadData()
            }
        }catch{
            print("Error When Get Data: \(error.localizedDescription)")
        }
    }
}

