import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/shared_constants.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Terms and Conditions',
          style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Welcome to the ${SharedConstants.Brand_Name} website, operated by ${SharedConstants.Company_Name} ("we", "us", "our"). By accessing or using our website ("Site") and services ("Services"), you agree to be bound by the following terms and conditions ("Terms"). Please read them carefully.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Acceptance of Terms', context),
            Text(
              'By accessing or using the Site and Services, you agree to comply with these Terms. If you do not agree with any part of these Terms, you may not use the Site and Services.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Eligibility', context),
            Text(
              'You must be at least 18 years old and a resident of India to use the Site and Services. You must have a valid bank account in India.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Loan Application', context),
            Text(
              'You may apply for loans ranging from ₹5,000 to ₹1,00,000 through the Site. The repayment period for the loan can be up to 40 days. The monthly interest rate for loans is up to 30%. All applications are subject to approval based on our assessment criteria.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Loan Approval and Disbursement', context),
            Text(
              'Once your loan application is approved, the loan amount will be credited to your designated bank account. Approval and disbursement times may vary based on the completeness and accuracy of your application and documents.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Repayment Terms', context),
            Text(
              'You agree to repay the loan amount along with applicable interest in accordance with the repayment schedule provided in your loan agreement. Failure to repay on time may result in additional charges, legal actions, and may affect your credit score.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Interest and Fees', context),
            Text(
              'The interest rate for the loan will be up to 3% per month. The Annual Percentage Rate (APR) will be calculated as the monthly interest rate annualized. No hidden fees will be charged; all applicable fees and charges will be clearly disclosed during the application process.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('User Obligations', context),
            Text(
              'You agree to provide accurate and complete information during the registration and loan application process. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Prohibited Activities', context),
            Text(
              'You agree not to engage in any fraudulent activities or provide false information. You agree not to use the Site and Services for any illegal or unauthorized purpose.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Privacy Policy', context),
            Text(
              'Our Privacy Policy outlines how we collect, use, and protect your personal information. By using the Site and Services, you agree to our Privacy Policy.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Intellectual Property', context),
            Text(
              'All content on the Site, including text, graphics, logos, and images, is the property of ${SharedConstants.Company_Name} or its content suppliers and is protected by intellectual property laws. You may not use, reproduce, or distribute any content from the Site without our prior written permission.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Modification of Terms', context),
            Text(
              'We reserve the right to modify these Terms at any time. Any changes will be effective immediately upon posting on the Site. Your continued use of the Site and Services after the changes constitutes your acceptance of the revised Terms.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Termination', context),
            Text(
              'We may terminate or suspend your access to the Site and Services at any time, without prior notice or liability, for any reason, including if you breach these Terms.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Limitation of Liability', context),
            Text(
              'To the maximum extent permitted by law, ${SharedConstants.Company_Name} shall not be liable for any indirect, incidental, special, or consequential damages arising out of or in connection with your use of the Site and Services.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Governing Law', context),
            Text(
              'These Terms shall be governed by and construed in accordance with the laws of India. Any disputes arising under these Terms shall be subject to the exclusive jurisdiction of the courts located in New Delhi, India.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Data Deletion Policy', context),
            Text(
              'At ${SharedConstants.Brand_Name}, we value your privacy and are committed to ensuring your personal data is handled securely and responsibly. If you wish to delete your account and personal data, please follow the steps outlined in this section.',
              style: TextStyle(fontSize: 16, color: Theme.of(context).textTheme.titleMedium!.color),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle('Contact Us', context),
            Text(
              '${SharedConstants.Company_Name}\n'
              '${prefs.getString(SharedConstants.CONTACT_US_EMAIL)??""}\n'
              '${prefs.getString(SharedConstants.CONTACT_US_NUMBER)??""}',
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
}
