 # Widget Testing
 - A replica of the ecommerce in which here the widget testing is add to check if the application passes through different tests. Those tests was
 ### Testing the Creation of Product
    - Here there is a test file called "add_product_test.dart" which tests the creation of new product in the ecommerce app 
    - Tests the behaviour of new product with different input senarios like Empty input fields, invalid value entered
### Testing Product List
    - Here the product lists are displayed on the UI
    - It also tests if a product can be updated in the product list
### Test if the back arrow works to go from the product details page to home page
    - The test checks if tapping the back arrow button in the product page correctly navigates to the home page of the application

## To test the set up of the Testing Enviroment
    - There is a flutter_test package in the dev_dependencies in the pubspec.yaml file
    - We can also if the app is running in test-friendly enviroment using  "flutter test --coverage"