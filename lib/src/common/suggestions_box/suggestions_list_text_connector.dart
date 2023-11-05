import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

/// A widget that helps reopening the suggestions list when the text changes.
///
/// This happens when the user starts typing again after
/// a suggestion has been selected.
class SuggestionsListTextConnector extends StatefulWidget {
  const SuggestionsListTextConnector({
    super.key,
    required this.controller,
    required this.textEditingController,
    required this.child,
  });

  final SuggestionsBoxController controller;
  final TextEditingController textEditingController;
  final Widget child;

  @override
  State<SuggestionsListTextConnector> createState() =>
      _SuggestionsListTextConnectorState();
}

class _SuggestionsListTextConnectorState
    extends State<SuggestionsListTextConnector> {
  String? previousText;

  @override
  void initState() {
    super.initState();
    widget.textEditingController.addListener(onTextChange);
  }

  @override
  void didUpdateWidget(covariant SuggestionsListTextConnector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.textEditingController != widget.textEditingController) {
      oldWidget.textEditingController.removeListener(onTextChange);
      widget.textEditingController.addListener(onTextChange);
    }
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(onTextChange);
    super.dispose();
  }

  void onTextChange() {
    if (previousText == widget.textEditingController.text) return;
    previousText = widget.textEditingController.text;

    if (!widget.controller.isOpen && widget.controller.retainFocus) {
      widget.controller.open();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
