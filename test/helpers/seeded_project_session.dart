import 'package:trace_bench_viewer/shared/models/project_state.dart';
import 'package:trace_bench_viewer/shared/session/project_session.dart';

class SeededProjectSession extends ProjectSession {
  SeededProjectSession(this.initialState);

  final ProjectState? initialState;

  @override
  ProjectState? build() {
    super.build();
    return initialState;
  }
}
