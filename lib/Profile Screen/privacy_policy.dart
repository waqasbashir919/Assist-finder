import 'package:asist_finder/const/appColors..dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  bool ischecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        centerTitle: true,
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'This Privacy Policy describes how our application ("the App") collects, uses, and shares your information when you use the App. It also explains the choices you have regarding the collection and use of your information. By using the App, you consent to the practices described in this Privacy Policy.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Information We Collect',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1.1 Personal Information: When you use the App, we may collect personal information that you provide to us, such as your name, email address, phone number, and location information. We collect this information when you register an account, post listings, communicate with other users, or interact with the App\'s features.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '1.2 Usage Information: We may automatically collect certain information about your use of the App, including your IP address, device information, operating system, browser type, and usage statistics. This information helps us analyze and improve the App\'s performance and provide a better user experience.',
              style: TextStyle(
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1.3 User Communications: Any information you provide when you communicate with other users through the App, including messages, listings, and reviews, may be collected and stored by us.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Use of Information',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '2.1 Provide and Improve the App: We use the collected information to operate, maintain, and improve the App\'s functionality, features, and user experience. This includes facilitating communication between users, personalizing content, and enhancing the security of the App',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '2.2 Communication: We may use your email address or phone number to send you important updates, notifications, and marketing materials related to the App, unless you opt-out of receiving such communications.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '2.3 Aggregate Data: We may use non-identifiable and aggregated data for research, analytics, and marketing purposes to understand trends, user behavior, and preferences. This information does not personally identify you.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Sharing of Information',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '3.1 With Other Users: Certain information, such as your username, profile picture, and listings, will be visible to other users of the App. When you interact with other users, the information you provide may be shared with them.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '3.2 Service Providers: We may share your information with trusted third-party service providers who assist us in operating the App, providing customer support, analyzing data, and conducting marketing activities. These service providers are obligated to protect your information and use it solely for the purposes specified by us.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '3.3 Legal Compliance and Protection: We may disclose your information if required by law, court order, or government regulation, or when we believe in good faith that such disclosure is necessary to protect our rights, the safety of other users, investigate fraud, or respond to a legal request.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Data Security',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'We implement reasonable security measures to protect the information we collect from unauthorized access, loss, misuse, or alteration. However, no method of transmission or storage is completely secure. Therefore, we cannot guarantee absolute security of your information.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Children\'s Privacy',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'The App is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children. If you believe we have inadvertently collected information from a child, please contact us, and we will take appropriate steps to remove the information from our systems.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Changes to the Privacy Policy',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'We reserve the right to modify this Privacy Policy at any time. If we make material changes to this policy, we will notify you by email or through the App\'s notification system. Your continued use of the App after the changes indicates your acceptance of the updated Privacy Policy.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'If you have any questions or concerns regarding this Privacy Policy or the App\'s privacy practices, please contact us at nikamk4040@googlemail.com',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Please note that this Privacy Policy applies solely to the App and not to any external websites, services, or applications that may be linked within the App. We encourage you to.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 2.0),
            InkWell(
              onTap: () {
                setState(() {
                  ischecked = !ischecked;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Checkbox(
                      activeColor: AppColors.green,
                      value: ischecked,
                      onChanged: ((value) {
                        setState(() {});
                        ischecked = value!;
                      })),
                  Text('I Agree to the Terms and Condition ')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
