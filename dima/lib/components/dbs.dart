// ignore_for_file: file_names

query(String s) {
  /// TODO: implement this
  return s;
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
  return [
    {
      'id': '1',
      'link': 'https://picsum.photos/250?image=9',
      'name': 'Laptop Chewui 14\'!',
      'price': '259\$'
    },
    {
      'id': '2',
      'link':
          'https://images.unsplash.com/photo-1642960973182-4277c0067a56?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      'name': 'Flowers for your dearest one!',
      'price': '19\$'
    },
    {
      'id': '3',
      'link': 'https://picsum.photos/250?image=10',
      'name': 'Best painting of the week!',
      'price': '59\$'
    },
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
    {
      'id': '7',
      'link':
          'https://images.pexels.com/photos/8549835/pexels-photo-8549835.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260',
      'name': 'Beautiful clay vase',
      'price': '9.99\$'
    },
    {
      'id': '8',
      'link':
          'https://images.pexels.com/photos/4465126/pexels-photo-4465126.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'name': 'Oral Hygiene Kit',
      'price': '6.99\$'
    },
    {
      'id': '9',
      'link':
          'https://images.pexels.com/photos/5760879/pexels-photo-5760879.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'name': 'Personally selected scented candles',
      'price': '12\$'
    },
    {
      'id': '10',
      'link':
          'https://images.pexels.com/photos/3685538/pexels-photo-3685538.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'name': 'Foundation for your skin',
      'price': '9.99\$'
    },
    {
      'id': '11',
      'link':
          'https://images.pexels.com/photos/5217913/pexels-photo-5217913.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'name': 'Bleach for your clothes (3L)',
      'price': '4.99\$'
    },
    {
      'id': '12',
      'link':
          'https://images.pexels.com/photos/6387874/pexels-photo-6387874.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'name': '3x Washing soap ',
      'price': '3.99\$'
    },
    {
      'id': '13',
      'link':
          'https://images.pexels.com/photos/5217913/pexels-photo-5217913.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'name': '2x Natural pro-biotic soap',
      'price': '4.99\$'
    },
    {
      'id': '14',
      'link':
          'https://images.unsplash.com/photo-1643029950323-92dc1129339c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
      'name': 'Coat & Bag combo',
      'price': '159\$'
    },
    {
      'id': '15',
      'link':
          'https://images.unsplash.com/photo-1642965961298-02f31304044d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=764&q=80',
      'name': 'Picture package [10 pcs]',
      'price': '4.99\$'
    },
    {
      'id': '16',
      'link':
          'https://images.unsplash.com/photo-1460039230329-eb070fc6c77c?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
      'name': 'Flowers for your beloved one',
      'price': '14\$'
    }
  ];
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
