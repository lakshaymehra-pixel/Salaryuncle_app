import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/shared_constants.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Privacy Policy', style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              '${SharedConstants.Company_Name} ("we," "our," "us") operates the https://www.suryaloan.com website (the "Service"). This Privacy Policy explains how we collect, use, and share your personal information when you use our Service.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Information We Collect', context),
            _buildSubSectionTitle('Personal Information', context),
            Text(
              'When you apply for a loan or use our Services, we may collect personal information such as your Name, address, email address, phone number, date of birth, and other identifying information.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 10),
            _buildSubSectionTitle('Usage Information', context),
            Text(
              'We may collect information about how you access and use our website and services, including IP addresses, browser type, and operating system.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 10),
            _buildSubSectionTitle('Financial Information', context),
            Text(
              'Bank account details, credit card information, credit history, and other financial data necessary for providing our services.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 10),
            _buildSubSectionTitle('Identification Documents', context),
            Text(
              'Copies of government-issued identification documents, such as passports or driver\'s licenses.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('How We Use Your Information', context),
            Text(
              'We use your information for the following purposes:',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 10),
            Text(
              '• To provide and maintain our services.\n'
              '• To process your transactions and manage your accounts.\n'
              '• To verify your identity and prevent fraud.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Data Security', context),
            Text(
              'We implement appropriate technical and organisational measures to protect your personal information from unauthorised access, use, or disclosure. However, no method of transmission over the internet or electronic storage is 100% secure.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Your Rights', context),
            Text(
              'Depending on your jurisdiction, you may have the following rights regarding your personal information:',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 10),
            Text(
              '• The right to access your personal information.\n'
              '• The right to correct any inaccurate or incomplete information.\n'
              '• The right to request the deletion of your personal information.\n'
              '• The right to object to or restrict the processing of your personal information.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 10),
            Text(
              'To exercise these rights, please contact us using the information provided below.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Data Retention and Deletion', context),
            Text(
              'You also attest to the fact that, in accordance with our adopted document retention policy, we will be free to keep such papers for internal records.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 10),
            Text(
              'You have the choice to consent to the use of certain data, limit its disclosure to third parties, control data retention, or revoke consent that has already been given to collect personal data if the Credit Line you were given is settled and you owe them nothing more, and you obtain specific regulatory authority in accordance with the Prevention of Money-Laundering Act, 2002.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Cookies and Tracking Technologies', context),
            Text(
              'We use cookies and similar tracking technologies to enhance your experience on our website. You can control the use of cookies through your browser settings.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Grievance Officer', context),
            Text(
              'At ${SharedConstants.Brand_Name}, your privacy and satisfaction are our top priorities. To ensure your concerns are addressed promptly, we have appointed a dedicated Grievance Officer. If you have any issues or grievances regarding your personal information or our services, please do not hesitate to reach out.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 10),
            _buildSubSectionTitle('Contact Our Grievance Officer', context),
            Text(
              '\n${prefs.getString(SharedConstants.CONTACT_US_NUMBER)??""}\n\n${prefs.getString(SharedConstants.CONTACT_US_EMAIL)??""}\n\n${SharedConstants.Company_Address}',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Changes to this Privacy Policy', context),
            Text(
              'We may update this Privacy Policy from time to time. We will notify you of any significant changes by posting the new Privacy Policy on our website.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style:
          TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.titleMedium!.color),
    );
  }

  Widget _buildSubSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.titleMedium!.color),
    );
  }
}
