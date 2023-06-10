import 'package:flutter/material.dart';

import '../const/appColors..dart';

class TermsAndCondition extends StatefulWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

  @override
  _TermsAndConditionState createState() => _TermsAndConditionState();
}

class _TermsAndConditionState extends State<TermsAndCondition> {
  bool ischecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        centerTitle: true,
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Terms and Conditions',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'These Terms and Conditions ("Agreement") govern your use of the application ("the App") and constitute a legally binding agreement between you ("User") and the App\'s owner. By using the App, you agree to comply with and be bound by the terms and conditions outlined below. If you are under the age of 13, please refrain from using the App.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. Use of the App',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1.1 Eligibility: The App is intended for use by individuals who are at least 13 years old. By using the App, you represent and warrant that you are at least 13 years old. If you are between the ages of 13 and 18, you must review these Terms and Conditions with your parent or legal guardian and obtain their consent before using the App.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '1.2 Account Registration: To access certain features of the App, you may need to create an account. If you are under 18 years old, you must have the consent of your parent or legal guardian to create an account. By creating an account, you represent that you have obtained such consent.',
              style: TextStyle(
                fontSize: 16.0,
                // fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1.3 Parental Consent: If you are under 18 years old, your parent or legal guardian acknowledges and agrees to these Terms and Conditions on your behalf and assumes full responsibility for your compliance with this Agreement.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '1.4 Prohibited Activities: When using the App, you agree not to engage in any activities prohibited by applicable laws or regulations. You also agree not to misrepresent your age or provide false information during the registration process.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. User Content',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '2.1 Responsibility: If you are under 18 years old, you must obtain the consent of your parent or legal guardian before posting, uploading, or transmitting any content through the App ("User Content"). Your parent or legal guardian assumes responsibility for any User Content you submit.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '2.2 Prohibited Content: You agree not to post, upload, or transmit any User Content that is inappropriate for individuals under the age of 13. This includes content that is defamatory, obscene, unlawful, or harmful. Your parent or legal guardian should monitor your use of the App and ensure that any User Content you submit complies with these standards.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '2.3 Moderation: The App\'s owner reserves the right to moderate User Content and remove or block any content that violates these Terms and Conditions or is deemed inappropriate or harmful. However, the App\'s owner does not guarantee the accuracy, integrity, or quality of User Content and assumes no responsibility for it.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Intellectual Property',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '3.1 Ownership: The App and its contents, including but not limited to text, graphics, logos, and software, are the intellectual property of the App\'s owner and are protected by copyright and other intellectual property laws. You may not copy, modify, distribute, or reproduce any part of the App without prior written consent from the App\'s owner.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '3.2 Trademarks: All trademarks, service marks, logos, and trade names displayed within the App are the property of their respective owners. Use of these trademarks without authorization is strictly prohibited.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '3.3 Legal Compliance and Protection: We may disclose your information if required by law, court order, or government regulation, or when we believe in good faith that such disclosure is necessary to protect our rights, the safety of other users, investigate fraud, or respond to a legal request.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Disclaimer of Warranties',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '4.1 Use at Your Own Risk: The App is provided on an "as is" and "as available" basis, without any warranties or representations of any kind, whether express or implied. You use the App at your own risk. The App\'s owner makes no warranties or guarantees regarding the accuracy, completeness, reliability, or availability of the App.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Limitation of Liability',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '5.1 To the extent permitted by applicable law, the App\'s owner shall not be liable for any direct, indirect, incidental, consequential, or punitive damages arising out of or in connection with your use of the App, including but not limited to damages for loss of profits, data, or',
              style: TextStyle(fontSize: 16.0),
            ),
            // SizedBox(height: 16.0),
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
