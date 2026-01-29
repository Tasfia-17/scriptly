import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class ProjectEndpoint extends Endpoint {
  Future&lt;List&lt;Project&gt;&gt; getUserProjects(Session session, int userId) async {
    return await Project.db.find(
      session,
      where: (t) =&gt; t.userId.equals(userId),
      orderBy: (t) =&gt; t.updatedAt,
      orderDescending: true,
    );
  }

  Future&lt;Project&gt; createProject(Session session, Project project) async {
    return await Project.db.insertRow(session, project);
  }

  Future&lt;Project?&gt; updateProject(Session session, Project project) async {
    return await Project.db.updateRow(session, project);
  }

  Future&lt;bool&gt; deleteProject(Session session, int projectId) async {
    return await Project.db.deleteRow(session, projectId) == 1;
  }
}
