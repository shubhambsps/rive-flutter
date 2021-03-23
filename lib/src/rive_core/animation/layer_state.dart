import 'package:rive/src/core/core.dart';
import 'package:rive/src/rive_core/animation/state_machine_layer.dart';
import 'package:rive/src/rive_core/animation/state_transition.dart';
import 'package:rive/src/generated/animation/layer_state_base.dart';
export 'package:rive/src/generated/animation/layer_state_base.dart';

class _UnknownLayerState extends LayerState {}

abstract class LayerState extends LayerStateBase {
  final Set<StateTransition> _transitions = {};
  Iterable<StateTransition> get transitions => _transitions;
  static final LayerState unknown = _UnknownLayerState();
  @override
  void onAdded() {}
  @override
  void onAddedDirty() {}
  void internalAddTransition(StateTransition transition) {
    _transitions.add(transition);
  }

  void internalRemoveTransition(StateTransition transition) {
    _transitions.remove(transition);
  }

  @override
  void onRemoved() {
    super.onRemoved();
  }

  @override
  bool import(ImportStack stack) {
    var importer =
        stack.latest<StateMachineLayerImporter>(StateMachineLayerBase.typeKey);
    if (importer == null) {
      return false;
    }
    importer.addState(this);
    return super.import(stack);
  }
}