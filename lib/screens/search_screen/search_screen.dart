import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decor/components/custom_app_bar.dart';
import 'package:decor/components/custom_rect_button.dart';
import 'package:decor/constants/constants.dart';
import 'package:decor/models/category_model.dart';
import 'package:decor/screens/details/detail_screen.dart';
import 'package:decor/services/database_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  final List<String> _categoryCollection = [
    'lamps',
    'stands',
    'desks',
    'armchairs',
    'beds',
    'chairs',
    'sofas',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocus = FocusNode();

    _searchController.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    searchResultList();
    print(_searchController.text);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultLoaded = getCategoriesStreamSnapShot();
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
        String catName = cat['name'].toString().toLowerCase();
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
      for (int i = 0; i < _categoryCollection.length; i++) {
        var data = await FirebaseFirestore.instance
            .collection('categories')
            .doc('products')
            .collection(_categoryCollection.elementAt(i).toString())
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
      _scaffoldKey.currentState?.showSnackBar(
          showSnackBar(content: 'not getting categories!', color: Colors.red));
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
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.black))
              : _gridView(size),
        ],
      ),
    );
  }

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

  IconButton _addToFavButton(int index, BuildContext context) => IconButton(
        onPressed: () async {
          try {
            await _databaseService.addToFavourites(
              Categories(
                name: _resultList[index]['name'],
                url: _resultList[index]['url'],
                desc: _resultList[index]['desc'],
                star: _resultList[index]['star'].toString(),
                category: _resultList[index]['category'],
                price: _resultList[index]['price'].toString(),
                itemCount: 1,
              ),
              _scaffoldKey,
            );
          } catch (e) {
            _scaffoldKey.currentState?.showSnackBar(showSnackBar(
                content: 'Failed to add into favourites!', color: Colors.red));
          }
        },
        icon: const Icon(
          CupertinoIcons.heart,
          size: 22,
        ),
      );

  Text _priceText(int index) => Text(
        '\$ ${_resultList[index]['price']}',
        style: kViewSubTitleStyle,
      );

  Text _nameText(int index) => Text(
        _resultList[index]['name'],
        style: kViewTitleStyle,
        maxLines: 2,
        overflow: TextOverflow.fade,
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
                  name: _resultList[index]['name'],
                  url: _resultList[index]['url'],
                  desc: _resultList[index]['desc'],
                  star: _resultList[index]['star'].toString(),
                  category: _resultList[index]['category'],
                  price: _resultList[index]['price'].toString(),
                  itemCount: 1,
                ),
                _scaffoldKey,
              );
            } catch (e) {
              _scaffoldKey.currentState?.showSnackBar(showSnackBar(
                  content: 'Failed to add into cart!', color: Colors.red));
            }
          },
          color: Colors.black38,
          iconColor: Colors.white,
        ),
      );

  ClipRRect _image(int index, Size size) => ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          _resultList[index]['url'],
          fit: BoxFit.fill,
          width: double.maxFinite,
          height: size.height * 0.25,
        ),
      );

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

  UnderlineInputBorder _underlineInputBorder() => const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      );
}
