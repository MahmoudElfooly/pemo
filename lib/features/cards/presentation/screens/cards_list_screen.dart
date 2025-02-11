import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pemo/features/cards/domain/useCase/card_use_case.dart';
import 'package:pemo/features/cards/presentation/cubit/card_cubit.dart';
import 'package:pemo/features/cards/presentation/cubit/card_states.dart';
import 'package:pemo/features/cards/presentation/screens/create_card_screen.dart';

import '../../../../core/servicesLocator/services_locator.dart';
import '../widgets/card_widget.dart';

class CardsPage extends StatelessWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardCubit(locator<CardUseCase>())..loadCards(),
      child: Builder(builder: (context) {
        final cardCubit = context.read<CardCubit>();
        return Scaffold(
          appBar: AppBar(title: Text('Cards')),
          body: BlocBuilder<CardCubit, CardStates>(
            builder: (context, state) {
              if (state is CardLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CardEmpty) {
                return const Center(child: Text('No Cards found.'));
              } else if (state is CardError) {
                return Center(child: Text(state.message));
              } else if (state is CardLoaded) {
                final cards = state.Cards;
                return ListView.builder(
                  itemCount: cards.length,
                  itemBuilder: (context, index) {
                    final card = cards[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CardWidget(card: card),
                    );
                  },
                );
              }
              return const Center(child: Text('Unknown state'));
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final isUpdated = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateCardPage()),
              );
              if (isUpdated == true) {
                cardCubit.loadCards();
              }
            },
            child: const Icon(Icons.add),
          ),
        );
      }),
    );
  }
}
