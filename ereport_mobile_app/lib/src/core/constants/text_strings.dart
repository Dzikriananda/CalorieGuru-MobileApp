import 'package:ereport_mobile_app/src/core/constants/screen_type.dart';

class TextStrings {
  static const appTitle = "MyEatingPal";
  static const signin = "Sign In";
  static const signinSubheader = "Please sign in";
  static const welcomeTitle = "Welcome";
  static const welcomeSubtitle = "";
  static const signinregister_first = "Dont have an Account?";
  static const signinregister_second = " Register";
  static const register_first = "Do You have an Account?";
  static const register_second = " Sign In";
  static const invalidEmailWarning = "Enter valid email";
  static const invalidNameWarning = "Enter valid name";
  static const invalidWeightWarning = "Weight Must More than 40 and Less then 160 (in Kg)";
  static const invalidHeightlWarning = "Height Must More than 130 and Less then 230 (in Cm)";
  static const invalidPasswordWarning = "Enter valid password";
  static const invalidNullWarning= "This field must not empty";
  static const invalidCalorieWarning= "Enter valid calorie!";
  static const invalidNullOptionWarning= "This Option must not be empty";
  static const homeBottomNavItem = "Home";
  static const settingsBottomNavItem = "Settings";
  static const loggedOutText = "You Have Succesfully Logged Out";
  static const loadingText = "Loading...";
  static const firstOnboarding_1 = "Welcome !";
  static const firstOnboarding_2 = "Lets be a Part of our community and";
  static const firstOnboarding_3 = "Lets Get Started !";
  static const secondOnboarding_1 = "Remember !";
  static const secondOnboarding_2 = "Everything you eat and drink matters";
  static const addScreen_1 = "Meal Information";
  static const addScreen_2 = "Category";
  static const addScreen_3 = "Use the AI! ( Powered by Calorieninjas )";
  static String addScreen_4(String args) {
    return (args == ScreenType.Meal.name) ? 'Type your meal here!' : 'Type your activity here!';
  }
  static const addScreen_5 = "Search";
  static const addScreen_6 = "Using Instruction";
  static const addScreen_7 = 'How to use?';
  static const addScreen_8 = "Activity Information";
  static String addScreen_9(String args, bool args2) {
    return args2 ? 'Update $args' : 'Add $args';
  }
  static const addScreen_10 = 'You Must Choose an Item!';
  static const addScreenFailedAddNotifName = "Add Log";
  static const addScreenFailedAddNotifContent = "Adding is Failed! Try Again!";
  static const updateScreenFailedUpdateNotifName = "Update Log";
  static const updateScreenFailedUpdateNotifContent = "Update is Failed! Try Again!";
  static const updateScreenFailedDeleteNotifName = "Delete Log";
  static const updateScreenFailedDeleteNotifContent = "Delete is Failed! Try Again!";
  static const addScreen_textfield1_hinttext1 = 'Meal name';
  static const addScreen_textfield1_hinttext2 = 'Activity name';
  static const addScreen_textfield2_hinttext1 = 'Calorie (in Kcal)';
  static const addScreen_textfield2_hinttext2 = 'Burned Calorie (in Kcal)';
  static const notFound_1 = "Sorry, We Couldn't Find Information For That Meal";
  static const notFound_2 = "Sorry, We Couldn't Find Information For That Activity";
  static const usingInstruction1 = "With this tool, you can easily determine the calorie value of your meal with a single click. You can search for a single item, like '1 bowl of porridge,' or a combination of multiple items, such as '2 bowls of porridge with a Coca-Cola.' However, please ensure to manually specify the category of the meal. It's strongly recommended to indicate its singularity; for example, instead of 'fried chicken,' type '1 fried chicken,' 'a fried chicken,' or 'a plate of pancake' if it's just a single meal.";
  static const usingInstruction2 = "With this tool, you can determine the calorie value of your activity with a single click. Enter the basic word or the basic word followed by an affix of your activity (e.g., Walk, Walking, Run, Running). Queries like 'Last night, I ran for 2 hours' would be considered incorrect. However, please ensure to manually specify the category of the Activity. You can also enter the duration of your activity in minutes. If left unfilled, the default duration will be set to 60 minutes.";





}
