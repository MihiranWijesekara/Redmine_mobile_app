import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redmine_mobile_app/model/issues_model.dart';
import 'package:redmine_mobile_app/model/news_model.dart';
import 'package:redmine_mobile_app/model/project_overview.dart';
import 'package:redmine_mobile_app/model/spent_time_model.dart';
import 'package:redmine_mobile_app/model/tracker_model.dart';

class ApiService {
  //Fetch Issues List
  Future<List<IssuesModel>> fetchIssues() async {
    const String url = "http://192.168.0.9/projects/gsmb-project/issues.json";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> issuesData = responseData['issues'];

        List<IssuesModel> issues = issuesData
            .map((json) => IssuesModel.fromJson(json))
            .cast<IssuesModel>()
            .toList();

        return issues;
      } else {
        print(
            "Failed to fetch the issues, status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to fetch issues data ");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to fetch issues");
    }
  }

  //Fetch Spent time List
  Future<List<TimeEntry>> fetchSpenttime() async {
    const String url =
        "http://192.168.0.9/projects/gsmb-project/time_entries.json";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> spentTimeData = responseData['time_entries'];

        List<TimeEntry> spentTime = spentTimeData
            .map((json) => TimeEntry.fromJson(json))
            .cast<TimeEntry>()
            .toList();

        return spentTime;
      } else {
        print(
            "Failed to fetch the Spent Time, status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to fetch Spent Time data ");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to Spent Time issues");
    }
  }

  //Add Issues
  Future<IssuesModel> addIssues(IssuesModel addissuesModel) async {
    const String url = "http://192.168.0.9/projects/gsmb-project/issues.json";

    String username = 'user';
    String password = 'mLM:jDE:5h/T';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth,
        },
        body: json.encode(addissuesModel.toJson()),
      );

      print("Response Status code: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Response: ${response.body}");
        IssuesModel newIssue = IssuesModel.fromJson(json.decode(response.body));
        return newIssue;
      } else {
        print("Failed to add Issue. Status Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to add Issue");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to add Issue");
    }
  }

  //Fetch tracker List
  Future<List<TrackerList>> fetchTrackerList() async {
    const String url = "http://192.168.0.9/trackers.json";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        List<dynamic> trackerListData = responseData['trackers'];

        List<TrackerList> trackerList = trackerListData
            .map((json) => TrackerList.fromJson(json))
            .cast<TrackerList>()
            .toList();

        return trackerList;
      } else {
        print(
            "Failed to fetch the Tracker List, status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to fetch Tracker List data ");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to fetch Tracker List");
    }
  }

  //Fetch Project overview
  Future<List<ProjectOverview>> fetchProjectOverview() async {
    const String url = "http://192.168.0.9/projects/gsmb-project.json";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['project'] is List) {
          List<dynamic> projectOverviewData = responseData['project'];
          List<ProjectOverview> projectOverview = projectOverviewData
              .map((json) => ProjectOverview.fromJson(json))
              .toList();
          return projectOverview;
        } else if (responseData['project'] is Map) {
          Map<String, dynamic> projectOverviewMap = responseData['project'];
          ProjectOverview projectOverview =
              ProjectOverview.fromJson(projectOverviewMap);
          return [projectOverview];
        } else {
          throw Exception("Unexpected data structure for 'project'");
        }
      } else {
        print(
            "Failed to fetch the ProjectOverview, status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to fetch Project Overview data");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to fetch Project Overview data");
    }
  }

  //Fetch News
  Future<List<NewsModel>> fetchNews() async {
    const String url = "http://192.168.0.9/news.json";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['news'] is List) {
          List<dynamic> NewsModelData = responseData['news'];
          List<NewsModel> newsModel =
              NewsModelData.map((json) => NewsModel.fromJson(json)).toList();
          return newsModel;
        } else if (responseData['news'] is Map) {
          Map<String, dynamic> newsModelMap = responseData['news'];
          NewsModel newsModel = NewsModel.fromJson(newsModelMap);
          return [newsModel];
        } else {
          throw Exception("Unexpected data structure for 'News'");
        }
      } else {
        print("Failed to fetch the News, status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to fetch News data");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to fetch News data");
    }
  }

  //Add Spent time
  Future<TimeEntry?> addSpentTime(TimeEntry timeEntry) async {
    const String url =
        "http://192.168.0.9/projects/gsmb-project/time_entries.json";
    String username = 'user';
    String password = 'mLM:jDE:5h/T';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth,
        },
        body: json.encode(timeEntry.toJson()),
      );
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to add Spent Time");
    }
  }

  //Add News
  Future<NewsModel?> addNews(NewsModel newsModel) async {
    const String url = "http://192.168.0.9/projects/gsmb-project/news.json";
    String username = 'user';
    String password = 'mLM:jDE:5h/T';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth,
        },
        body: json.encode(newsModel.toJson()),
      );

      print("Response Status code: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Response: ${response.body}");
        return NewsModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 204) {
        print("News successfully added, no content returned.");
        return null;
      } else {
        print("Failed to add News. Status Code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to add News");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to add News");
    }
  }

//Issues delete
  Future<void> deleteIssue(int issueId) async {
    final url = Uri.parse('http://192.168.0.9/issues/$issueId.json');
    String username = 'user';
    String password = 'mLM:jDE:5h/T';
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': basicAuth,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Issue deleted successfully.");
      } else {
        print("Failed to delete issue. Status code: ${response.statusCode}");
        throw Exception(
            "Failed to delete issue. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error deleting issue: $error");
      throw Exception("Error deleting issue: $error");
    }
  }

  // Spent times delete
  Future<void> deleteSpentTime(int spentTimeId) async {
    final url = Uri.parse('http://192.168.0.9/time_entries/$spentTimeId.json');
    String username = 'user';
    String password = 'mLM:jDE:5h/T';
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': basicAuth,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Spent time deleted successfully.");
      } else {
        print(
            "Failed to delete Spent time. Status code: ${response.statusCode}");
        throw Exception(
            "Failed to delete Spent time. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error deleting Spent time: $error");
      throw Exception("Error deleting Spent time: $error");
    }
  }
}
