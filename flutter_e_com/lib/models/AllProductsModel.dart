// To parse this JSON data, do
//
//     final allProductDetail = allProductDetailFromJson(jsonString);

import 'dart:convert';

AllProductDetail allProductDetailFromJson(String str) =>
    AllProductDetail.fromJson(json.decode(str));

String allProductDetailToJson(AllProductDetail data) =>
    json.encode(data.toJson());

class AllProductDetail {
  List<AllProductDetailDatum> data;
  Meta meta;

  AllProductDetail({
    this.data,
    this.meta,
  });

  factory AllProductDetail.fromJson(Map<String, dynamic> json) =>
      AllProductDetail(
        data: List<AllProductDetailDatum>.from(
            json["data"].map((x) => AllProductDetailDatum.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class AllProductDetailDatum {
  AllProductDetailDatum({
    this.productId,
    this.productName,
    this.productSlug,
    this.status,
    this.variants,
    this.details,
  });

  int productId;
  String productName;
  String productSlug;
  int status;
  Variants variants;
  Details details;

  factory AllProductDetailDatum.fromJson(Map<String, dynamic> json) =>
      AllProductDetailDatum(
        productId: json["product_id"],
        productName: json["product_name"],
        productSlug: json["product_slug"],
        status: json["status"],
        variants: Variants.fromJson(json["variants"]),
        details: Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "product_name": productName,
        "product_slug": productSlug,
        "status": status,
        "variants": variants.toJson(),
        "details": details.toJson(),
      };
}

class Details {
  Details({
    this.data,
  });

  DetailsData data;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        data: DetailsData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class DetailsData {
  DetailsData({
    this.productModel,
    this.categoryId,
    this.categoryName,
    this.categorySlug,
    this.subCategoryName,
    this.subCategorySlug,
    this.subcategoryGroupName,
    this.brandName,
    this.brandSlug,
    this.subCategoryId,
    this.productOverview,
    this.length,
    this.width,
    this.height,
    this.dimensionUnit,
    this.weight,
    this.weightUnit,
    this.metaDescription,
    this.metaKeywords,
    this.metaTitle,
  });

  String productModel;
  int categoryId;
  CategoryName categoryName;
  CategorySlug categorySlug;
  SubCategoryName subCategoryName;
  SubCategorySlug subCategorySlug;
  List<SubcategoryGroupName> subcategoryGroupName;
  BrandName brandName;
  BrandSlug brandSlug;
  int subCategoryId;
  String productOverview;
  int length;
  int width;
  int height;
  String dimensionUnit;
  int weight;
  String weightUnit;
  String metaDescription;
  String metaKeywords;
  String metaTitle;

  factory DetailsData.fromJson(Map<String, dynamic> json) => DetailsData(
        productModel: json["product_model"],
        categoryId: json["category_id"],
        categoryName: categoryNameValues.map[json["category_name"]],
        categorySlug: categorySlugValues.map[json["category_slug"]],
        subCategoryName: subCategoryNameValues.map[json["subCategory_name"]],
        subCategorySlug: subCategorySlugValues.map[json["subCategory_slug"]],
        subcategoryGroupName: List<SubcategoryGroupName>.from(
            json["subcategory_group_name"]
                .map((x) => SubcategoryGroupName.fromJson(x))),
        brandName: brandNameValues.map[json["brand_name"]],
        brandSlug: brandSlugValues.map[json["brand_slug"]],
        subCategoryId: json["subCategory_id"],
        productOverview: json["product_overview"],
        length: json["length"],
        width: json["width"],
        height: json["height"],
        dimensionUnit: json["dimension_unit"],
        weight: json["weight"],
        weightUnit: json["weight_unit"],
        metaDescription: json["meta_description"],
        metaKeywords: json["meta_keywords"],
        metaTitle: json["meta_title"],
      );

  Map<String, dynamic> toJson() => {
        "product_model": productModel,
        "category_id": categoryId,
        "category_name": categoryNameValues.reverse[categoryName],
        "category_slug": categorySlugValues.reverse[categorySlug],
        "subCategory_name": subCategoryNameValues.reverse[subCategoryName],
        "subCategory_slug": subCategorySlugValues.reverse[subCategorySlug],
        "subcategory_group_name":
            List<dynamic>.from(subcategoryGroupName.map((x) => x.toJson())),
        "brand_name": brandNameValues.reverse[brandName],
        "brand_slug": brandSlugValues.reverse[brandSlug],
        "subCategory_id": subCategoryId,
        "product_overview": productOverview,
        "length": length,
        "width": width,
        "height": height,
        "dimension_unit": dimensionUnit,
        "weight": weight,
        "weight_unit": weightUnit,
        "meta_description": metaDescription,
        "meta_keywords": metaKeywords,
        "meta_title": metaTitle,
      };
}

enum BrandName { YAKULT, WINKIES, WINGREENS }

final brandNameValues = EnumValues({
  "Wingreens": BrandName.WINGREENS,
  "Winkies": BrandName.WINKIES,
  "Yakult": BrandName.YAKULT
});

enum BrandSlug {
  BREAD_DAIRY_EGGS_YAKULT,
  BREAD_DAIRY_EGGS_WINKIES,
  BREAD_DAIRY_EGGS_WINGREENS
}

final brandSlugValues = EnumValues({
  "bread-dairy-eggs-wingreens": BrandSlug.BREAD_DAIRY_EGGS_WINGREENS,
  "bread-dairy-eggs-winkies": BrandSlug.BREAD_DAIRY_EGGS_WINKIES,
  "bread-dairy-eggs-yakult": BrandSlug.BREAD_DAIRY_EGGS_YAKULT
});

enum CategoryName { BREAD_DAIRY_EGGS }

final categoryNameValues =
    EnumValues({"BREAD DAIRY & EGGS": CategoryName.BREAD_DAIRY_EGGS});

enum CategorySlug { BREAD_DAIRY_EGGS }

final categorySlugValues =
    EnumValues({"bread-dairy-eggs": CategorySlug.BREAD_DAIRY_EGGS});

enum SubCategoryName { OTHER_DAIRY_PRODUCTS, CAKE, RUSK_BREAD_STICKS }

final subCategoryNameValues = EnumValues({
  "Cake": SubCategoryName.CAKE,
  "Other Dairy Products": SubCategoryName.OTHER_DAIRY_PRODUCTS,
  "Rusk & Bread Sticks": SubCategoryName.RUSK_BREAD_STICKS
});

enum SubCategorySlug {
  BREAD_DAIRY_EGGS_OTHER_DAIRY_PRODUCTS,
  BREAD_DAIRY_EGGS_CAKE,
  BREAD_DAIRY_EGGS_RUSK_BREAD_STICKS
}

final subCategorySlugValues = EnumValues({
  "bread-dairy-eggs-cake": SubCategorySlug.BREAD_DAIRY_EGGS_CAKE,
  "bread-dairy-eggs-other-dairy-products":
      SubCategorySlug.BREAD_DAIRY_EGGS_OTHER_DAIRY_PRODUCTS,
  "bread-dairy-eggs-rusk-bread-sticks":
      SubCategorySlug.BREAD_DAIRY_EGGS_RUSK_BREAD_STICKS
});

class SubcategoryGroupName {
  SubcategoryGroupName({
    this.id,
    this.groupName,
    this.groupSlug,
    this.categoryId,
  });

  int id;
  GroupName groupName;
  GroupSlug groupSlug;
  int categoryId;

  factory SubcategoryGroupName.fromJson(Map<String, dynamic> json) =>
      SubcategoryGroupName(
        id: json["id"],
        groupName: groupNameValues.map[json["group_name"]],
        groupSlug: groupSlugValues.map[json["group_slug"]],
        categoryId: json["category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group_name": groupNameValues.reverse[groupName],
        "group_slug": groupSlugValues.reverse[groupSlug],
        "category_id": categoryId,
      };
}

enum GroupName { DAIRY_PRODUCTS, BREAD_BAKERY, EGGS }

final groupNameValues = EnumValues({
  "Bread & Bakery": GroupName.BREAD_BAKERY,
  "Dairy Products": GroupName.DAIRY_PRODUCTS,
  "Eggs": GroupName.EGGS
});

enum GroupSlug { DAIRY_PRODUCTS, BREAD_BAKERY, EGGS }

final groupSlugValues = EnumValues({
  "bread-bakery": GroupSlug.BREAD_BAKERY,
  "dairy-products": GroupSlug.DAIRY_PRODUCTS,
  "eggs": GroupSlug.EGGS
});

class Variants {
  Variants({
    this.data,
  });

  List<VariantsDatum> data;

  factory Variants.fromJson(Map<String, dynamic> json) => Variants(
        data: List<VariantsDatum>.from(
            json["data"].map((x) => VariantsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class VariantsDatum {
  VariantsDatum({
    this.productVariantId,
    this.productVendorId,
    this.variantName,
    this.price,
    this.actualPrice,
    this.discount,
    this.transferPrice,
    this.sku,
    this.defaultVariant,
    this.quantity,
    this.expired,
    this.promotionName,
    this.subscriptionStatus,
    this.subscriptionPrice,
    this.vendor,
  });

  int productVariantId;
  int productVendorId;
  List<dynamic> variantName;
  int price;
  int actualPrice;
  int discount;
  int transferPrice;
  String sku;
  int defaultVariant;
  int quantity;
  bool expired;
  String promotionName;
  dynamic subscriptionStatus;
  dynamic subscriptionPrice;
  Vendor vendor;

  factory VariantsDatum.fromJson(Map<String, dynamic> json) => VariantsDatum(
        productVariantId: json["product_variant_id"],
        productVendorId: json["product_vendor_id"],
        variantName: List<dynamic>.from(json["variant_name"].map((x) => x)),
        price: json["price"],
        actualPrice: json["actual_price"],
        discount: json["discount"],
        transferPrice: json["transfer_price"],
        sku: json["sku"],
        defaultVariant: json["default_variant"],
        quantity: json["quantity"],
        expired: json["expired"],
        promotionName: json["promotion_name"],
        subscriptionStatus: json["subscription_status"],
        subscriptionPrice: json["subscription_price"],
        vendor: Vendor.fromJson(json["vendor"]),
      );

  Map<String, dynamic> toJson() => {
        "product_variant_id": productVariantId,
        "product_vendor_id": productVendorId,
        "variant_name": List<dynamic>.from(variantName.map((x) => x)),
        "price": price,
        "actual_price": actualPrice,
        "discount": discount,
        "transfer_price": transferPrice,
        "sku": sku,
        "default_variant": defaultVariant,
        "quantity": quantity,
        "expired": expired,
        "promotion_name": promotionName,
        "subscription_status": subscriptionStatus,
        "subscription_price": subscriptionPrice,
        "vendor": vendor.toJson(),
      };
}

class Vendor {
  Vendor({
    this.data,
  });

  VendorData data;

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        data: VendorData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class VendorData {
  VendorData({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.address,
    this.email,
    this.phone,
    this.fax,
    this.rating,
    this.votes,
  });

  int id;
  Name name;
  Slug slug;
  Description description;
  Address address;
  Email email;
  int phone;
  int fax;
  int rating;
  int votes;

  factory VendorData.fromJson(Map<String, dynamic> json) => VendorData(
        id: json["id"],
        name: nameValues.map[json["name"]],
        slug: slugValues.map[json["slug"]],
        description: descriptionValues.map[json["description"]],
        address: addressValues.map[json["address"]],
        email: emailValues.map[json["email"]],
        phone: json["phone"],
        fax: json["fax"],
        rating: json["rating"],
        votes: json["votes"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "slug": slugValues.reverse[slug],
        "description": descriptionValues.reverse[description],
        "address": addressValues.reverse[address],
        "email": emailValues.reverse[email],
        "phone": phone,
        "fax": fax,
        "rating": rating,
        "votes": votes,
      };
}

enum Address { THE_734_CMH_ROAD_INDIRANAGAR_BENGALURU_KARNATAKA_INDIA_560038 }

final addressValues = EnumValues({
  "#734, CMH Road,Indiranagar,Bengaluru,Karnataka,India,560038":
      Address.THE_734_CMH_ROAD_INDIRANAGAR_BENGALURU_KARNATAKA_INDIA_560038
});

enum Description { INDIRANAGAR_STORE }

final descriptionValues =
    EnumValues({"Indiranagar Store": Description.INDIRANAGAR_STORE});

enum Email { MEGHAKC_COSTPRIZE_COM }

final emailValues =
    EnumValues({"meghakc@costprize.com": Email.MEGHAKC_COSTPRIZE_COM});

enum Name { ST01 }

final nameValues = EnumValues({"ST01": Name.ST01});

enum Slug { ST01 }

final slugValues = EnumValues({"st01": Slug.ST01});

class Meta {
  Meta({
    this.taxFlow,
    this.pagination,
  });

  String taxFlow;
  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        taxFlow: json["tax_flow"],
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "tax_flow": taxFlow,
        "pagination": pagination.toJson(),
      };
}

class Pagination {
  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.totalPages,
    this.links,
  });

  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;
  Links links;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        links: Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
        "links": links.toJson(),
      };
}

class Links {
  Links({
    this.next,
  });

  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
