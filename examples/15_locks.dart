import 'helper.dart';

void main() async {
  var factory = await initFactory();

  // --- Acquire a lock ---
  // wait=5000 means wait up to 5 seconds if lock is held
  var lock = await factory.lockService.lock('my-resource', 5000);
  print('lock acquired: ${lock.name}');

  try {
    // ... do exclusive work ...
    print('doing work under lock...');
  } finally {
    // --- Release lock ---
    await factory.lockService.releaseLock(lock);
    print('lock released');
  }

  // --- Lock with zero wait (fail immediately if held) ---
  try {
    var lock2 = await factory.lockService.lock('my-resource', 0);
    await factory.lockService.releaseLock(lock2);
  } catch (e) {
    print('lock contention: $e');
  }
}
