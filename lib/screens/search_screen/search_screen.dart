// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_progress_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/custom_app_bar.dart';
import '../../components/custom_rect_button.dart';
import '../../constants/constants.dart';
import '../../constants/params_constants.dart';
import '../../models/category_model.dart';
import '../../services/database_services.dart';
import '../../utils/methods/reusable_methods.dart';
import '../details/detail_screen.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _databaseService = DatabaseService();
  late TextEditingController _searchController;
  late FocusNode _searchFocus;
  late Future resultLoaded;
  List _categoryList = [];
  List _resultList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _categoryList.clear();
    _searchController = TextEditingController();
    _searchFocus = FocusNode();
    resultLoaded = getCategoriesStreamSnapShot();
    _searchController.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    searchResultList();
    debugPrint(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocus.dispose();
    _categoryList.clear();
    _resultList.clear();
    super.dispose();
  }

  searchResultList() {
    var showResult = [];
    if (_searchController.text.isNotEmpty) {
      for (var cat in List.from(_categoryList)) {
        String catName = cat[paramName].toString().toLowerCase();
        if (catName.contains(_searchController.text.toLowerCase())) {
          showResult.add(cat);
        }
      }
    } else {
      showResult = _categoryList;
    }
    setState(() {
      _resultList = showResult;
    });
  }

  getCategoriesStreamSnapShot() async {
    setState(() {
      isLoading = true;
    });
    try {
      _categoryList.clear();
      for (int i = 0; i < allCategoriesCollectionList.length; i++) {
        var data = await FirebaseFirestore.instance
            .collection('categories')
            .doc('products')
            .collection(allCategoriesCollectionList.elementAt(i).toString())
            .get();
        setState(() {
          _categoryList += data.docs;
        });
      }
      searchResultList();
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      _scaffoldKey.currentState
          ?.showSnackBar(showSnackBar(content: 'not getting categories!'));
    }

    return 'completed';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(context),
      body: Column(
        children: [
          _searchTextField(),
          isLoading ? const CustomProgressIndicator() : _gridView(size),
        ],
      ),
    );
  }

  CustomAppBar _appBar(BuildContext context) => CustomAppBar(
        title: 'Search',
        actionIcon: null,
        leadingIcon: CupertinoIcons.back,
        onActionIconPressed: null,
        onLeadingIconPressed: () => Navigator.pop(context),
      );

  Padding _searchTextField() => Padding(
        padding: kAllPadding,
        child: Container(
          decoration: kBoxShadow,
          child: Card(
            elevation: 0,
            child: _textField(),
          ),
        ),
      );

  TextField _textField() => TextField(
        controller: _searchController,
        focusNode: _searchFocus,
        onSubmitted: (val) {
          _searchFocus.unfocus();
        },
        cursorColor: Colors.black,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            CupertinoIcons.search,
            size: kIconSize,
            color: Colors.grey,
          ),
          hintText: 'Search',
          focusedBorder: _underlineInputBorder(),
          enabledBorder: _underlineInputBorder(),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      );

  Flexible _gridView(Size size) => Flexible(
        child: Padding(
          padding: kSymmetricPaddingHor,
          child: GridView.builder(
            shrinkWrap: true,
            physics: kPhysics,
            scrollDirection: Axis.vertical,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              mainAxisExtent: size.height * 0.35,
            ),
            itemCount: _resultList.length,
            itemBuilder: (BuildContext context, int index) {
              return _categoryItemGrid(context, index, size);
            },
          ),
        ),
      );

  GestureDetector _categoryItemGrid(
          BuildContext context, int index, Size size) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailScreen(_resultList[index])));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _imageAndAddToCartButton(index, context, size),
            _categoryDetailsListTile(index, context),
          ],
        ),
      );

  Flexible _imageAndAddToCartButton(
          int index, BuildContext context, Size size) =>
      Flexible(
        child: Stack(
          children: [
            _image(index, size),
            _addToCartButton(index, context),
          ],
        ),
      );

  Hero _image(int index, Size size) => Hero(
        tag: _resultList[index][paramUrl],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            _resultList[index][paramUrl],
            fit: BoxFit.fill,
            width: double.maxFinite,
            height: size.height * 0.25,
          ),
        ),
      );

  Positioned _addToCartButton(int index, BuildContext context) => Positioned(
        right: 4,
        bottom: 4,
        child: CustomRectButton(
          width: 42,
          height: 42,
          icon: CupertinoIcons.cart_fill,
          onPressed: () async {
            try {
              await _databaseService.addToCart(
                Categories(
                  name: _resultList[index][paramName],
                  url: _resultList[index][paramUrl],
                  desc: _resultList[index][paramDesc],
                  star: _resultList[index][paramStar].toString(),
                  category: _resultList[index][paramCategory],
                  price: _resultList[index][paramPrice].toString(),
                  itemCount: 1,
                ),
                _scaffoldKey,
              );
            } catch (e) {
              _scaffoldKey.currentState?.showSnackBar(
                  showSnackBar(content: 'Failed to add into cart!'));
            }
          },
          color: Colors.black38,
          iconColor: Colors.white,
        ),
      );

  Column _categoryDetailsListTile(int index, BuildContext context) => Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            dense: true,
            title: _nameText(index),
            subtitle: _priceText(index),
            trailing: _addToFavButton(index, context),
          ),
        ],
      );

  Text _nameText(int index) => Text(
        _resultList[index][paramName],
        style: kViewTitleStyle,
        maxLines: 2,
        overflow: TextOverflow.fade,
      );

  Text _priceText(int index) => Text(
        '\$ ${_resultList[index][paramPrice]}',
        style: kViewSubTitleStyle,
      );

  IconButton _addToFavButton(int index, BuildContext context) => IconButton(
        onPressed: () async {
          try {
            await _databaseService.addToFavourites(
              Categories(
                name: _resultList[index][paramName],
                url: _resultList[index][paramUrl],
                desc: _resultList[index][paramDesc],
                star: _resultList[index][paramStar].toString(),
                category: _resultList[index][paramCategory],
                price: _resultList[index][paramPrice].toString(),
                itemCount: 1,
              ),
              _scaffoldKey,
            );
          } catch (e) {
            _scaffoldKey.currentState?.showSnackBar(
                showSnackBar(content: 'Failed to add into favourites!'));
          }
        },
        icon: const Icon(
          CupertinoIcons.heart,
          size: 22,
        ),
      );

  UnderlineInputBorder _underlineInputBorder() => const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      );
}
