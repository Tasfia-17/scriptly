import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class SceneEndpoint extends Endpoint {
  Future&lt;List&lt;Scene&gt;&gt; getProjectScenes(Session session, int projectId) async {
    return await Scene.db.find(
      session,
      where: (t) =&gt; t.projectId.equals(projectId),
      orderBy: (t) =&gt; t.order,
    );
  }

  Future&lt;Scene&gt; createScene(Session session, Scene scene) async {
    return await Scene.db.insertRow(session, scene);
  }

  Future&lt;Scene?&gt; updateScene(Session session, Scene scene) async {
    return await Scene.db.updateRow(session, scene);
  }

  Future&lt;bool&gt; deleteScene(Session session, int sceneId) async {
    return await Scene.db.deleteRow(session, sceneId) == 1;
  }

  Future&lt;List&lt;Scene&gt;&gt; reorderScenes(Session session, List&lt;Scene&gt; scenes) async {
    final updatedScenes = &lt;Scene&gt;[];
    for (int i = 0; i &lt; scenes.length; i++) {
      final scene = scenes[i].copyWith(order: i);
      final updated = await Scene.db.updateRow(session, scene);
      if (updated != null) updatedScenes.add(updated);
    }
    return updatedScenes;
  }
}
