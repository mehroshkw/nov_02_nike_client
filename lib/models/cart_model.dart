class CartModel {
  final String? productId;
  final String? productName;
  final String? productPrice;
  final String? productDescription;
  final String? productCategory;
  final String? productStyle;
  final String? productImage;

  CartModel({
    this.productId,
    this.productName,
    this.productPrice,
    this.productDescription,
    this.productCategory,
    this.productStyle,
    this.productImage,
  });

  CartModel.fromMap(Map<String, dynamic> res)
      :productId = res["productId"],
        productName = res["productName"],
        productPrice = res["productPrice"],
        productDescription = res["productDescription"],
        productCategory = res["productCategory"],
        productStyle = res["productStyle"],
        productImage = res["productImage"];
  Map<String, Object?> toMap() {
    return {
      'productId':productId,
      'productName': productName,
      'productPrice': productPrice,
      'productDescription': productDescription,
      'productCategory': productCategory,
      'productStyle': productStyle,
      'productImage': productImage};
  }
  dynamic toJson() =>
      {
        'productId': productId,
        'productName': productName,
        'productPrice': productPrice,
        'productDescription': productDescription,
        'productCategory': productCategory,
        'productStyle': productStyle,
        'productImage': productImage,
      };
}