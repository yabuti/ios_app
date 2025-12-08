import 'package:carsbnb/data/model/home/home_model.dart';
import 'package:carsbnb/utils/constraints.dart';
import 'package:carsbnb/utils/language_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/wishlist/wishlist_cubit.dart';
import '../../../logic/cubit/wishlist/wishlist_state.dart';
import '../../../logic/cubit/wishlist/wishlist_state_model.dart';
import '../../../utils/k_images.dart';
import '../../../utils/utils.dart';
import '../../../widgets/custom_image.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/fetch_error_text.dart';
import '../../../widgets/loading_widget.dart';
import '../../../widgets/please_signin_widget.dart';
import '../home/components/popular_card.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  late WishlistCubit wishlistCubit;

  @override
  void initState() {
    wishlistCubit = context.read<WishlistCubit>();
    wishlistCubit.getWishlist();
    super.initState();
  }

  final _scrollController = ScrollController();

  @override
  void dispose() {
    if (wishlistCubit.state.initialPage > 1) {
      wishlistCubit.initPage();
    }
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    debugPrint('scrolling-called');
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0.0) {
        if (wishlistCubit.state.isListEmpty == false) {
          wishlistCubit.getWishlist();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar:  CustomAppBar(
      //   title: Utils.translatedText(context, Language.wishlist),
      //   visibleLeading: false,
      //   titleCenter: true,
      // ),
      body: Utils.logout(
        child: BlocConsumer<WishlistCubit, WishlistStateModel>(
            listener: (context, state) {
          final wishlist = state.wishlistState;
          if (wishlist is WishlistStateError) {
            if (wishlist.statusCode == 503 ||
                wishlistCubit.wishlistModel == null) {
              Utils.errorSnackBar(context, wishlist.message);
            }
            if (wishlist.statusCode == 401) {
              Utils.logoutFunction(context);
            }
          }
        }, builder: (context, state) {
          final wishlist = state.wishlistState;
          if (wishlist is WishlistStateLoading) {
            return const LoadingWidget();
          } else if (wishlist is WishlistStateError) {
            if (wishlist.statusCode == 503 ||
                wishlistCubit.wishlistModel != null) {
              return LoadedData(data: wishlistCubit.wishlistModel!);
            } else if (wishlist.statusCode == 401) {
              return const PleaseLoginFirst();
            } else {
              return FetchErrorText(text: wishlist.message);
            }
          } else if (wishlist is WishlistStateLoaded) {
            return LoadedData(data: wishlist.wishlistModel);
          }
          if (wishlistCubit.wishlistModel != null) {
            return LoadedData(data: wishlistCubit.wishlistModel!);
          } else {
            return const FetchErrorText(text: 'Something went wrong');
          }
        }),
      ),
    );
  }
}

class LoadedData extends StatelessWidget {
  const LoadedData({
    super.key,
    required this.data,
  });

  final List<FeaturedCars> data;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double childAspectRatio = size.width / (size.height / 1.47);
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000012),
            blurRadius: 30,
            offset: Offset(0, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            surfaceTintColor: scaffoldBgColor,
            backgroundColor: Colors.transparent,
            toolbarHeight: Utils.vSize(50.0),
            centerTitle: true,
            title: CustomText(
              text: Utils.translatedText(context, Language.wishlist),
              fontSize: 22.0,
              fontWeight: FontWeight.w700,
              color: blackColor,
            ),
          ),
          if (data.isNotEmpty) ...[
            SliverPadding(
              padding:
                  Utils.only(left: 20.0, right: 20.0, bottom: 20.0, top: 10.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: childAspectRatio,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final wish = data[index];
                    return PopularCarCard(
                      cars: wish,
                    );
                  },
                  childCount: data.length,
                ),
              ),
            ),
          ] else ...[
            SliverToBoxAdapter(
                child: Column(
              children: [
                Utils.verticalSpace(size.height *0.2),
                const CustomImage(
                  path: KImages.emptyImage,
                  height: 150,
                ),
                Utils.verticalSpace(20.0),
                CustomText(
                  text: Utils.translatedText(context, Language.noWishlistItem),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ],
            )),
          ]
        ],
      ),
    );
  }
}
