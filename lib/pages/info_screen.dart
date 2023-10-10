import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Power Monitor',
        ),
        backgroundColor: const Color(0xFF44BAC2),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Empowering You to Make Informed Choices',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            _buildSectionTitle('The Importance of Energy Monitoring'),
            _buildParagraph(
              'Monitoring your energy consumption is the first step towards reducing waste and making smarter energy decisions. By understanding how and when you use electricity, you can identify areas where you can optimize your usage and save on your utility bills.',
              indent: 5,
            ),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Real-Time Data Visualization'),
            _buildParagraph(
              'Our app provides real-time data visualization of your power usage. Through intuitive graphs and charts, you can easily track and analyze your energy consumption patterns over time. This enables you to identify peak usage hours, recognize energy-hungry appliances, and adjust your habits accordingly.',
              indent: 5,
            ),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Tips for Energy Efficiency'),
            _buildParagraph(
              'Discover practical tips and recommendations on how to maximize energy efficiency in your daily life. From simple actions like switching to energy-efficient light bulbs to more advanced strategies like scheduling appliance usage during off-peak hours, we provide actionable insights to help you reduce your environmental footprint.',
              indent: 5,
            ),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Understanding Your Billing'),
            _buildParagraph(
              'We demystify your energy bills, explaining the various components and how they contribute to the overall cost. Learn about kilowatt-hours (kWh), tariff rates, and how different appliances impact your monthly bill. With this knowledge, you can make conscious decisions to minimize wasteful consumption and optimize your spending.',
              indent: 5,
            ),
            const SizedBox(height: 16.0),
            _buildSectionTitle('Environmental Impact'),
            _buildParagraph(
              'Gain a deeper understanding of how your energy consumption impacts the environment. Learn about carbon emissions associated with different energy sources and how your individual actions can contribute to climate change. Discover ways to reduce your carbon footprint and promote a greener future for generations to come.',
              indent: 5,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Color(0xFF44BAC2),
        ),
      ),
    );
  }

  Widget _buildParagraph(String text, {int indent = 0}) {
    return Text(
      '${' ' * indent}$text',
      textAlign: TextAlign.justify,
      style: const TextStyle(
        fontSize: 14,
        color: Colors.black,
      ),
    );
  }
}
