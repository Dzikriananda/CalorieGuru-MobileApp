import 'package:ereport_mobile_app/src/core/constants/screen_type.dart';

class TextStrings {
  static const appTitle = "MyEatingPal";
  static const signin = "Sign In";
  static const signinSubheader = "Please sign in";
  static const welcomeTitle = "Welcome";
  static const welcomeSubtitle = "";
  static const noConnection = "No Connection!";
  static const signinregister_first = "Dont have an Account?";
  static const signinregister_second = " Register";
  static const register_first = "Do You have an Account?";
  static const register_second = " Sign In";
  static const alertButton_1 = 'OK';
  static const alertButton_2 = 'Retry';
  static const alertTitle = 'Alert';
  static const snackBarContent_1 = 'Login Failed!';
  static snackBarContent_2(String? args) {
    return (args != null) ? 'Error $args' : 'Error';
  }
  static const signInForm_1 = 'Login';
  static const signInForm_2 = 'Email';
  static const signInForm_3 = 'Password';
  static const signInForm_4 = 'Login';
  static const registerForm_1 = 'Register';
  static const registerForm_2 = 'Enter Your Email';
  static const registerForm_3 = 'Enter Your Password';
  static const registerForm_4 = 'Reenter Password';
  static const registerForm_5 = 'Register';
  static const registerForm_6 = '';
  static const registerForm_7 = '';
  static const registerForm_8 = '';
  static const registerForm_9 = '';
  static const registerForm_10 = '';


  static const alertContent_1 = 'Failed';
  static const invalidEmailWarning = "Enter valid email!";
  static const invalidNameWarning = "Enter valid name!";
  static const invalidQueryWarning = "Enter valid Query!";
  static const invalidDurationWarning = "Duration must be an integer/round number!";
  static const invalidWeightWarning = "Weight Must More than 40 and Less then 160 (in Kg)";
  static const invalidHeightlWarning = "Height Must More than 130 and Less then 230 (in Cm)";
  static const invalidPasswordWarning = "Password Length Must Be At least 6 Characters";
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
  static const registerParentScreen_1 = "Previous";
  static const registerParentScreen_2 = '  Next  ';
  static const registerOnBoardingScreen_1 = 'Congrats,\nYour Accounts Has Been Created!';
  static const registerOnBoardingScreen_2 = 'In order to find the best choice\nfor you, please fill these required data';
  static const registerOnBoardingScreen_3 = '  Next  ';
  static const secondOnboarding_2 = "Everything you eat and drink matters";
  static const registerScreen_1 = 'Full Name';
  static const registerScreen_2 = 'Weight (in Kg)';
  static const registerScreen_3 = 'Height (in Cm)';
  static const registerScreen_4 = 'You Are a ?';
  static const registerScreen_5 = 'Female';
  static const registerScreen_6 = 'Male';
  static const registerScreen_7 = 'When were you born?';
  static const registerScreen_8 = 'PICK DATE';
  static const registerScreen_9 = 'Choose your activity level';
  static const registerScreen_10 = 'Finding best result for you.....';
  static const registerScreen_11 = 'Congratulations!';
  static const registerScreen_12 = 'Your plan is ready and you\'re a step\ncloser to maintain your weight';
  static const registerScreen_13 = 'Your daily calorie intake is : ';
  static const registerScreen_14 = "Calories";
  static const registerScreen_15 = '*You can still change your personal information later';
  static const errorAlert_1 = 'No Internet';
  static String errorRuntime(String args, String args2) {
    return 'Error at $args ($args2)';
  }



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
  static const addScreen_11 = 'Duration (In minutes , optional)';
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
  static const selectAuthenticationScreen_1 = 'Select Which Credentials You Wants To Change';
  static const selectAuthenticationScreen_2 = 'Change Password';
  static const selectAuthenticationScreen_3 = 'Change Email';
  static const selectAuthenticationScreen_4 = 'Verify Email';
  static String editAuthenticationScreen_1(String args) {
    return 'Enter your new $args';
  }
  static const editAuthenticationScreen_2 = 'Email';
  static const editAuthenticationScreen_3 = 'Password';
  static String editAuthenticationScreen_4(String args) {
    return 'Edit $args';
  }
  static const editAuthenticationScreen_5 = 'Your Password Has Been Changed!';
  static String editAuthenticationScreen_6(String args) {
    return 'An Email Has Been Sent To Your New Email At $args, Verify It And Then Relogin This App In Order To Succesfully Change Your Email';
  }
  static const editAuthenticationScreen_7 = 'Error';
  static const editAuthenticationScreen_8 = 'Submit';
  static const enterAuthenticationScreen_1 = 'Enter your password in order to make changes to your current email/password';
  static const enterAuthenticationScreen_2 = 'Your Password Is Wrong!';
  static const enterAuthenticationScreen_3 = 'Too Many Attempt, Try Again Later!';
  static const enterAuthenticationScreen_4 = 'Unknown Error, Try Again Later!';
  static const faqScreen_1 = 'Frequently Asked Questions';
  static const faqScreen_2 = 'Doesnt Find Your Answer / Want To Give Us A Message?';
  static const faqScreen_3 = 'Click Here';
  static const feedbackScreen_1 = 'Feedback';
  static const feedbackScreen_2 = 'Send Us Your Feedback/Messages!';
  static const feedbackScreen_3 = 'Do You Have A Suggestion Or Found Some Bug? Let Us Know In The Field Below.';
  static const feedbackScreen_4 = 'How Was Your Experience?';
  static const feedbackScreen_5 = 'Frequently Asked Questions';
  static const feedbackScreen_6 = 'Describe Your Experience Here...';
  static const feedbackScreen_7 = 'Send Feedback';
  static const feedbackScreen_8 = 'Failed To Send, Please Try Again';
  static const feedbackScreen_9 = 'OK';
  static const feedbackScreen_10 = 'Your Feedback has been Succesfully Sent! Thank You For Your Feedback!';
  static const feedbackScreen_11 = 'Please Fill Out Above Options';
  static const feedbackScreen_12 = 'OK';
  static const aboutAppScreen_1 = 'About App';
  static const aboutAppScreen_2 = "Hello! I'm Dzikri, the creator behind this food diet app. Passionate about healthy living and nutrition, I developed this app as a personal project to simplify the journey to a healthier lifestyle. With a focus on simplicity and practicality, this app aims to assist users in making smarter dietary choices. It's designed to monitor your daily intake and thus achieving and maintaining a balanced diet. Join me in this journey towards better health and wellness!";
  static const aboutAppScreen_3 = 'Learn More About Me';
  static const aboutAppScreen_4 = 'Credits';
  static const aboutAppScreen_5 = 'We extend our heartfelt gratitude to the following API providers and Others services whose services have been instrumental in shaping the functionality and enhancing the user experience of this app:';
  static const aboutAppScreen_6 = 'Calorie Ninjas: Special thanks for providing Data about Meals and Sport Activities.';
  static const aboutAppScreen_7 = 'M Alaaddin Celik: Special thanks for providing Data about Calorie Need.';
  static const aboutAppScreen_8 = 'Blush: Special thanks for providing many Illustrations.';









}
