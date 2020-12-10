import 'package:flutter/material.dart';

Color bgColor = Color(0xfff5f5f5);

class Categories {
  final String title;
  final int id;
  final List<SubCategories> subCat;

  Categories({this.title, this.id, this.subCat});
}

class SubCategories {
  final String title;
  final int id;

  SubCategories({this.title, this.id});
}

List<Categories> categories = [
  Categories(
    title: 'Organic',
    id: 0,
    subCat: [
      SubCategories(id: 0, title: 'Plant Growth Promoter'),
      SubCategories(id: 1, title: 'Organic Fertilizer'),
      SubCategories(id: 2, title: 'Organic Pesticides'),
      SubCategories(id: 3, title: 'Organic Fungicides'),
      SubCategories(id: 4, title: 'Viricides'),
      SubCategories(id: 5, title: 'Waste Decomposer'),
    ],
  ),
  Categories(
    title: 'Remedies',
    id: 1,
    subCat: [
      SubCategories(id: 0, title: "Bio Pesticides"),
      SubCategories(id: 1, title: "Insecticides"),
      SubCategories(id: 2, title: "Herbicides/Weedicide"),
      SubCategories(id: 3, title: "Plant Growth Promoter"),
      SubCategories(id: 4, title: "Fungicides"),
      SubCategories(id: 5, title: "Sticking/Wetting Agent"),
      SubCategories(id: 6, title: "Neem Oil"),
      SubCategories(id: 7, title: "Disinfectant & Sanitation"),
      SubCategories(id: 8, title: "Animal Repellent"),
    ],
  ),
  Categories(
    title: 'Seeds',
    id: 2,
    subCat: [
      SubCategories(id: 0, title: "Research"),
      SubCategories(id: 1, title: "Hybrid"),
      SubCategories(id: 2, title: "Brinjal and Bhindi"),
      SubCategories(id: 3, title: "Tomato and Chilli"),
      SubCategories(id: 4, title: "Gourd Seeds"),
      SubCategories(id: 5, title: "Cabbage and Cauliflower"),
      SubCategories(id: 6, title: "Field Crops"),
      SubCategories(id: 7, title: "Flower Seeds"),
      SubCategories(id: 8, title: "Mushroom"),
      SubCategories(id: 9, title: "Natural"),
    ],
  ),
  Categories(
    title: 'Equipments',
    id: 3,
    subCat: [
      SubCategories(id: 0, title: "Hand Use Equipment"),
      SubCategories(id: 1, title: "Small Machinery"),
      SubCategories(id: 2, title: "Fly & Insect Killer"),
      SubCategories(id: 3, title: "Spray Pump"),
      SubCategories(id: 4, title: "Tractors & Parts"),
      SubCategories(id: 5, title: "Water Pump"),
      SubCategories(id: 6, title: "Vermi Compost Bed"),
    ],
  ),
  Categories(
    title: 'Fertilizers',
    id: 4,
    subCat: [
      SubCategories(id: 0, title: "Biological Fertilizers"),
      SubCategories(id: 1, title: "Micronutrient Fertilizers"),
      SubCategories(id: 2, title: "Organic Fertilizers"),
      SubCategories(id: 3, title: "Chemical Fertilizers"),
      SubCategories(id: 4, title: "Imported Fertilizers"),
      SubCategories(id: 5, title: "Liquid Fertilizers"),
      SubCategories(id: 6, title: "Zymes Fertilizers"),
    ],
  ),
  Categories(
    title: 'Irrigation',
    id: 5,
    subCat: [
      SubCategories(id: 0, title: "Sprinkler"),
      SubCategories(id: 1, title: "Drip Irrigation Accessories"),
      SubCategories(id: 2, title: "Pipe & Fitting"),
      SubCategories(id: 3, title: "Drip Irrigation Kit"),
    ],
  ),
];

