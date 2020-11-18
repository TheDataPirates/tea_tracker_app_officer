import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teatrackerappofficer/providers/authentication/auth_provider.dart';
import 'package:teatrackerappofficer/providers/withering/withering_mixing_provider.dart';
import 'package:teatrackerappofficer/widgets/withering_mixing_item.dart';

class VasWitheringMixingScreen extends StatefulWidget {
  @override
  _VasWitheringMixingScreenState createState() => _VasWitheringMixingScreenState();
}

class _VasWitheringMixingScreenState extends State<VasWitheringMixingScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    final token = auth.token;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Withering Mixing View'),
      ),
      body: FutureBuilder(
        future: Provider.of<WitheringMixingProvider>(context, listen: false)
            .fetchAndSetWitheringMixingItem(token),
        builder: (ctx, snapshot) =>
        snapshot.connectionState == ConnectionState.waiting
            ? Center(
          child: CircularProgressIndicator(),
        )
            : Consumer<WitheringMixingProvider>(
          child: Center(
            child: const Text(
                'Got no Withering mixing items!'),
          ),
          builder: (ctx, WitheringMixingProvider, ch) =>
          WitheringMixingProvider.witheringMixingItems.length <= 0
              ? ch
              : ListView.builder(
            itemCount: WitheringMixingProvider
                .witheringMixingItems.length,
            itemBuilder: (ctx, i) => WitheringMixingItem(
              id: WitheringMixingProvider
                  .witheringMixingItems[i].id,
              troughNumber: WitheringMixingProvider
                  .witheringMixingItems[i].troughNumber,
              turn: WitheringMixingProvider
                  .witheringMixingItems[i].turn,
              time: WitheringMixingProvider
                  .witheringMixingItems[i].time,
              temperature: WitheringMixingProvider
                  .witheringMixingItems[i].temperature,
              humidity: WitheringMixingProvider
                  .witheringMixingItems[i].humidity,
            ),
          ),
        ),
      ),
    );
  }
}



