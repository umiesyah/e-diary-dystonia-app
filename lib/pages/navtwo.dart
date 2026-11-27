import 'package:dystoniadiary/main.dart';
import 'package:flutter/material.dart';

class Navtwo extends StatefulWidget {
  const Navtwo({super.key});

  @override
  State<Navtwo> createState() => _NavtwoState();
}

class _NavtwoState extends State<Navtwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Text(
                    'Dystonia is a movement disease characterised by involuntary muscle contractions. This can result in repetitive or twisted movements.',
                    style: TextStyle(color: Colors.black),
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Text(
                    'The disorder can afect a single area of your body (focal dystonia), two or more neighbouring regions (segmental dystonia), or your entire body (general dystonia). Muscle spasms can range in severity from moderate to severe. They may be painful, and they may interfere with your ability to conduct daily duties.',
                    style: TextStyle(color: Colors.black),
                  )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset('assets/images/info2.jpeg')),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: const Text(
                    'Focal dystonia refers to a specifc type of dystonia that afects only one part or region of the body. It is characterized by involuntary muscle contractions and abnormal movements limited to a particular area. Focal dystonia can occur in various body parts, and some common forms.',
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset("assets/images/info1.jpeg")),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  'Symptoms of Dystonia',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  '• Cervical dystonia (torticollis): Involuntary muscle contractions in the neck lead to abnormal head postures, twisting, and difficulty holding the head steady.',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  '• Oromandibular dystonia: Involuntary muscle contractions affect the jaw, tongue, and face, causing difficulty with mouth movement, speech, chewing, and swallowing.',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  '• Blepharospasm: Involuntary contractions of the muscles around the eyes result in excessive blinking, eye closure, sensitivity to light, and dryness.',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  '• Writer\'s cramp: Involuntary muscle contractions in the hand, fingers, or forearm cause difficulty controlling the affected hand during writing or fine motor tasks, hand cramping, and tremors.',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  '• Musician\'s dystonia: Involuntary muscle contractions or spasms affect the hand or fingers used for playing an instrument, leading to loss of control or coordination in specific finger movements required for playing.',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  'Physical Treatment for Dystonia',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  '• Hand and Forearm Strengthening',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  '• Neck Strengthening',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  '• Finger Strengthening',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                child: Text(
                  '• Yoga',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
