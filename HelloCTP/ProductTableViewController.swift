import UIKit
import Alamofire

class ProductTableViewController: UITableViewController {
    
    var products: [AnyObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    func loadData() {
        ProductProjections.search(parameters: ["sort": "price desc", "expand": "categories[*]"]) { response in
            switch response.result {
            case .Success(let JSON):
                // print(JSON)
                if let results = JSON["results"] as? [AnyObject] {
                    self.products = results
                    
                    self.tableView.reloadData()
                }
            case .Failure(let error):
                print(error)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductCell", forIndexPath: indexPath)
        
        if  let name = products[indexPath.row]["name"] as? [String: AnyObject],
            let enName = name["en"] as? String {
            cell.textLabel?.text = enName
        }
        
        return cell
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Pass the selected product to the new view controller.
        if  let productVC = segue.destinationViewController as? ProductViewController,
            let productIndex = tableView.indexPathForSelectedRow?.row,
            let product = products[productIndex] as? [String: AnyObject] {
            productVC.product = product
        }
    }

}
