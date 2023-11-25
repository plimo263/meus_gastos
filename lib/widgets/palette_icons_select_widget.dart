import 'package:flutter/material.dart';
import 'package:meus_gastos/utils/app_snackbar.dart';

final Map<String, Map<String, List<int>>> allIcons = {
  'Aba 1': {
    'Automóvel': [
      Icons.car_rental.codePoint,
      Icons.car_repair.codePoint,
      Icons.local_car_wash.codePoint,
      Icons.local_shipping.codePoint,
      Icons.airport_shuttle.codePoint,
      Icons.build.codePoint,
      Icons.sports_motorsports.codePoint,
      Icons.two_wheeler.codePoint,
      Icons.handyman.codePoint,
      Icons.local_gas_station.codePoint,
      Icons.build_outlined.codePoint,
      Icons.engineering.codePoint,
      Icons.emoji_transportation.codePoint,
      Icons.directions_car.codePoint,
      Icons.delivery_dining.codePoint,
      Icons.pedal_bike.codePoint,
      Icons.electric_car.codePoint,
    ],
    'Casa': [
      Icons.propane.codePoint,
      Icons.gas_meter.codePoint,
      Icons.heat_pump.codePoint,
      Icons.wind_power.codePoint,
      Icons.solar_power.codePoint,
      Icons.electric_bolt.codePoint,
      Icons.sensor_door.codePoint,
      Icons.table_bar.codePoint,
      Icons.camera_outdoor.codePoint,
      Icons.chair_alt.codePoint,
      Icons.blender.codePoint,
      Icons.coffee_maker.codePoint,
      Icons.light.codePoint,
      Icons.shower.codePoint,
      Icons.bed.codePoint,
      Icons.carpenter.codePoint,
      Icons.house_siding.codePoint,
      Icons.gite.codePoint,
      Icons.bathtub.codePoint,
      Icons.checkroom.codePoint,
      Icons.house.codePoint,
      Icons.cell_wifi.codePoint,
      Icons.tungsten.codePoint,
      Icons.tv.codePoint,
      Icons.desktop_mac.codePoint,
      Icons.tablet_mac.codePoint,
      Icons.phone_android.codePoint,
      Icons.router.codePoint,
      Icons.format_paint.codePoint,
      Icons.format_color_fill.codePoint,
    ],
  },
  'Aba 2': {
    'Saúde': [
      Icons.vaccines.codePoint,
      Icons.personal_injury.codePoint,
      Icons.medical_services.codePoint,
      Icons.masks.codePoint,
      Icons.healing.codePoint,
      Icons.medical_information.codePoint,
      Icons.medication_liquid.codePoint,
      Icons.local_hospital.codePoint,
      Icons.emergency.codePoint,
    ],
    'Familia': [
      Icons.family_restroom.codePoint,
      Icons.group.codePoint,
      Icons.child_friendly.codePoint,
      Icons.child_care.codePoint,
      Icons.pregnant_woman.codePoint,
      Icons.stroller.codePoint,
      Icons.bedroom_baby.codePoint,
      Icons.toys.codePoint,
      Icons.smart_toy.codePoint,
    ],
    'Educacao': [
      Icons.school.codePoint,
      Icons.cast_for_education.codePoint,
      Icons.history_edu.codePoint,
      Icons.departure_board.codePoint,
      Icons.menu_book.codePoint,
    ],
    'Lazer': [
      Icons.beach_access.codePoint,
      Icons.pool.codePoint,
      Icons.surfing.codePoint,
      Icons.kitesurfing.codePoint,
      Icons.water.codePoint,
      Icons.kayaking.codePoint,
    ],
    'Esportes': [
      Icons.sports_tennis.codePoint,
      Icons.golf_course.codePoint,
      Icons.sports_baseball.codePoint,
      Icons.sports_volleyball.codePoint,
      Icons.sports_football.codePoint,
      Icons.sports_soccer.codePoint,
      Icons.sports_rugby.codePoint,
      Icons.sailing.codePoint,
      Icons.phishing.codePoint,
    ],
  },
  'Aba 3': {
    'Contas': [
      Icons.gas_meter.codePoint,
      Icons.water_drop.codePoint,
      Icons.shower.codePoint,
      Icons.lightbulb.codePoint,
      Icons.tungsten.codePoint,
      Icons.emoji_objects.codePoint,
      Icons.receipt.codePoint,
      Icons.receipt_long.codePoint,
      Icons.signal_wifi_4_bar.codePoint,
      Icons.router.codePoint,
      Icons.four_g_mobiledata.codePoint,
      Icons.solar_power.codePoint,
    ],
    'Alimentação': [
      Icons.restaurant.codePoint,
      Icons.restaurant_menu.codePoint,
      Icons.cake.codePoint,
      Icons.lunch_dining.codePoint,
      Icons.local_cafe.codePoint,
      Icons.fastfood.codePoint,
      Icons.local_bar.codePoint,
      Icons.liquor.codePoint,
      Icons.ramen_dining.codePoint,
      Icons.local_pizza.codePoint,
      Icons.dinner_dining.codePoint,
      Icons.icecream.codePoint,
      Icons.nightlife.codePoint,
      Icons.set_meal.codePoint,
      Icons.soup_kitchen.codePoint,
    ],
    'Compras': [
      Icons.shopping_cart.codePoint,
      Icons.redeem.codePoint,
      Icons.shop.codePoint,
      Icons.phone_android.codePoint,
      Icons.tablet_mac.codePoint,
      Icons.laptop_mac.codePoint,
      Icons.watch.codePoint,
      Icons.desktop_mac.codePoint,
      Icons.headset_mic.codePoint,
      Icons.local_movies.codePoint,
    ],
    'Transporte': [
      Icons.local_airport.codePoint,
      Icons.directions_bus.codePoint,
      Icons.local_taxi.codePoint,
      Icons.train.codePoint,
      Icons.subway.codePoint,
    ],
    'Outros': [
      Icons.payments.codePoint,
      Icons.account_balance.codePoint,
      Icons.savings.codePoint,
      Icons.sell.codePoint,
      Icons.currency_exchange.codePoint,
      Icons.pix.codePoint,
      Icons.money.codePoint,
      Icons.phone.codePoint,
      Icons.storage.codePoint,
    ]
  }
};

