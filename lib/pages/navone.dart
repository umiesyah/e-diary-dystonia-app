import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PalletColor {
  static Color lighter = Color.fromARGB(255, 221, 230, 237);
  static Color light = Color.fromARGB(255, 157, 178, 191);
  static Color dark = Color.fromARGB(255, 82, 109, 130);
  static Color darker = Color.fromARGB(255, 39, 55, 77);
}

class Navone extends StatefulWidget {
  const Navone({Key? key}) : super(key: key);

  @override
  State<Navone> createState() => _NavoneState();
}

class _NavoneState extends State<Navone> {
  CollectionReference<Map<String, dynamic>> diaryCollection =
      FirebaseFirestore.instance.collection('users');

  DateTime currentDate = DateTime.now();
  List<DateTime> availableDates = [];
  int currentIndex = 0;
  late String currentUserUid;
  List<String> surveyQuestions = [
    'Do you have any difficulties performing any manual task?',
    'Do you have any difficulties eating?',
    'Do you have any difficulties using any kind of transport?',
    'Do you have difficulties speaking?',
    'Do you have any difficulties working at a computer?',
    'Do you have any difficulties doing your job?',
    'Do you have any difficulties watching television?',
    'Do you have any difficulties in walking?',
    'Do you have any difficulties taking care of your personal hygiene?',
    'Do you have any difficulties attending any social activity?',
  ];
  Map<String, String> responses = {};
  int _currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    getCurrentUserUid();
    getAvailableDates();
  }

  Future<void> getCurrentUserUid() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserUid = user.uid;
      });
    }
  }

  Future<void> getAvailableDates() async {
    if (currentUserUid != null) {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUserUid)
              .collection('diary')
              .orderBy('date')
              .get();

      if (snapshot.docs.isNotEmpty) {
        List<DocumentSnapshot<Map<String, dynamic>>> docs = snapshot.docs;

        setState(() {
          availableDates = docs
              .map((doc) => (doc['date'] as Timestamp).toDate())
              .toList();
          availableDates.sort((a, b) => a.compareTo(b)); // Sort dates in ascending order

          // Remove duplicate dates
          availableDates = availableDates.toSet().toList();

          int currentDateTime = DateTime.now().millisecondsSinceEpoch;

          currentIndex = availableDates.indexWhere(
              (date) => date.millisecondsSinceEpoch >= currentDateTime);
          currentIndex = currentIndex != -1 ? currentIndex : 0;
          currentDate = availableDates[currentIndex];
        });

        return;
      }
    }

    // Handle errors when database or user data not found
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to fetch diary data'),
      ),
    );
  }

  void goToPreviousDay() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
        currentDate = availableDates[currentIndex];
      }
    });
  }

  void goToNextDay() {
    setState(() {
      if (currentIndex < availableDates.length - 1) {
        currentIndex++;
        currentDate = availableDates[currentIndex];
      }
    });
  }
void showAddEntryDialog() {
  DateTime selectedDate = currentDate;

  showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  ).then((date) {
    if (date != null) {
      setState(() {
        selectedDate = date;
        checkIfEntryExists(selectedDate);
      });
    }
  });
}


  void checkIfEntryExists(DateTime selectedDate) async {
    if (currentUserUid != null) {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(currentUserUid)
              .collection('diary')
              .where('date', isEqualTo: Timestamp.fromDate(selectedDate))
              .get();

      if (snapshot.docs.isNotEmpty) {
        // Entry already exists, show the existing entry
        setState(() {
          currentIndex = availableDates.indexOf(selectedDate);
          currentDate = selectedDate;
        });
      } else {
        // Entry does not exist, show the survey
        showSurvey(selectedDate);
      }
    }
  }
void showSurvey(DateTime selectedDate) {
  _currentQuestionIndex = 0;
  responses.clear();

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Update Diary'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(surveyQuestions[_currentQuestionIndex]),
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          responses[surveyQuestions[_currentQuestionIndex]] =
                              'No difficulties';
                          nextQuestion(selectedDate);
                        });
                      },
                      child: Text('No difficulties'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          responses[surveyQuestions[_currentQuestionIndex]] =
                              'Slight difficulties';
                          nextQuestion(selectedDate);
                        });
                      },
                      child: Text('Slight difficulties'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          responses[surveyQuestions[_currentQuestionIndex]] =
                              'Great difficulties';
                          nextQuestion(selectedDate);
                        });
                      },
                      child: Text('Great difficulties'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          responses[surveyQuestions[_currentQuestionIndex]] =
                              'Nearly impossible';
                          nextQuestion(selectedDate);
                        });
                      },
                      child: Text('Nearly impossible'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

  void nextQuestion(DateTime selectedDate) {
    if (_currentQuestionIndex < surveyQuestions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      saveSurveyResponses(selectedDate);
      Navigator.pop(context);
    }
  }

  void previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  void saveSurveyResponses(DateTime selectedDate) async {
    if (currentUserUid != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserUid)
          .collection('diary')
          .doc(DateFormat('yyyy-MM-dd').format(selectedDate))
          .set({
        'date': Timestamp.fromDate(selectedDate),
        'responses': responses,
      });

      setState(() {
        currentIndex = availableDates.indexOf(selectedDate);
        currentDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: goToPreviousDay,
                  icon: Icon(Icons.arrow_back_ios),
                ),
                Text(
                  DateFormat('EEEE, MMMM d').format(currentDate),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: goToNextDay,
                  icon: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
          Expanded(
  child: Center(
    child: availableDates.contains(currentDate)
        ? StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(currentUserUid)
                .collection('diary')
                .doc(DateFormat('yyyy-MM-dd').format(currentDate))
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final data = snapshot.data!.data();
                if (data != null && data.containsKey('responses')) {
                  final Map<String, dynamic> responsesData = data['responses'];
                  return ListView.builder(
                    itemCount: surveyQuestions.length,
                    itemBuilder: (context, index) {
                      final question = surveyQuestions[index];
                      final response = responsesData[question];

                      return ListTile(
                        title: Text(question),
                        subtitle: response != null ? Text(response) : null,
                      );
                    },
                  );
                }
              }
              return Text('No entry available for this date.');
            },
          )
        : Text(
            'No entry available for this date.',
            style: TextStyle(color: Colors.grey),
          ),
  ),
),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddEntryDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
