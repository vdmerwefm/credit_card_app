import 'package:credit_card/views/configurations/bloc/configurations_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationsBloc, ConfigurationsState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            centerTitle: true,
            elevation: 0,
            title: const Text(
              'Cardify: Banned list',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 28,
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 32, right: 32, top: 16),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.bannedCountries.length,
                itemBuilder: (context, index) {
                  final item = state.bannedCountries[index];
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: Dismissible(
                      key: Key(item.country),
                      child: Card(
                        elevation: 1,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: ListTile(
                          isThreeLine: true,
                          trailing: const Icon(
                            Icons.add_location_alt_outlined,
                            color: Colors.lightBlueAccent,
                            size: 32,
                          ),
                          title: Text(item.country),
                          subtitle: const Text(
                            'No longer a selectable country,'
                            '                       '
                            '                       '
                            'slide to re-enable',
                          ),
                        ),
                      ),
                      onDismissed: (direction) =>
                          context.read<ConfigurationsBloc>().add(
                                UnbanCountryEvent(
                                  state.bannedCountries[index],
                                ),
                              ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
