import 'package:flutter/material.dart';
import 'package:note_app/models/note.dart';
import 'package:intl/intl.dart';
import 'package:note_app/screens/bantuan.dart';
import 'package:note_app/screens/edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> filteredNotes = [];
  bool sorted = false;

  @override
  void initState() {
    super.initState();
    filteredNotes = sampleNotes;
  }

  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort(
        (a, b) => a.modifiedTime.compareTo(b.modifiedTime),
      );
    } else {
      notes.sort(
        (b, a) => a.modifiedTime.compareTo(b.modifiedTime),
      );
    }
    sorted = !sorted;
    return notes;
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes = sampleNotes
          .where((note) =>
              note.content.toLowerCase().contains(searchText.toLowerCase()) ||
              note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void deleteNote(int id) {
    setState(() {
      int index = sampleNotes.indexWhere((note) => note.id == id);
      if (index != -1) {
        sampleNotes.removeAt(index);
        filteredNotes.removeWhere((note) => note.id == id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Catatan',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                // IconButton(
                //     onPressed: () {
                //       setState(() {
                //         filteredNotes = sortNotesByModifiedTime(filteredNotes);
                //       });
                //     },
                //     padding: EdgeInsets.all(0),
                //     icon: Container(
                //       width: 40,
                //       height: 40,
                //       decoration: BoxDecoration(
                //           color: Colors.grey.shade800.withOpacity(.8),
                //           borderRadius: BorderRadius.circular(10)),
                //       child: const Icon(
                //         Icons.sort,
                //         color: Colors.white,
                //       ),
                //     )),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            filteredNotes =
                                sortNotesByModifiedTime(filteredNotes);
                          });
                        },
                        padding: EdgeInsets.all(0),
                        icon: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade800.withOpacity(.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.sort,
                            color: Colors.white,
                          ),
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return AboutScreen();
                          }));
                        },
                        padding: EdgeInsets.all(0),
                        icon: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade800.withOpacity(.8),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(
                            Icons.help,
                            color: Colors.white,
                          ),
                        )),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: onSearchTextChanged,
              style: TextStyle(fontSize: 16, color: Colors.white),
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  hintText: "Cari catatan...",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  fillColor: Colors.grey.shade800,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.transparent))),
            ),
            Expanded(
                child: ListView.builder(
              padding: EdgeInsets.only(top: 30),
              itemCount: filteredNotes.length,
              itemBuilder: (context, index) {
                final Note place = filteredNotes[index];

                return Card(
                  margin: EdgeInsets.only(bottom: 20),
                  color: Colors.grey.shade900,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EditScreen(note: filteredNotes[index]),
                          ),
                        );
                        if (result != null) {
                          setState(() {
                            int originalIndex =
                                sampleNotes.indexOf(filteredNotes[index]);

                            sampleNotes[originalIndex] = Note(
                                id: sampleNotes[originalIndex].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now());

                            filteredNotes[index] = Note(
                                id: sampleNotes[originalIndex].id,
                                title: result[0],
                                content: result[1],
                                modifiedTime: DateTime.now());
                          });
                        }
                      },
                      title: RichText(
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              text: '${place.title} \n',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5),
                              children: [
                                TextSpan(
                                    text: '${place.content}',
                                    style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white.withOpacity(0.5),
                                        height: 1.5))
                              ])),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Diubah: ${DateFormat('d MMMM y HH:mm').format(place.modifiedTime)}',
                          style: TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              color: Colors.white.withOpacity(0.5)),
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () async {
                          final result = await confirmDialog(context);
                          if (result != null && result) {
                            deleteNote(index);
                          }
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 25.0, right: 10),
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const EditScreen(),
              ),
            );

            if (result != null) {
              setState(() {
                sampleNotes.add(Note(
                    id: sampleNotes.length,
                    title: result[0],
                    content: result[1],
                    modifiedTime: DateTime.now()));
                filteredNotes = sampleNotes;
              });
            }
          },
          elevation: 18,
          backgroundColor: Colors.grey.shade800,
          child: const Icon(
            Icons.add,
            size: 38,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<dynamic> confirmDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            icon: const Icon(
              Icons.info,
              color: Colors.grey,
            ),
            title: const Text(
              'Yakin ingin menghapus?',
              style: TextStyle(color: Colors.white),
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const SizedBox(
                      width: 60,
                      child: Text(
                        'Yes',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const SizedBox(
                      width: 60,
                      child: Text(
                        'No',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ))
              ],
            ),
          );
        });
  }
}
