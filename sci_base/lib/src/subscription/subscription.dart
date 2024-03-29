library sci_util_sub;

import 'dart:async';
import 'dart:collection';
// import 'package:collection/collection.dart' show IterableNullableExtension;

mixin SubscriptionHelper {
  HashMap<dynamic, List<StreamSubscription>> _subscriptions = HashMap();

  bool hasSubscriptions(o) => _subscriptions.containsKey(o);
  Iterable<dynamic> get subscriptionKeys => _subscriptions.keys;

  void addSubscription(o, StreamSubscription sub) {
    var subs = _subscriptions.putIfAbsent(o, () => []);
    subs.add(sub);
  }

  void addSub(StreamSubscription sub) {
    addSubscription('', sub);
  }

  // Future<bool> removeSubscriptions(o) =>
  //     _cancelSubscriptionFrom(_subscriptions, o);

  bool removeSubscriptionsSync(o) =>
      _cancelSubscriptionFromSync(_subscriptions, o);

  bool _cancelSubscriptionFromSync(
      Map<dynamic, List<StreamSubscription>> _subscriptionMap, o) {
    var subs = _subscriptionMap.remove(o);
    if (subs == null) return false;
    for (var s in subs) {
      s.cancel();
    }
    return true;
  }

  // Future<bool> _cancelSubscriptionFrom(
  //     Map<dynamic, List<StreamSubscription>> _subscriptionMap, o) async {
  //   return _cancelSubscriptionFromSync(_subscriptionMap, o);
  //
  //   // var subs = _subscriptionMap.remove(o);
  //   // if (subs == null) return Future.value(false);
  //   // return Future.wait(subs.map((s) => s.cancel())).then((_) => true);
  // }

  void releaseSubscriptionsSync() {
    if (_subscriptions.isEmpty) return;
    for (var value in _subscriptions.values) {
      for (var element in value) {
        element.cancel();
      }
    }
    _subscriptions = HashMap();
  }

  Future releaseSubscriptions() async {
    releaseSubscriptionsSync();
    // var oldSubs = _subscriptions;
    // _subscriptions = HashMap();
    // var keys = List.from(oldSubs.keys);
    // return Future.wait(
    //     keys.map((key) => _cancelSubscriptionFrom(oldSubs, key)));
  }
}

// mixin SubscriptionHelper {
//   Map<Object, List<StreamSubscription>> _subscriptions = {};
//
//   void addSubscription(o, StreamSubscription sub) {
//     // assert(sub != null);
//     var subs = _subscriptions.putIfAbsent(o, () => []);
//     subs.add(sub);
//   }
//
//   void removeSubscriptionsSync(o) {
//     var subs = _subscriptions.remove(o);
//     if (subs != null) {
//       Future.wait(subs.map((s) => s.cancel()).whereNotNull());
//     }
//   }
//
//   Future removeSubscriptions(o) {
//     var subs = _subscriptions.remove(o);
//     if (subs != null) {
//       return Future.wait(subs.map((s) => s.cancel()).whereNotNull());
//     } else {
//       return Future.value();
//     }
//   }
//
//   Future releaseSubscriptions() {
//     var keys = List.from(_subscriptions.keys);
//     return Future.wait(keys.map(removeSubscriptions)).then((_) {
//       _subscriptions = {};
//     });
//   }
// }
