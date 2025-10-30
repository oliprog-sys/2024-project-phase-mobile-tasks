
enum productStatus {pending, completed}

class Product {
  String name, description;
  double price;
  productStatus status;

  Product(this.name, this.description, this.price, {this.status = productStatus.pending});

  String get getName => name;
  String get getDescription => description;
  double get getPrice => price;

  set setName(String nameInfo) => name = nameInfo;
  set setDescription(String descriptionInfo) => description = descriptionInfo;
  set setPrice(double priceInfo) => price = priceInfo;

  @override
  String toString() {
    return 
    '''
    name: $name 
    description: $description 
    price: $price
    Status: ${status.name}

    ''';
  }
}


class ProductManager {

  List<Product> productList = [];

  void addProduct(Product product) {
    productList.add(product);
    print('${product.name} added successfully.');
  }

  void viewAllProducts() {
    if (productList.isEmpty){
      print("No products are found in the product list");
      return;
    }
    for (var product in productList) {
      print(product);
    }
  }

  void viewSingleProduct(Product product) {
    if (productList.contains(product)) {
      print(product);
    } 
    else {
      print('product is not found.');
    }
  }

  void viewCompleted() {
    var completedProducts = productList.where((p) => p.status == productStatus.completed);

    if (completedProducts.isEmpty){
      print("No completed products found");
    } else {
      for (var product in completedProducts) {
        print(product);
      }
    }
  }

  void viewPending() {
    var pendingProducts = productList.where((p) => p.status == productStatus.pending);

    if (pendingProducts.isEmpty){
      print("No pending products found");
    } else {
      for (var product in pendingProducts) {
        print(product);
      }
    }
  }

  void editProduct(Product product, {String? name, String? description, double? price}) {
    if (productList.contains(product)) {
      if (name != null) {
        product.setName = name;
      }
      if (description != null) {
        product.setDescription = description;
      }
      if (price != null) {
        product.setPrice = price;
      }

      print('${product.name} is updated successfully.');
    } else {
      print('${product.name} is not found.');
    }
    
  }

  void deleteProduct(Product product) {
   if (productList.contains(product)){
      productList.remove(product);
      print('${product.name} is deleted successfully.');
   } else {
      print('${product.name} is not found.');
   }
  }
}

void main() {
  var mainManager = ProductManager();

  var product_1 = Product('T-shirt', '100% cotton t-shirt', 399.99);
  var product_2 = Product('Shoe', 'Brand new nike', 199.99);
  var product_3 = Product('Phone', 'Brand new iPhone 16', 1399.99);
  var product_4 = Product('Monitor', '24 inch frameless monitor', 400.5);

  mainManager.addProduct(product_1);
  mainManager.addProduct(product_2);
  mainManager.addProduct(product_3);
  mainManager.addProduct(product_4);

  print('----List of products----\n');
  mainManager.viewAllProducts();

  print('----view single product----\n');
  mainManager.viewSingleProduct(product_1);

  print('---update product description----\n');
  mainManager.editProduct(product_2, description: 'Brand new ADIDAS shoe' );

  print("---- change product status----\n");
  product_1.status = productStatus.completed;  

  print("----pending products ----\n ");
  mainManager.viewPending();

  print("----- Completed products ----\n ");
  mainManager.viewCompleted();  

  print('----product list after update----\n');
  mainManager.viewAllProducts();

  print('---product deletion----\n');
  mainManager.deleteProduct(product_4);

  print('----product list after deletion----\n');
  mainManager.viewAllProducts();
}