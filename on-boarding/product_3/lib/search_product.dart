import 'package:flutter/material.dart';
import 'package:product_3/product_details.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Search Product')),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20.0,
            color: const Color.fromARGB(255, 10, 92, 216),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 23,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 15,),
              Container(
                width: 311,
                height: 48,                
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey,),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text(
                        'Leather',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.grey[700]),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_rounded, color: const Color.fromARGB(255, 10, 92, 216),)
                    ],
                  ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 10, 92, 216),
                  borderRadius: BorderRadius.circular(8)
                ),
                child: IconButton(                
                  onPressed: () {
                    debugPrint("filter button pressed");
                  }, 
                  icon: Icon(Icons.filter_list, color: Colors.white,)
                ),
              )
              
            ],
          ),
          SizedBox(height: 30,),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
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
                  SizedBox(height: 30,),
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
            
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 338,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(              
                crossAxisAlignment: CrossAxisAlignment.start,              
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Text(
                      'Category',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Center(
                    child: Container(
                      width: 366,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey,),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0),
                    child: Text(
                      'Price',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400,)
                    ),
                  ),
                  SizedBox(height: 8.0,),
                  // PriceRangeSlider()
                  Padding(
                    padding: const EdgeInsets.only(left: 13.0),
                    child: RangeSlider(                    
                      values: RangeValues(50, 400), 
                      min: 0,
                      max: 500,
                      onChanged: (RangeValues newVals) {
                        debugPrint("Range slider dragged");
                    }),
                  ),
                  SizedBox(height: 55,),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        debugPrint("Add button pressed");
                      }, 
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 10, 92, 216),
                          minimumSize: Size(377, 54),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                      ),
                      child: Text(
                        'APPLY',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
                      )
                    ),
                  ),
                ],
              ),
            ),
          )

        ],
      ),
      
    );
  }
}


class PriceRangeSlider extends StatefulWidget {
  const PriceRangeSlider({super.key});

  @override
  State<PriceRangeSlider> createState() => _PriceRangeSliderState();
}

class _PriceRangeSliderState extends State<PriceRangeSlider> {
  RangeValues _currentRange = const RangeValues(50, 250);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [        
        RangeSlider(
          values: _currentRange,
          min: 0,
          max: 500,
          activeColor: Colors.blue,
          inactiveColor: Colors.grey[300],          
          onChanged: (RangeValues values) {
            setState(() {
              _currentRange = values;
            });
          },
        ),     
      ],
    );
  }
}
