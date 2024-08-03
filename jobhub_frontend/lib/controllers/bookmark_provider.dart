import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/request/bookmarks/bookmarks_model.dart';
import 'package:jobhub/models/response/bookmarks/all_bookmarks.dart';
import 'package:jobhub/services/helpers/book_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMarkNotifier extends ChangeNotifier {
  List<String> _jobs = [];
  Future<List<AllBookmark>>? bookmarks;

  List<String> get jobs => _jobs;

  set jobs(List<String> newList) {
    _jobs = newList;
    notifyListeners();
  }

  Future<void> addJob(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_jobs != null) {
      _jobs.insert(0, jobId);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> removeJob(String jobId) async {
    final prefs = await SharedPreferences.getInstance();
    if (_jobs != null) {
      _jobs.remove(jobId);
      prefs.setStringList('jobId', _jobs);
      notifyListeners();
    }
  }

  Future<void> loadJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final jobs = prefs.getStringList('jobId');

    if (jobs != null) {
      _jobs = jobs;
    }
  }

  addBookMark(BookmarkReqResModel model, String jobId) {
    BookMarkHelper.addBookmarks(model).then((response) {
      if (response[0]) {
        addJob(jobId);
        Get.snackbar(
            "Bookmark successfully added", "Please Check your bookmarks",
            colorText: Color(kLight.value),
            backgroundColor: Color(kLightBlue.value),
            icon: const Icon(Icons.bookmark_add));
      } else if (!response[0]) {
        Get.snackbar("Failed to add Bookmarks", "Please try again",
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.bookmark_add));
      }
    });
  }

  deleteBookMark(String jobId) {
    BookMarkHelper.deleteBookmarks(jobId).then((response) {
      if (response) {
        removeJob(jobId);
        Get.snackbar(
            "Bookmark successfully deleted", "Please check your bookmarks",
            colorText: Color(kLight.value),
            backgroundColor: Color(kOrange.value),
            icon: const Icon(Icons.bookmark_remove_outlined));
      } else if (!response) {
        Get.snackbar("Failed to delete Bookmarks", "Please try again",
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.bookmark_remove_outlined));
      }
    });
  }

  getBookMarks() {
   bookmarks = BookMarkHelper.getBookmarks();
  }
}
