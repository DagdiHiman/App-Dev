import 'package:flutter/material.dart';

class MyAppbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          onTap: () {},
          child: Icon(Icons.menu, size: 33.0,),
        ),
        Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.search, size: 33.0,),
              onPressed: () {},
            ),
            SizedBox(
              width: 5.0,
            ),
            CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: NetworkImage(
                  //'https://picsum.photos/100/100'
                  'https://media-exp1.licdn.com/dms/image/C5103AQHI_MOdUNU48w/profile-displayphoto-shrink_100_100/0?e=1593043200&v=beta&t=kCgpOuUv67qO1-eNsEoZPSb7_Ff-R9SdeT2NbCwpvVs'
              ),
              radius: 25.0,
            )
          ],
        ),
      ],
    );
  }
}
