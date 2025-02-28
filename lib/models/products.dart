import "dart:convert";

/// Function to convert JSON string to ProductList object
ProductList productListFromJson(String str) => ProductList.fromJson(json.decode(str));
String productListToJson(ProductList data) => json.encode(data.toJson());

/// Class representing a list of products
class ProductList {
  ProductList({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  ProductList.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Product.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }

  List<Product>? products;
  int? total;
  int? skip;
  int? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (products != null) {
      map['products'] = products?.map((v) => v.toJson()).toList();
    }
    map['total'] = total;
    map['skip'] = skip;
    map['limit'] = limit;
    return map;
  }
}

/// Function to convert JSON string to Product object
Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());

/// Class representing a single product
class Product {
  Product({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.images,
    this.thumbnail,
  });

  Product.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    price = json['price'].toDouble();
    discountPercentage = json['discountPercentage'].toDouble();
    rating = json['rating'].toDouble();
    stock = json['stock'];
    tags = json['tags'] != null ? json['tags'].cast<String>() : [];
    brand = json['brand'];
    sku = json['sku'];
    weight = json['weight'];
    dimensions = json['dimensions'] != null ? Dimensions.fromJson(json['dimensions']) : null;
    warrantyInformation = json['warrantyInformation'];
    shippingInformation = json['shippingInformation'];
    availabilityStatus = json['availabilityStatus'];
    if (json['reviews'] != null) {
      reviews = [];
      json['reviews'].forEach((v) {
        reviews?.add(Reviews.fromJson(v));
      });
    }
    returnPolicy = json['returnPolicy'];
    minimumOrderQuantity = json['minimumOrderQuantity'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    images = json['images'] != null ? json['images'].cast<String>() : [];
    thumbnail = json['thumbnail'];
  }

  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  int? weight;
  Dimensions? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<Reviews>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  Meta? meta;
  List<String>? images;
  String? thumbnail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['category'] = category;
    map['price'] = price;
    map['discountPercentage'] = discountPercentage;
    map['rating'] = rating;
    map['stock'] = stock;
    map['tags'] = tags;
    map['brand'] = brand;
    map['sku'] = sku;
    map['weight'] = weight;
    if (dimensions != null) {
      map['dimensions'] = dimensions?.toJson();
    }
    map['warrantyInformation'] = warrantyInformation;
    map['shippingInformation'] = shippingInformation;
    map['availabilityStatus'] = availabilityStatus;
    if (reviews != null) {
      map['reviews'] = reviews?.map((v) => v.toJson()).toList();
    }
    map['returnPolicy'] = returnPolicy;
    map['minimumOrderQuantity'] = minimumOrderQuantity;
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    map['images'] = images;
    map['thumbnail'] = thumbnail;
    return map;
  }
}

/// Meta Data
class Meta {
  Meta({
    this.createdAt,
    this.updatedAt,
    this.barcode,
    this.qrCode,
  });

  Meta.fromJson(dynamic json) {
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    barcode = json['barcode'];
    qrCode = json['qrCode'];
  }

  String? createdAt;
  String? updatedAt;
  String? barcode;
  String? qrCode;

  Map<String, dynamic> toJson() => {
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'barcode': barcode,
    'qrCode': qrCode,
  };
}

/// Reviews
class Reviews {
  Reviews({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  Reviews.fromJson(dynamic json) {
    rating = json['rating'];
    comment = json['comment'];
    date = json['date'];
    reviewerName = json['reviewerName'];
    reviewerEmail = json['reviewerEmail'];
  }

  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  Map<String, dynamic> toJson() => {
    'rating': rating,
    'comment': comment,
    'date': date,
    'reviewerName': reviewerName,
    'reviewerEmail': reviewerEmail,
  };
}

/// Dimensions
class Dimensions {
  Dimensions({
    this.width,
    this.height,
    this.depth,
  });

  Dimensions.fromJson(dynamic json) {
    width = json['width'].toDouble();
    height = json['height'].toDouble();
    depth = json['depth'].toDouble();
  }

  double? width;
  double? height;
  double? depth;

  Map<String, dynamic> toJson() => {
    'width': width,
    'height': height,
    'depth': depth,
  };
}
