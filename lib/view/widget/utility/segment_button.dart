import 'package:flutter/material.dart';

typedef SetIntCallback = void Function(Set value);

class AppSegmentButton<T> extends StatelessWidget {
  AppSegmentButton({
    super.key,
    this.data,
    this.multiple = false,
    this.showSelected = false,
    // this.emptySelection = false,
    required this.onChanged,
  });
  final List<T>? data;
  final bool multiple;
  final bool showSelected;
  // final bool emptySelection;
  final ValueNotifier<Set<T>> selection = ValueNotifier<Set<T>>({});
  final SetIntCallback onChanged;
  final ValueNotifier<bool> multipleChoice = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    multipleChoice.value = multiple;
    return ValueListenableBuilder(
        valueListenable: selection,
        builder: (context, _, __) {
          return ValueListenableBuilder(
              valueListenable: multipleChoice,
              builder: (context, _, __) {
                return (data == null)
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: SegmentedButton<T>(
                              segments: data!.map((e) => ButtonSegment<T>(value: e, label: FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.center, child: Text("$e")))).toList(),
                              selected: selection.value,
                              onSelectionChanged: (p0) {
                                selection.value = p0;
                                onChanged.call(selection.value);
                              },
                              showSelectedIcon: showSelected,
                              selectedIcon: const Icon(Icons.check),
                              multiSelectionEnabled: multipleChoice.value,
                              emptySelectionAllowed: true,
                              expandedInsets: EdgeInsets.zero,
                            ),
                          ),
                        ],
                      );
              });
        });
  }
}
