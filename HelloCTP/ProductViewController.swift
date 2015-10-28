import UIKit

class ProductViewController: UIViewController {
    
    var product: [String: AnyObject]?
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBAction func buyNow(sender: UIButton) {
        print("TODO")
    }
    
    override func viewDidLoad() {
        // Set the view with the cached product
        updateView()
        // The product may have been updated in the mean time - reload it
        reloadProduct()
    }
    
    func updateView() {
        if let prod = product {
            // Set name in title
            if  let name = prod["name"] as? [String: AnyObject],
                let enName = name["en"] as? String {
                    self.title = enName
            }
            // Set description
            if  let description = prod["description"] as? [String: AnyObject],
                let enDescription = description["en"] as? String {
                    self.descriptionLabel.text = enDescription
            }
            // Set name of first category
            if  let categories = prod["categories"] as? [AnyObject],
                let firstCategory = categories[0] as? [String: AnyObject],
                let obj = firstCategory["obj"] as? [String: AnyObject],
                let name = obj["name"] as? [String: AnyObject],
                let enName = name["en"] as? String {
                    self.categoryLabel.text = enName
            }
            // Set price
            if  let masterVar = prod["masterVariant"] as? [String: AnyObject],
                let prices = masterVar["prices"] as? [AnyObject],
                let price = prices[0] as? [String: AnyObject],
                let priceValue = price["value"] as? [String: AnyObject],
                let centAmount = priceValue["centAmount"] as? Int,
                let currencyCode = priceValue["currencyCode"] as? String {
                    let floatingAmount = Double.init(centAmount) / 100.0
                    self.priceLabel.text = String(format: "Only %.2f %@", floatingAmount, currencyCode)
            }
        }
    }
    
    func reloadProduct() {
        if let prod = product {
            ProductProjections.byId(prod["id"] as! String, parameters: ["expand": "categories[*]"]) { response in
                switch response.result {
                case .Success(let JSON):
                    // print(JSON)
                    if let prod = JSON as? [String: AnyObject] {
                        self.product = prod
                        self.updateView()
                    }
                case .Failure(let error):
                    print(error)
                }
            }
        }
    }

}
