import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/models/request/jobs/create_job.dart';
import 'package:jobhub/models/response/jobs/get_job.dart';
import 'package:jobhub/models/response/jobs/jobs_response.dart';
import 'package:jobhub/services/helpers/auth_helper.dart';
import 'package:jobhub/services/helpers/jobs_helper.dart';
import 'package:jobhub/views/ui/homepage.dart';
import 'package:jobhub/views/ui/mainscreen.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> jobList;
  late Future<JobsResponse> recent;
  late Future<GetJobRes> job;

  createJob(CreateJobsRequest model) {
    AuthHelper.createJobb(model).then((response) {
      if (response) {
        Get.snackbar("Job Details Posted successfully", "",
            colorText: Color(kLight.value),
            backgroundColor: Colors.green,
            icon: const Icon(Icons.add_alert));

        Get.offAll(() => const MainScreen(),
            transition: Transition.fade, duration: const Duration(seconds: 1));
      } else {
        Get.snackbar("Failed to post Job", "Please Check Details",
            colorText: Color(kLight.value),
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  getJobs() {
    jobList = JobsHelper.getJobs();
  }

  getRecent() {
    recent = JobsHelper.getRecent();
  }

  getJob(String jobId) {
    job = JobsHelper.getJob(jobId);
  }
}
