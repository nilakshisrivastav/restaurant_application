class LanguageStrings {
  static final Map<String, Map<String, String>> _strings = {
    'en': {
      'app_title': 'Restaurant App',
      'welcome': 'Welcome',
      'continue': 'Continue',
      'home': 'Home',
      'select_cuisine': 'Select Cuisine',
      'top_dishes': 'Top 3 Famous Dishes',
      'add': 'Add',
      'cart': 'Cart',
      'your_cart': 'Your Cart',
      'net_total': 'Net Total',
      'cgst': 'CGST (2.5%)',
      'sgst': 'SGST (2.5%)',
      'grand_total': 'Grand Total',
      'place_order': 'Place Order',
      'order_success': 'Order placed successfully',
      'empty_cart': 'Your cart is empty',
    },
    'hi': {
      'app_title': 'रेस्टोरेंट ऐप',
      'welcome': 'स्वागत है',
      'continue': 'जारी रखें',
      'home': 'होम',
      'select_cuisine': 'खाना चुनें',
      'top_dishes': 'शीर्ष 3 प्रसिद्ध व्यंजन',
      'add': 'जोड़ें',
      'cart': 'कार्ट',
      'your_cart': 'आपकी गाड़ी',
      'net_total': 'नेट टोटल',
      'cgst': 'सीजीएसटी (2.5%)',
      'sgst': 'एसजीएसटी (2.5%)',
      'grand_total': 'ग्रैंड टोटल',
      'place_order': 'ऑर्डर दें',
      'order_success': 'ऑर्डर सफलतापूर्वक दिया गया',
      'empty_cart': 'आपका कार्ट खाली है',
    }
  };

  static String get(String lang, String key) {
    return _strings[lang]?[key] ?? key;
  }
}