class Product {
  final String mainImage;
  final List<String> images;
  final List<String> tags;
  final List<Color> colors;
  final List<int> size;
  final String title;
  final String price;
  final double rating;
  Product({
    this.rating,
    this.price,
    this.mainImage,
    this.images,
    this.tags,
    this.colors,
    this.size,
    this.title,
  });
}

List<String> homeHero = [
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJNpAgy_1pUywRj139t5LFXc3Rr8SSJqON5ZzI8wejgADRtAdvPw&s",
  "https://www.mybucketdeals.com/images/banner-productxx.jpg",
  "http://business-newsupdate.com/img/business/wuxi-atu-and-genemedicine-partner-to-develop-oncolytic-virus-products.jpg",
  "https://46ba123xc93a357lc11tqhds-wpengine.netdna-ssl.com/wp-content/uploads/2019/09/amazon-alexa-event-sept-2019.jpg",
];

List<Product> products = [
  Product(
    title: "Hand Bag",
    price: "USD. 400.00",
    images: [
      'http://demo.woothemes.com/woocommerce/wp-content/uploads/sites/56/2013/06/cd_5_flat.jpg',
      'http://demo.woothemes.com/woocommerce/wp-content/uploads/sites/56/2013/06/cd_3_angle.jpg',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://demo.woothemes.com/woocommerce/wp-content/uploads/sites/56/2013/06/cd_3_angle.jpg',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Bag', 'HandBag', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
      title: "HARIYALI - FORAGE",
      price: "₹ 216",
      images: [
        'https://5.imimg.com/data5/SELLER/Default/2020/10/NU/UN/NA/80900571/grazing-grass-seeds-250x250.jpg',
        'https://www.noble.org/globalassets/images/news/noble-news-and-views/2019/05/hero/the-basics-of-forage-quality.jpg',
        'https://www.stickpng.com/assets/images/580b57fbd9996e24bc43bf85.png',
      ],
      colors: [Colors.blue, Colors.white],
      mainImage: 'https://5.imimg.com/data5/SELLER/Default/2020/10/NU/UN/NA/80900571/grazing-grass-seeds-250x250.jpg',
      size: [500],
      tags: ['Hariyali', 'Foragen', 'Seeds', 'Grass', 'Quality']
  ),
  Product(
    title: "Hand Bag",
    price: "USD. 400.00",
    images: [
      'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
      'https://www.stickpng.com/assets/images/580b57fbd9996e24bc43bf85.png',
      'https://img.favpng.com/23/4/0/tote-bag-red-leather-handbag-png-favpng-ki0rQC3dTsbB0fdQT3WvmvxrU.jpg',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Bag', 'HandBag', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Adidas Superstar",
    price: "USD. 59.00",
    images: [
      'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
      'https://www.transparentpng.com/thumb/adidas-shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png',
      'https://www.jing.fm/clipimg/full/35-352776_adidas-shoes-clipart-picsart-png-shoes-png-for.png',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Shoe', 'Adidas', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Hand Bag",
    price: "USD. 400.00",
    images: [
      'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
      'https://www.stickpng.com/assets/images/580b57fbd9996e24bc43bf85.png',
      'https://img.favpng.com/23/4/0/tote-bag-red-leather-handbag-png-favpng-ki0rQC3dTsbB0fdQT3WvmvxrU.jpg',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Bag', 'HandBag', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Adidas Superstar",
    price: "USD. 59.00",
    images: [
      'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
      'https://www.transparentpng.com/thumb/adidas-shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png',
      'https://www.jing.fm/clipimg/full/35-352776_adidas-shoes-clipart-picsart-png-shoes-png-for.png',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Shoe', 'Adidas', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Hand Bag",
    price: "USD. 400.00",
    images: [
      'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
      'https://www.stickpng.com/assets/images/580b57fbd9996e24bc43bf85.png',
      'https://img.favpng.com/23/4/0/tote-bag-red-leather-handbag-png-favpng-ki0rQC3dTsbB0fdQT3WvmvxrU.jpg',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Bag', 'HandBag', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Adidas Superstar",
    price: "USD. 59.00",
    images: [
      'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
      'https://www.transparentpng.com/thumb/adidas-shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png',
      'https://www.jing.fm/clipimg/full/35-352776_adidas-shoes-clipart-picsart-png-shoes-png-for.png',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Shoe', 'Adidas', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Hand Bag",
    price: "USD. 400.00",
    images: [
      'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
      'https://www.stickpng.com/assets/images/580b57fbd9996e24bc43bf85.png',
      'https://img.favpng.com/23/4/0/tote-bag-red-leather-handbag-png-favpng-ki0rQC3dTsbB0fdQT3WvmvxrU.jpg',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Bag', 'HandBag', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Adidas Superstar",
    price: "USD. 59.00",
    images: [
      'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
      'https://www.transparentpng.com/thumb/adidas-shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png',
      'https://www.jing.fm/clipimg/full/35-352776_adidas-shoes-clipart-picsart-png-shoes-png-for.png',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Shoe', 'Adidas', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Hand Bag",
    price: "USD. 400.00",
    images: [
      'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
      'https://www.stickpng.com/assets/images/580b57fbd9996e24bc43bf85.png',
      'https://img.favpng.com/23/4/0/tote-bag-red-leather-handbag-png-favpng-ki0rQC3dTsbB0fdQT3WvmvxrU.jpg',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Bag', 'HandBag', 'Price', 'Quality'],
    rating: 3.5,
  ),
  Product(
    title: "Adidas Superstar",
    price: "USD. 59.00",
    images: [
      'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
      'https://www.transparentpng.com/thumb/adidas-shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png',
      'https://www.jing.fm/clipimg/full/35-352776_adidas-shoes-clipart-picsart-png-shoes-png-for.png',
    ],
    colors: [Colors.black, Colors.red, Colors.yellow],
    mainImage: 'http://www.miss-blog.fr/media/import/Images/adida%20superstar-896uqv.jpg',
    size: [1,2,3,4,5,6,7,8,9],
    tags: ['Product', 'Shoe', 'Adidas', 'Price', 'Quality'],
    rating: 3.5,
  ),
];
List<Product> bag = [
  Product(
      title: "HARIYALI - FORAGE",
      price: "₹ 216",
      images: [
        'http://www.pngall.com/wp-content/uploads/4/Leather-Bag-PNG.png',
        'https://www.stickpng.com/assets/images/580b57fbd9996e24bc43bf85.png',
        'https://img.favpng.com/23/4/0/tote-bag-red-leather-handbag-png-favpng-ki0rQC3dTsbB0fdQT3WvmvxrU.jpg',
      ],
      colors: [Colors.black, Colors.red, Colors.yellow],
      mainImage: 'https://5.imimg.com/data5/SELLER/Default/2020/10/NU/UN/NA/80900571/grazing-grass-seeds-250x250.jpg',
      size: [1,2,3,4,5,6,7,8,9],
      tags: ['Product', 'Bag', 'HandBag', 'Price', 'Quality']
  ),
  Product(
      title: "SB SILAGE CULTURE",
      price: "₹ 1,100",
      images: [
        'https://5.imimg.com/data5/SELLER/Default/2020/10/NU/UN/NA/80900571/grazing-grass-seeds-250x250.jpg',
        'https://www.transparentpng.com/thumb/adidas-shoes/a4xO3G-adidas-shoes-adidas-shoe-kids-superstar-daddy-grade.png',
        'https://img.favpng.com/23/4/0/tote-bag-red-leather-handbag-png-favpng-ki0rQC3dTsbB0fdQT3WvmvxrU.jpg',
      ],
      colors: [Colors.black, Colors.red, Colors.yellow],
      mainImage: 'https://cdn.shopify.com/s/files/1/0722/2059/products/SB-SILAGE-CULTURE_ea20c213-9472-4752-8668-9f047d5698f2_grande.jpg?v=1601734492',
      size: [1,2,3,4,5,6,7,8,9],
      tags: ['Product', 'Shoe', 'Adidas', 'Price', 'Quality']
  ),
];