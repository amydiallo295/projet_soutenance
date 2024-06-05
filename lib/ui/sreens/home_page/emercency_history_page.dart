import 'package:emergency/ui/sreens/home_page/splashScreen/history_repport/repport_detail.dart';
import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:emergency/utils/utils.dart';
import 'package:emergency/viewModels/viewModelReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryPage extends ConsumerWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(emergencyViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: TitleWidget(text: "Historique des Signalements"),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: history.reportUsers.length,
              itemBuilder: (context, index) {
                // final submission = history.reportUsers[index];
                final submission = history.reportUsers[index];
                return _buildHistoryItem(
                  submission: submission,
                  context: context,
                );
              },
            )),
      ),
    );
  }

//   Widget _buildHistoryItem(
//       {required String date,
//       required String type,
//       required String imageUrl,
//       required String status}) {
//     return Card(
//       elevation: 3.0,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: ListTile(
//         title: Text(
//           date,
//           style: const TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 14,
//           ),
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 5),
//             Text(
//               'Type: $type',
//               style: const TextStyle(
//                 color: Colors.red,
//               ),
//             ),
//             Text('Statut: $status'),
//           ],
//         ),
//         trailing: const Icon(Icons.arrow_forward_ios),
//         onTap: () {
//           // Action pour voir les détails du signalement
//         },
//       ),
//     );
//   }
// }

  Widget _buildHistoryItem({required submission, required context}) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              submission['imageUrl']), // Image à gauche du ListTile
        ),
        title: Text(
          formatDateFromFirebase(submission['date']),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              'Type: ${submission['type']}',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            Text('Statut: ${submission['status'] ? "En cours" : "Termine"}'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Action pour voir les détails du signalement
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EmergencyDetailPage(
                submission: submission,
              ),
            ),
          );
        },
      ),
    );
  }
}
