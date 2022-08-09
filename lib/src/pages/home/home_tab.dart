import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
// import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;
import 'package:greengrocer/src/config/custom_colors.dart';
import '../../services/utils_services.dart';
import 'components/category_tile.dart';
import 'components/item_tile.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late String selectedCategory = 'Frutas';

  GlobalKey<CartIconKey> globalKeyCartItems = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCardAnimation;

  void itemSelectedCartAnimations(GlobalKey gkImage) {
    runAddToCardAnimation(gkImage);
  }

  final UtilsServices utilsServices = UtilsServices();

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      gkCart: globalKeyCartItems,
      // rotation: true,
      // dragToCardCurve: Curves.easeInCirc,
      // dragToCardDuration: const Duration(milliseconds: 1000),
      // previewCurve: Curves.linearToEaseOut,
      previewCurve: Curves.ease,
      previewDuration: const Duration(milliseconds: 500),
      // previewHeight: 30,
      // previewWidth: 30,
      // opacity: 0.85,
      receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
        runAddToCardAnimation = addToCardAnimationMethod;
      },
      child: Scaffold(
        //!AppBar
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 30,
              ),
              children: [
                TextSpan(
                  text: 'Green',
                  style: TextStyle(
                    color: CustomColors.customSwatchColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'grocer',
                  style: TextStyle(
                    color: CustomColors.customContrastColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, right: 16.0),
              child: AddToCartIcon(
                key: globalKeyCartItems,
                icon: Icon(
                  Icons.shopping_cart,
                  color: CustomColors.customSwatchColor,
                ),
                colorBadge: CustomColors.customContrastColor,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 15.0, right: 15.0),
            //   child: GestureDetector(
            //     onTap: () {},
            //     child: Badge(
            //       badgeColor: CustomColors.customContrastColor,
            //       badgeContent: const Text(
            //         '2',
            //         style: TextStyle(
            //           color: Colors.white,
            //         ),
            //       ),
            //       child: AddToCartIcon(
            //         key: globalKeyCartItems,
            //         icon: Icon(
            //           Icons.shopping_cart,
            //           color: CustomColors.customSwatchColor,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),

        body: Column(
          children: [
            //!Campo de Pesquisa
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  hintText: 'Pesquise aqui...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: CustomColors.customContrastColor,
                    size: 21,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(60),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),

            //!Categorias
            Container(
              padding: const EdgeInsets.only(left: 25.0),
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) {
                  return CategoryTile(
                    category: app_data.categories[index],
                    isSelected: app_data.categories[index] == selectedCategory,
                    onPressed: () {
                      setState(() {
                        selectedCategory = app_data.categories[index];
                      });
                    },
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(width: 10),
                itemCount: app_data.categories.length,
              ),
            ),
            //!grid
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 9 / 11.5,
                ),
                itemCount: app_data.items.length,
                itemBuilder: (_, index) {
                  return ItemTile(
                    item: app_data.items[index],
                    cartAnimationMethod: itemSelectedCartAnimations,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
