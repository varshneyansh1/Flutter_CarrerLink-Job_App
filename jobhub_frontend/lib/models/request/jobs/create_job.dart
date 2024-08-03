import 'dart:convert';

String createJobsRequestToJson(CreateJobsRequest data) => json.encode(data.toJson());

class CreateJobsRequest {
    CreateJobsRequest({
        required this.title,
        required this.location,
        required this.company,
     
        required this.description,
        required this.salary,
      required this.agentId,
        required this.contract,
       
    
        required this.requirements,
    });

    final String title;
    final String location;
    final String company;
       final String agentId;
    final String description;
    final String salary;
   
    final String contract;
   

    final List<String> requirements;

    Map<String, dynamic> toJson() => {
        "title": title,
        "location": location,
        "company": company,
     
        "description": description,
        "salary": salary,
       
        "contract": contract,
   
        "agentId": agentId,
        "requirements": List<dynamic>.from(requirements.map((x) => x)),
    };
}
