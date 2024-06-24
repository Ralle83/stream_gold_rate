import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Package für die Formatierung der Währung

class GoldScreen extends StatelessWidget {
  const GoldScreen({super.key});

StreamBuilder(
            stream: randomNumberStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done ||
                  snapshot.connectionState == ConnectionState.active) {
                // FALL 1: Future ist komplett und hat Daten!
                final response = snapshot.data;

                return Text("Die Zahl ist: $response");
              } else if (snapshot.connectionState != ConnectionState.done) {
                // FALL 2: Sind noch im Ladezustand
                return const CircularProgressIndicator();
              } else {
                // FALL 3: Es gab nen Fehler
                return const Icon(Icons.error);
              }
            },
          ),
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              Text('Live Kurs:', style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              StreamBuilder<double>(
                stream: getGoldPriceStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData) {
                    return const Text('Keine Daten verfügbar');
                  } else {
                    double goldPrice = snapshot.data!;
                    return Text(
                      NumberFormat.simpleCurrency(locale: 'de_DE').format(gold​⬤