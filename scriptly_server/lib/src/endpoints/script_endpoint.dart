import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ScriptEndpoint extends Endpoint {
  Future&lt;List&lt;Script&gt;&gt; getProjectScripts(Session session, int projectId) async {
    return await Script.db.find(
      session,
      where: (t) =&gt; t.projectId.equals(projectId),
      orderBy: (t) =&gt; t.createdAt,
      orderDescending: true,
    );
  }

  Future&lt;Script&gt; saveScript(Session session, Script script) async {
    return await Script.db.insertRow(session, script);
  }

  Future&lt;Script?&gt; getLatestScript(Session session, int projectId) async {
    final scripts = await Script.db.find(
      session,
      where: (t) =&gt; t.projectId.equals(projectId),
      orderBy: (t) =&gt; t.createdAt,
      orderDescending: true,
      limit: 1,
    );
    return scripts.isNotEmpty ? scripts.first : null;
  }
}
