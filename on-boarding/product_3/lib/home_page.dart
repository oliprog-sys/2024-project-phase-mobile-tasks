import 'package:flutter/material.dart';
import 'package:product_3/add_product.dart';
import 'package:product_3/product_details.dart';
import 'package:product_3/search_product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xcccccccc),
                borderRadius: BorderRadius.circular(11),
              ),
            ),
            SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  'July, 2023',
                  style: TextStyle(fontFamily: 'Syne', fontSize: 12, color: Colors.grey),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(text: 'Hello,', style: TextStyle(color: Colors.black)),
                      TextSpan(
                        text: 'Yohannes',
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                border: Border.all(color: Colors.grey),
              ),
              child: Icon(Icons.notifications_none),
            ),
          ],
        ),
      ),
      body: Padding(
        // padding: EdgeInsets.only(top: 60, left: 16, right: 16, bottom: 16),          
        padding: EdgeInsets.all(16.0),          
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 
              // SizedBox(height: 32),
              Row(
                children: [
                  Text(
                    'Available Products',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: IconButton(
                      onPressed: (){ 
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder:(context) => SearchPage(),)
                        );
                      }, 
                      icon: Icon(
                        Icons.search_rounded, color: Colors.grey,
                      )),
                  ),
                ],
              ),
              SizedBox(height: 30),
          
              // product cards
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Details())
                      );
                    },
                    child: Container(
                      width: 366,
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 366,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              color: Colors.grey[400],
                              image: DecorationImage(
                                image: AssetImage('assets/shoeImg.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Derby Leather Shoes',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 20, height: 1.2, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 7,),
                                    Text(
                                      'Men’s shoe',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
                                    ),
                                  ]
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$120',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14, height: 1.2, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 7,),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size:20,),
                                        Text(
                                          '(4.0)',
                                          style: TextStyle(fontFamily: 'Sora', fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
                                        ),
                                      ]
                                    )
                                  ]
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          
                  SizedBox(height: 30),
          

                  // Second product card
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Details()));
                    },
                    child: Container(
                      width: 366,
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 366,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              color: Colors.grey[400],
                              image: DecorationImage(
                                image: AssetImage('assets/shoeImg.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Derby Leather Shoes',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 20, height: 1.2, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 7,),
                                    Text(
                                      'Men’s shoe',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
                                    ),
                                  ]
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$120',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14, height: 1.2, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 7,),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size:20,),
                                        Text(
                                          '(4.0)',
                                          style: TextStyle(fontFamily: 'Sora', fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
                                        ),
                                      ]
                                    ),
                                  ]
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          
                  SizedBox(height: 30),
          
                  // Third Product card
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Details()));
                    },
                    child: Container(
                      width: 366,
                      height: 240,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          )
                        ]
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 366,
                            height: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                              color: Colors.grey[400],
                              image: DecorationImage(
                                image: AssetImage('assets/shoeImg.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Derby Leather Shoes',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 20, height: 1.2, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 7,),
                                    Text(
                                      'Men’s shoe',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
                                    ),
                                  ]
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '\$120',
                                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14, height: 1.2, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 7,),
                                    Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.amber, size:20,),
                                        Text(
                                          '(4.0)',
                                          style: TextStyle(fontFamily: 'Sora', fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
                                        ),
                                      ]
                                    )
                                  ]
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
        },
        backgroundColor: const Color.fromARGB(255, 10, 92, 216),
        shape: CircleBorder(),
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
          semanticLabel: 'Add Product',            
        ),          
      ),
    );    
  }
}