class PaletteIconsSelectWidget extends StatefulWidget {
  const PaletteIconsSelectWidget({Key? key}) : super(key: key);

  @override
  State<PaletteIconsSelectWidget> createState() =>
      _PaletteIconsSelectWidgetState();
}

class _PaletteIconsSelectWidgetState extends State<PaletteIconsSelectWidget>
    with SingleTickerProviderStateMixin {
  late final TabController controller;
  int? _iconSeleted;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: allIcons.length,
      initialIndex: 0,
      vsync: this,
    );
  }

  void onTapIcon(int iconSelected) {
    setState(() {
      _iconSeleted = iconSelected;
    });
  }

  /// Retorna a cor escolhida pelo usuário
  void onSaveColor() {
    if (_iconSeleted != null) {
      Navigator.of(context).pop(_iconSeleted);
    } else {
      AppSnackBar().snack('Escolha um ícone');
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [];

    /// Separa as áreas em lista de widgets
    for (String keyPage in allIcons.keys) {
      pages.add(_PaletteIconPage(
        icons: allIcons[keyPage]!,
        iconSelection: _iconSeleted,
        onTap: onTapIcon,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paleta de ícones'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            TabBarView(
              controller: controller,
              children: pages,
            ),
            Positioned(
              bottom: 24,
              child: TabPageSelector(
                controller: controller,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _iconSeleted != null
          ? FloatingActionButton(
              tooltip: 'Salvar o ícone escolhido',
              onPressed: onSaveColor,
              child: const Icon(
                Icons.save,
              ),
            )
          : null,
    );
  }
}

// Lista com a variacao de cores.
class _PaletteIconPage extends StatelessWidget {
  final Map<String, List<int>> icons;
  final int? iconSelection;
  final void Function(int colorSelect) onTap;
  const _PaletteIconPage({
    Key? key,
    required this.icons,
    required this.onTap,
    required this.iconSelection,
  }) : super(key: key);

  Color getColorIcon() {
    return Colors.black87;
  }

  Color getBackgroundIcon() {
    return Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final keyIcons = icons.keys.toList();
    final widthLarge = MediaQuery.of(context).size.width / 10 - 8;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 72),
      itemCount: keyIcons.length,
      itemBuilder: ((context, index) {
        final iconName = keyIcons[index];
        final iconOptions = icons[iconName]!;
        final childrens = <Widget>[];
        //
        for (int value in iconOptions) {
          childrens.add(InkWell(
            onTap: () {
              onTap(value);
            },
            child: CircleAvatar(
              backgroundColor: value == iconSelection
                  ? getBackgroundIcon()
                  : Colors.grey.shade300,
              maxRadius: widthLarge,
              child: Icon(
                IconData(value, fontFamily: 'MaterialIcons'),
                size: widthLarge,
                color: value == iconSelection ? Colors.white : getColorIcon(),
              ),
            ),
          ));
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              iconName,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Wrap(
              runSpacing: 4.0,
              spacing: 4.0,
              children: childrens,
            )
          ],
        );
      }),
    );
  }
}
