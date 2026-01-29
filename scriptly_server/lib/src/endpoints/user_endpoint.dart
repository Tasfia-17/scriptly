import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class UserEndpoint extends Endpoint {
  Future&lt;User?&gt; getUserByEmail(Session session, String email) async {
    final users = await User.db.find(
      session,
      where: (t) =&gt; t.email.equals(email),
      limit: 1,
    );
    return users.isNotEmpty ? users.first : null;
  }

  Future&lt;User&gt; createUser(Session session, User user) async {
    return await User.db.insertRow(session, user);
  }

  Future&lt;User?&gt; updateUser(Session session, User user) async {
    return await User.db.updateRow(session, user);
  }
}
