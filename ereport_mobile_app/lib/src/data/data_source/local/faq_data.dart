
import 'package:ereport_mobile_app/src/data/models/faq_model.dart';
import 'package:flutter/material.dart';

List<FaqItem> faqs = [
  FaqItem(
    icon: Icon(Icons.question_mark),
    title:  'How To Use AI Search For Adding Meals',
    answer: "You can easily determine the calorie value of your meal with a single click. You can search for a single item, like '1 bowl of porridge,' or a combination of multiple items, such as '2 bowls of porridge with a Coca-Cola.' However, please ensure to manually specify the category of the meal. It's strongly recommended to indicate its singularity; for example, instead of 'fried chicken,' type '1 fried chicken,' 'a fried chicken,' or 'a plate of pancake' if it's just a single meal."
  ),
  FaqItem(
    icon: Icon(Icons.question_mark),
    title: 'How To Use AI Search For Burn Calorie',
    answer: "You can determine the calorie value of your activity with a single click. Enter the basic word or the basic word followed by an affix of your activity (e.g., Walk, Walking, Run, Running). Queries like 'Last night, I ran for 2 hours' would be considered incorrect. However, please ensure to manually specify the category of the Activity. You can also enter the duration of your activity in minutes. If left unfilled, the default duration will be set to 60 minutes."
  ),
  FaqItem(
    icon: Icon(Icons.question_mark),
    title: 'How To Change My Email',
    answer: "You can change your email in the 'Change Email/Password Section. You must enter your password before make any changes. After that, choose 'Change Email'. After that, you must enter your new email, and then after you press the button, you must verify your new email by click the link from an email that we sent to your email, after it verified, the last step is to logout from the current account. Finally the Email Changing is Done and you can relogin with your new email",
  ),
  FaqItem(
    icon: Icon(Icons.question_mark),
    title: 'How To Change My Password',
    answer: "You can change your password in the 'Change Email/Password Section. You must enter your password before make any changes. After that, choose 'Change Password'. After that, you must enter your new password, and then after you press the button. Finally, your password is succesfully changed",
  ),
  FaqItem(
    icon: Icon(Icons.question_mark),
    title: 'How To Delete My Account',
    answer: "You can delete your account in the 'Delete Account' Sections"
  ),
  // FaqItem(
  //   Icon(Icons.question_mark),
  // ),
];

