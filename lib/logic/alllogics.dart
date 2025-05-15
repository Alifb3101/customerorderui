import 'package:uiordertask/data/ orders_sample.dart';

class Logic {
  // task1
  Map<String, int> allcustomerpricedetails() {
    Map<String, int> customeramount = {};

    for (int i = 0; i < orders.length; i++) {
      String a = orders[i]["customer"];
      int price = 0;
      for (var item in orders[i]["items"]) {
        price = price + item["price"] as int;
      }
      customeramount[a] = (customeramount[a] ?? 0) + price;
    }
    ;
    return customeramount;
  }

  Map<String, int> higestpurchaseproduct() {
    Map<String, int> hightprodut = {};
    Map<String, int> productdetails = {};

    for (var data in orders) {
      for (var pro in data["items"]) {
        String productsname = pro["product"];
        if (hightprodut.containsKey(productsname)) {
          hightprodut[productsname] = hightprodut[productsname]! + 1;
        } else {
          hightprodut[productsname] = 1;
        }
      }
    }

    String highestproduct = "";
    int highestCount = 0;

    hightprodut.forEach((product, count) {
      if (count > highestCount) {
        highestCount = count;
        highestproduct = product;
      }
    });

    productdetails[highestproduct] = highestCount;
    return productdetails;
  }

  List<String> alluniqueite() {
    Map<String, int> hightprodut = {};

    for (var data in orders) {
      for (var pro in data["items"]) {
        String productsname = pro["product"];
        if (hightprodut.containsKey(productsname)) {
          hightprodut[productsname] = hightprodut[productsname]! + 1;
        } else {
          hightprodut[productsname] = 1;
        }
      }
    }

    List<String> uniqueitem = [];

    hightprodut.forEach((ele, value) {
      uniqueitem.add(ele);
    });
    return uniqueitem;
  }

  List<String> above2000() {
    List<String> highestorderid = [];
    for (var order in orders) {
      String customerid = order["orderId"];
      int price = 0;
      for (var item in order["items"]) {
        price += item["price"] as int;
      }
      if (price > 2000) {
        highestorderid.add(customerid);
      }
    }

    return highestorderid;
  }
}
