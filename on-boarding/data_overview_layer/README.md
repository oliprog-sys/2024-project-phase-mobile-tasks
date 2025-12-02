# data_overview_layer

This project follows Clean Architecture.  
Task 10 implements the Data Layer for the Product feature.

## Folder Structure

lib/
├── core/
├── features/
| └── ecommerce/
│ └── data/
│ └── models/
└── test/

## product model
    - converts JSON to product entity using fromJson function
    - converts product entity to JSON using toJson function
    - Ensure the Data Layer matches Domain rule

Unit tests included at:  
`test/features/product/data/models/product_model_test.dart`
