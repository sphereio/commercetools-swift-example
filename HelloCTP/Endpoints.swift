import Foundation

class CartDiscounts : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "cart-discounts/"
}

class Carts : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "carts/"
}

class Categories : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "categories/"
}

class Channels : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "channels/"
}

class CustomObjects : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "custom-objects/"
}

class Customers : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "customers/"
}

class CustomerGroups : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "customer-groups/"
}

class DiscountCodes : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "discount-codes/"
}

class InventoryEntries : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "inventory-entries/"
}

class Messages : EndpointWithQuery, EndpointWithById {
  static let endpoint: String = "messages/"
}

class Payments : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "payments/"
}

class ProductDiscounts : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "product-discounts/"
}

class Products : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "products/"
}

class ProductProjections : EndpointWithQuery, EndpointWithById, EndpointWithSearch, EndpointWithSuggest {
  static let endpoint: String = "product-projections/"
}

class ProductTypes : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "product-types/"
}

class Project : EndpointWithInfo {
  static let endpoint: String = "project/"
}

class Orders : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate {
  static let endpoint: String = "orders/"
}

class Reviews : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate {
  static let endpoint: String = "reviews/"
}

class ShippingMethods : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "shipping-methods/"
}

class States : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "states/"
}

class TaxCategories : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "tax-categories/"
}

class Types : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "types/"
}

class Zones : EndpointWithQuery, EndpointWithById, EndpointWithCreate, EndpointWithUpdate, EndpointWithDelete {
  static let endpoint: String = "zones/"
}
