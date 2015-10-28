import UIKit

class CartTableViewController: UITableViewController {
    var productToAdd: [String: AnyObject]?
    var cart: [String: AnyObject]?
    
    override func viewDidLoad() {
        self.title = "Cart"
        
        let button = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Trash, target: self, action: Selector("deleteCart:"))
        self.navigationItem.rightBarButtonItem = button
        
        loadCart()
    }
    
    func loadCart() {
        // If we have an existing cart, use it
        let defaults = NSUserDefaults.standardUserDefaults()
        if let cartId = defaults.stringForKey("ctpCartId") {
            Carts.byId(cartId) { response in
                if let cart = response.result.value as? [String: AnyObject] {
                    self.cart = cart
                    self.addProductToCart()
                }
            }
        }
        // Otherwise create a new one, save it and use it
        else {
            Carts.create(["currency": "EUR"]) { response in
                if let cart = response.result.value as? [String: AnyObject] {
                    self.cart = cart
                    self.addProductToCart()
                    
                    if let cartId = cart["id"] as? String {
                        defaults.setObject(cartId, forKey: "ctpCartId")
                    }
                }
            }
        }
    }
    
    func addProductToCart() {
        // Build the update action, see http://dev.sphere.io/http-api-projects-carts.html#add-line-item
        if  let product = productToAdd,
            let productId = product["id"] as? String,
            let c = cart,
            let cartId = c["id"] as? String,
            let cartVersion = c["version"] as? Int {
                
            let addLineItemAction: [String : AnyObject] = [
                "action": "addLineItem",
                "productId": productId,
                "variantId": 1,
                "quantity": 1
            ]
            Carts.update(cartId, version: cartVersion, actions: [addLineItemAction]) { response in
                if let cart = response.result.value as? [String: AnyObject] {
                    self.cart = cart
                    self.productToAdd = nil
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func deleteCart(sender: UIButton!) {
        if  let c = cart,
            let cartId = c["id"] as? String,
            let cartVersion = c["version"] as? Int {
                Carts.delete(cartId, version: cartVersion) { response in
                    self.cart = nil
                }
        }
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.removeObjectForKey("ctpCartId")
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    // MARK: - Table view data source
    
    func priceToString(centAmount: Int, currencyCode: String) -> String {
        let floatingAmount = Double.init(centAmount) / 100.0
        return String(format: "%.2f %@", floatingAmount, currencyCode)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if  let c = cart,
            let totalPrice = c["totalPrice"] as? [String: AnyObject],
            let centAmount = totalPrice["centAmount"] as? Int,
            let currencyCode = totalPrice["currencyCode"] as? String {
                return priceToString(centAmount, currencyCode: currencyCode)
        }
        else {
            return nil;
        }

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  let c = cart,
            let lineItems = c["lineItems"] as? [AnyObject] {
                return lineItems.count
        }
        return 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CartCell", forIndexPath: indexPath)
        
        if  let c = cart,
            let lineItems = c["lineItems"] as? [AnyObject],
            let lineItem = lineItems[indexPath.row] as? [String: AnyObject],
            let name = lineItem["name"] as? [String: AnyObject],
            let enName = name["en"] as? String,
            let quantity = lineItem["quantity"] as? Int,
            let totalPrice = lineItem["totalPrice"] as? [String: AnyObject],
            let centAmount = totalPrice["centAmount"] as? Int,
            let currencyCode = totalPrice["currencyCode"] as? String {
                cell.textLabel?.text = "\(quantity)x \(enName)"
                cell.detailTextLabel?.text = priceToString(centAmount, currencyCode: currencyCode)
        }
        
        return cell
    }

}
