import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  const Details({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
            children: [   
                SingleChildScrollView(
                  child: Column(
                      children: [
                          // Product Image
                          Container(
                          width: 430,
                          height: 266,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                              ),
                              image: DecorationImage(
                                  image: AssetImage('assets/shoeImg.jpg'),
                                  fit: BoxFit.cover,
                              ),
                          )
                          ),
                  
                          // Product Details
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                            Text(
                                                'Men’s shoe',
                                                style: TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey)
                                            ),
                                            SizedBox(height: 18),
                                            Text(
                                                'Derby Leather',
                                                style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w600),
                                            ),
                                        ]
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                  Icon(Icons.star, color: Colors.amber, size:24,),
                                                  Text(
                                                      '(4.0)',
                                                      style: TextStyle(fontFamily: 'Sora', fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                                                  ),
                                              ]
                                          ),
                                          SizedBox(height: 18),
                                          Text(
                                              '\$120',
                                              style: TextStyle(fontFamily: 'Poppins', fontSize: 16, height: 1.2, fontWeight: FontWeight.w500),
                                          ),
                                        ]
                                  ),
                                ],
                            ),
                          ),
                  
                          // size selection
                          Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Column(                                
                                  children: [
                                      Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(                                        
                                              'Size:',
                                              style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 12),
                                      SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                        child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                                Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(8),
                                                        boxShadow: [
                                                            BoxShadow(
                                                                color: const Color.fromARGB(255, 228, 223, 223),
                                                                blurRadius: 2,
                                                                offset: Offset(0, 1),
                                                            )
                                                        ]
                                                    ),
                                                    child: Center(child: Text('39', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w500),)),
                                                ),
                                        
                                                SizedBox(width: 16),
                                                
                                                Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(8),
                                                        boxShadow: [
                                                            BoxShadow(
                                                                color: const Color.fromARGB(255, 228, 223, 223),
                                                                blurRadius: 2,
                                                                offset: Offset(0, 1),
                                                            )
                                                        ]
                                                    ),
                                                    child: Center(child: Text('40', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w500),)),
                                                ),
                                        
                                                SizedBox(width: 16),
                                        
                                                Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(                                                   
                                                        borderRadius: BorderRadius.circular(8),
                                                        color: const Color.fromARGB(255, 10, 92, 216),
                                                        boxShadow: [
                                                            BoxShadow(
                                                                color: const Color.fromARGB(255, 228, 223, 223),
                                                                blurRadius: 2,
                                                                offset: Offset(0, 1),
                                                            )
                                                        ],
                                                        
                                                    ),
                                                    
                                                    child: Center(child: Text('41', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),)),
                                                ),
                                        
                                                SizedBox(width: 16),
                                        
                                                Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(8),
                                                        boxShadow: [
                                                            BoxShadow(
                                                                color: const Color.fromARGB(255, 228, 223, 223),
                                                                blurRadius: 2,
                                                                offset: Offset(0, 1),
                                                            )
                                                        ]
                                                    ),
                                                    child: Center(child: Text('42', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w500),)),
                                                ),
                                        
                                                SizedBox(width: 16,),
                                        
                                                Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(8),
                                                        boxShadow: [
                                                            BoxShadow(
                                                                color: const Color.fromARGB(255, 228, 223, 223),
                                                                blurRadius: 2,
                                                                offset: Offset(0, 1),
                                                            )
                                                        ]
                                                    ),
                                                    child: Center(child: Text('43', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w500),)),
                                                ),
                                        
                                                SizedBox(width: 16,),
                                        
                                                Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(8),
                                                        boxShadow: [
                                                            BoxShadow(
                                                                color: const Color.fromARGB(255, 228, 223, 223),
                                                                blurRadius: 2,
                                                                offset: Offset(0, 1),
                                                            )
                                                        ]
                                                    ),
                                                    child: Center(child: Text('44', style: TextStyle(fontFamily: 'Poppins', fontSize: 20, fontWeight: FontWeight.w500),)),
                                                ),
                                        
                                            ],
                                        ),
                                      )
                                  ],
                              )
                          ),
                  
                         // product info
                          Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Text(
                                  'A derby leather shoe is a classic and versatile footwear option characterized by its open lacing system, where the shoelace eyelets are sewn on top of the vamp (the upper part of the shoe). This design feature provides a more relaxed and casual look compared to the closed lacing system of oxford shoes. Derby shoes are typically made of high-quality leather, known for its durability and elegance, making them suitable for both formal and casual occasions. With their timeless style and comfortable fit, derby leather shoes are a staple in any well-rounded wardrobe.',
                                  style: TextStyle(fontFamily: 'Poppins', fontSize: 14,)
                              ),
                          ),

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                  OutlinedButton(
                                      onPressed: () {
                                          debugPrint('delete button pressed');
                                      }, 
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(color: Colors.red),
                                        padding: EdgeInsets.symmetric(horizontal: 44, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                          'Delete',
                                          style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.red),
                                      )
                                  ),

                                  ElevatedButton(
                                    onPressed: () {
                                        debugPrint('Update button pressed');                                        
                                    }, 
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(255, 10, 92, 216),
                                        padding: EdgeInsets.symmetric(horizontal: 44, vertical: 15),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                    ),
                                    child: Text(
                                        'Update',
                                        style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)
                                    )
                                  ),
                              ],
                          ),
                        )                                            
                      ],                    
                  ),
                ),
                

                // back button
                Positioned(
                    top: 25,
                    left: 24,                    
                    //   child: const Icon(Icons.arrow_back_ios),
                      child: FloatingActionButton(
                        onPressed: () {
                            Navigator.of(context).pop();
                        },
                        elevation: 1,
                        mini: true,
                        shape: CircleBorder(),
                        backgroundColor: Colors.white,                        
                        child: Icon(Icons.arrow_back_ios, size: 20, color: const Color.fromARGB(255, 10, 92, 216),),                                                
                    )

                ),
                
            ],            
        )
    );
  }
}