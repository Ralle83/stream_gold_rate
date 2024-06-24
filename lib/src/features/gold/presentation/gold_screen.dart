import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GoldScreen extends StatelessWidget {
  const GoldScreen({super.key});
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
              Text('Live Kurs:',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),
              // Verwendung eines StreamBuilders für den Goldpreis
              StreamBuilder<double>(
                stream: getGoldPriceStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Fehler beim Laden des Goldpreises.',
                        style: TextStyle(color: Colors.red));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return Text(
                    NumberFormat.simpleCurrency(locale: 'de_DE')
                        .format(snapshot.data),
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Image(
          image: AssetImage('assets/bars.png'),
          width: 100,
        ),
        Text('Gold', style: Theme.of(context).textTheme.headlineLarge),
      ],
    );
  }

  // Annahme: Diese Funktion liefert einen Stream von Goldpreisen
  Stream<double> getGoldPriceStream() {
    // Dies ist ein Beispielstream, der jede Sekunde einen neuen Preis ausgibt
    return Stream.periodic(Duration(seconds: 1), (x) => (x * 2 + 69.22))
        .map((x) => x.toDouble());
  }
}
