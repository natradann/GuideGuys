import 'package:flutter/material.dart';
import 'package:guideguys/constants/colors.dart';
import 'package:guideguys/constants/textfield_decoration.dart';

typedef OnUserDeleteCallback = void Function();

class SearchBar extends StatelessWidget {
  const SearchBar({
    required this.tagController,
    required this.onUpdate,
    super.key,
  });

  final TextEditingController tagController;
  final Future<void> Function()? onUpdate;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: tagController,
      autofocus: false,
      decoration: const InputDecoration(
        enabledBorder: yellowBorder,
        focusedBorder: yellowBorder,
        filled: true,
        fillColor: white,
        hintText: 'ใส่คำค้น',
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15)
      ),
      cursorColor: black,
      onEditingComplete: onUpdate,
    );
    // TextFieldTags(
    //     textfieldTagsController: tagController,
    //     initialTags: const [],
    //     textSeparators: const [' ', ','],
    //     letterCase: LetterCase.normal,
    //     inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
    //       return ((context, sc, tags, onTagDelete) {
    //         return TextField(
    //           controller: tec,
    //           focusNode: fn,
    //           decoration: InputDecoration(
    //               isDense: true,
    //               border: yellowBorder,
    //               focusedBorder: yellowBorder,
    //               enabledBorder: yellowBorder,
    //               hintText: tagController.hasTags ? '' : 'ใส่คำค้นหา',
    //               prefixIcon: tags.isNotEmpty
    //                   ? SingleChildScrollView(
    //                       clipBehavior: Clip.hardEdge,
    //                       controller: sc,
    //                       scrollDirection: Axis.horizontal,
    //                       child: Row(
    //                         children: tags.map(
    //                           (String tag) {
    //                             return Container(
    //                               decoration: const BoxDecoration(
    //                                 borderRadius: BorderRadius.all(
    //                                   Radius.circular(20.0),
    //                                 ),
    //                                 color: yellow,
    //                               ),
    //                               margin: const EdgeInsets.symmetric(
    //                                   horizontal: 5.0),
    //                               padding: const EdgeInsets.symmetric(
    //                                   horizontal: 10.0, vertical: 5.0),
    //                               child: Row(
    //                                 mainAxisAlignment:
    //                                     MainAxisAlignment.spaceBetween,
    //                                 children: [
    //                                   InkWell(
    //                                     child: Text(
    //                                       '#$tag',
    //                                       style: const TextStyle(color: black),
    //                                     ),
    //                                     onTap: () {
    //                                       // print(tagController.getTags);
    //                                     },
    //                                   ),
    //                                   const SizedBox(width: 4.0),
    //                                   StatefulBuilder(
    //                                     builder: (BuildContext context,
    //                                         StateSetter setState) {
    //                                       return InkWell(
    //                                         child: const Icon(
    //                                           Icons.cancel,
    //                                           size: 14.0,
    //                                           color: grey700,
    //                                         ),
    //                                         onTap: () {
    //                                           setState(() {
    //                                             onUserDeleteCallback();
    //                                             onTagDelete(tag);
    //                                             print(tagController.getTags);
    //                                           });
    //                                         },
    //                                       );
    //                                     },
    //                                   )
    //                                 ],
    //                               ),
    //                             );
    //                           },
    //                         ).toList(),
    //                       ),
    //                     )
    //                   : null,
    //               suffixIcon: InkWell(
    //                 child: const Icon(
    //                   Icons.cancel,
    //                   size: 20,
    //                   color: grey700,
    //                 ),
    //                 onTap: () {
    //                   tagController.clearTags();
    //                 },
    //               )),
    //           onChanged: onChanged,
    //           onSubmitted: onSubmitted,
    //         );
    //       });
    // });
    // Autocomplete<String>(
    //   optionsBuilder: (TextEditingValue textEditingValue) {
    //     if (textEditingValue.text == '') {
    //       return const Iterable<String>.empty();
    //     }
    //     return _kOptions.where((String option) {
    //       return option.contains(textEditingValue.text.toLowerCase());
    //     });
    //   },
    //   onSelected: (String selection) {
    //     debugPrint('You just selected $selection');
    //   },
    //   fieldViewBuilder: (context, searchTextController, focusNodeInTextField,
    //       onFieldSubmitted) {
    //     focusNode = focusNodeInTextField;
    //     searchText = searchTextController;
    //     return TextFormField(
    //       autofocus: false,
    //       focusNode: focusNode,
    //       controller: searchText,
    //       onTapOutside: (event) {
    //         searchTextController.clear();
    //         focusNode.unfocus();
    //       },
    //       onEditingComplete: () {
    //         searchTextController.clear();
    //         focusNode.unfocus();
    //       },
    //       decoration: InputDecoration(
    //         suffixIcon: Transform.scale(
    //           scale: 2,
    //           child: (focusNode.hasFocus)
    //               ? GestureDetector(
    //                   onTap: () {
    //                     searchTextController.clear();
    //                   },
    //                   child: const Icon(
    //                     Icons.close,
    //                     color: grey700,
    //                     size: 12,
    //                   ),
    //                 )
    //               : GestureDetector(
    //                   onTap: () {
    //                     focusNode.requestFocus();
    //                   },
    //                   child: const Icon(
    //                     Icons.search,
    //                     color: grey700,
    //                     size: 12,
    //                   ),
    //                 ),
    //         ),
    //         filled: true,
    //         fillColor: white,
    //         contentPadding:
    //             const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    //         focusedBorder: OutlineInputBorder(
    //             borderRadius: BorderRadius.circular(8),
    //             borderSide: const BorderSide(color: yellow, width: 2)),
    //         enabledBorder: OutlineInputBorder(
    //           borderRadius: BorderRadius.circular(8),
    //           borderSide: const BorderSide(
    //             width: 2,
    //             color: yellow,
    //           ),
    //         ),
    //         hintText: 'ค้นหาไกด์',
    //         hintStyle: const TextStyle(color: grey700),
    //       ),
    //     );
    //   },
    // );
  }
}
