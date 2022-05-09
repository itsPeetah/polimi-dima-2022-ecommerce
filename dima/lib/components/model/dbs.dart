// ignore_for_file: file_names

query(String s) {
  var resultList = getAllDb().where((Map<String, String> element) =>
      (element['name']!.toLowerCase()).contains(s.toLowerCase()));
  return resultList;
}

getProductInfo(String productId) {
  return query(productId);
}

firstChoice() {
  return {
    'link': 'https://picsum.photos/250?image=9',
    'name': 'Laptop Chewui 14\'!',
    'price': '259\$'
  };
}

secondChoice() {
  return {
    'link':
        'https://images.unsplash.com/photo-1642960973182-4277c0067a56?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
    'name': 'Flowers for your dearest one!',
    'price': '19\$'
  };
}

thirdChoice() {
  return {
    'link': 'https://picsum.photos/250?image=10',
    'name': 'Best painting of the week!',
    'price': '59\$'
  };

  //'https://picsum.photos/250?image=8';
}

getElement(int index) {
  if (index >= getAllDb().length) {
    throw Exception(
        "There is no element at required index:" + index.toString());
  } else {
    getAllDb().elementAt(index);
  }
}

fourthChoice() {
  return getAllDb().elementAt(3);
}

userPref() {
  return [
    {
      'id': '4',
      'link':
          'https://images.unsplash.com/photo-1642991640594-81a565e3aa0e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      'name': 'Tour in the Alps for one week!',
      'price': '129\$'
    },
    {
      'id': '5',
      'link':
          'https://images.unsplash.com/photo-1642978349139-1bce41c59e3e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      'name': 'Painting equipment!',
      'price': '39\$'
    },
    {
      'id': '6',
      'link':
          'https://images.unsplash.com/photo-1642936795750-ca25f7eab721?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      'name': 'Buy George Orwell\'s 1984!',
      'price': '19\$'
    },
  ];
}

getAllDb() {
  return [];
}

getProductFromId(String id) {
  List<Map<String, String>> res = getAllDb();
  //print("Is true?: - " + res.containsValue(id).toString());
  var result = res.where((element) => element['id'] == id);
  if (result.first.isEmpty) {
    throw Exception("Can not find product with id:" + id);
  } else {
    return result.first;
  }
}
