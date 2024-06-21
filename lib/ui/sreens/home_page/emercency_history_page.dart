import 'package:emergency/utils/app_colors.dart';
import 'package:emergency/utils/ui_helpers.dart';
import 'package:emergency/utils/utils.dart';
import 'package:emergency/viewModels/viewModelReport.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchReports();
    });
  }

  void _fetchReports() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      ref.read(emergencyViewModelProvider).fetchUserReport().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(
                color: primaryColor,
              ))
            : history.reportUsers.isEmpty
                ? const NoDataWidget(
                    message: 'Aucun signalement signalé',
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: history.reportUsers.length,
                      shrinkWrap:
                          true, // Ajouté pour éviter les problèmes de défilement
                      itemBuilder: (context, index) {
                        final submission = history.reportUsers[index];
                        return _buildHistoryItem(
                          submission: submission,
                          context: context,
                        );
                      },
                    ),
                  ),
      ),
    );
  }

  Widget _buildHistoryItem({required submission, required context}) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: submission['imageUrl'].isEmpty
            ? const Icon(
                Icons.image,
                size: 60,
              )
            : Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage(submission['imageUrl']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        title: Text(
          formatDateFromTimestamp(submission['createdAt']),
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
              'Type: ${submission['emergencyType']}',
              style: const TextStyle(
                color: Colors.red,
              ),
            ),
            Text('Statut: ${submission['isTreat'] ? "Termine" : "En cours"}'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          _showDetailDialog(context, submission);
        },
      ),
    );
  }

  void _showDetailDialog(BuildContext context, dynamic submission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Détails du signalement',
            style: TextStyle(color: primaryColor),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Type: ${submission['emergencyType']}'),
              Text('Statut: ${submission['isTreat'] ? "Termine" : "En cours"}'),
              Text('Date: ${formatDateFromTimestamp(submission['createdAt'])}'),
              submission['imageUrl'].isEmpty
                  ? const Icon(
                      Icons.image,
                      size: 100,
                    )
                  : Image.network(
                      submission['imageUrl'],
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Fermer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
