import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jobhub/constants/app_constants.dart';
import 'package:jobhub/controllers/jobs_provider.dart';
import 'package:jobhub/models/request/jobs/create_job.dart';
import 'package:jobhub/views/common/app_bar.dart';
import 'package:jobhub/views/common/app_style.dart';
import 'package:jobhub/views/common/custom_btn.dart';
import 'package:jobhub/views/common/custom_textfield.dart';
import 'package:jobhub/views/common/drawer/drawer_widget.dart';
import 'package:jobhub/views/common/height_spacer.dart';
import 'package:jobhub/views/common/reusable_text.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class jobPost extends StatefulWidget {
  const jobPost({super.key});

  @override
  State<jobPost> createState() => _jobPostState();
}

class _jobPostState extends State<jobPost> {
  final TextEditingController title = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController company = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController salary = TextEditingController();
  final TextEditingController period = TextEditingController();
  final TextEditingController contract = TextEditingController();
  final TextEditingController requirements0 = TextEditingController();
  final TextEditingController requirements1 = TextEditingController();
  final TextEditingController requirements2 = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    location.dispose();
    company.dispose();
    description.dispose();
    salary.dispose();
    period.dispose();
    contract.dispose();
    requirements0.dispose();
    requirements1.dispose();
    requirements2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: CustomAppBar(
                text: "Post Job",
                child: Padding(
                  padding: EdgeInsets.all(12.0.h),
                  child: const DrawerWidget(),
                ),
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const HeightSpacer(size: 30),
                  ReusableText(
                      text: "Fill the details to post job",
                      style: appstyle(
                          18, Color(kDark.value), FontWeight.w600)),
                  const HeightSpacer(size: 30),
                  CustomTextField(
                    controller: title,
                    keyboardType: TextInputType.text,
                    hintText: "Job Title",
                    validator: (title) {
                      if (title!.isEmpty) {
                        return "Please enter a valid job title";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: company,
                    keyboardType: TextInputType.text,
                    hintText: "Company Name",
                    validator: (company) {
                      if (company!.isEmpty) {
                        return "Please enter company name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: location,
                    keyboardType: TextInputType.text,
                    hintText: "Job Location",
                    validator: (location) {
                      if (location!.isEmpty) {
                        return "Please enter valid location";
                      }
                      return null;
                    },
                  
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: description,
                    keyboardType: TextInputType.multiline,
                    hintText: "Job Description",
                    validator: (description) {
                      if (description!.isEmpty) {
                        return "Please enter the description";
                      }
                      return null;
                    },
                  
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: salary,
                    keyboardType: TextInputType.text,
                    hintText: "Job Salary",
                    validator: (location) {
                      if (location!.isEmpty) {
                        return "Please enter valid salary";
                      }
                      return null;
                    },
                  
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: contract,
                    keyboardType: TextInputType.text,
                    hintText: "Full Time/Part Time",
                    validator: (contract) {
                      if (contract!.isEmpty) {
                        return "Please enter the contract";
                      }
                      return null;
                    },
                  
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: requirements0,
                    keyboardType: TextInputType.text,
                    hintText: "Requirements",
                    
                  
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: requirements1,
                    keyboardType: TextInputType.text,
                    hintText: "Requirements",
         
                  
                  ),
                  const HeightSpacer(size: 20),
                  CustomTextField(
                    controller: requirements2,
                    keyboardType: TextInputType.text,
                    hintText: "Requirements",
                  
                  ),
      
                  const HeightSpacer(size: 50),
                  CustomButton(
                    onTap: () async {
           
                           final SharedPreferences prefs = await SharedPreferences.getInstance();
                            String? agentId = prefs.getString('userId');
           if (agentId != null) {
    CreateJobsRequest model = CreateJobsRequest(
      title: title.text,
      company: company.text,
      location: location.text,
      salary: salary.text,
      contract: contract.text,
      description: description.text,
      agentId: agentId,
      requirements: [
        requirements0.text,
        requirements1.text,
        requirements2.text
      ],
    );

    jobsNotifier.createJob(model);
  } else {
    // Handle the case where agentId is null

  }
},
                    text: "Post Job",
                  )
                ],
              ),
            ));
      },
    );
  }
}
