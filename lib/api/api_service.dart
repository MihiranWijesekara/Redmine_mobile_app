import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:redmine_mobile_app/model/issues_model.dart';
import 'package:redmine_mobile_app/model/news_model.dart';
import 'package:redmine_mobile_app/model/project_overview.dart';
import 'package:redmine_mobile_app/model/single_issues_model.dart';
import 'package:redmine_mobile_app/model/single_news_model.dart';
import 'package:redmine_mobile_app/model/single_spentTime_model.dart';
import 'package:redmine_mobile_app/model/spent_time_model.dart';
import 'package:redmine_mobile_app/model/tracker_model.dart';

class ApiService {
  //Fetch Issues List
  Future<List<IssuesModel>> fetchIssues() async {
    const String url = "https://achinthamihiran2.planio.com/issues.json";

    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";

    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': basicAuth},
      );

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
    const String url = "https://achinthamihiran2.planio.com/time_entries.json";

    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";

    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': basicAuth},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['time_entries'] is List) {
          List<dynamic> spentTimeData = responseData['time_entries'];
          List<TimeEntry> spentTime = spentTimeData
              .map((json) => TimeEntry.fromJson(json))
              .cast<TimeEntry>()
              .toList();

          return spentTime;
        } else if (responseData['time_entries'] is Map) {
          Map<String, dynamic> spentTimeMap = responseData['time_entries'];
          TimeEntry timeEntry = TimeEntry.fromJson(spentTimeMap);
          return [timeEntry];
        } else {
          throw Exception("Unexpected data structure for 'time_entries'");
        }
      } else {
        print(
            "Failed to fetch the Spent Time, status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to fetch Spent Time data");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to fetch Spent Time data");
    }
  }

  //Add Issues
  Future<IssuesModel> addIssues(IssuesModel addissuesModel) async {
    const String url =
        "https://achinthamihiran2.planio.com/projects/gsmb-project/issues.json";

    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';

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
    const String url =
        "https://achinthamihiran2.planio.com/projects/gsmb-project.json";

    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";

    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': basicAuth},
      );

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
    const String url =
        "https://achinthamihiran2.planio.com/projects/gsmb-project/news.json";

    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";

    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': basicAuth},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);

        if (responseData['news'] is List) {
          List<dynamic> newsModelData = responseData['news'];
          List<NewsModel> newsModel =
              newsModelData.map((json) => NewsModel.fromJson(json)).toList();
          return newsModel;
        } else if (responseData['news'] is Map) {
          Map<String, dynamic> newsModelMap = responseData['news'];
          NewsModel newsModel = NewsModel.fromJson(newsModelMap);
          return [newsModel];
        } else {
          throw Exception("Unexpected data structure for 'news'");
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
    const String url = "https://achinthamihiran2.planio.com/time_entries.json";
    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$apiKey'));

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
    const String url =
        "https://achinthamihiran2.planio.com/projects/gsmb-project/news.json";
    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$apiKey'));

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
    final url =
        Uri.parse('https://achinthamihiran2.planio.com/issues/$issueId.json');
    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';

    try {
      final response = await http.delete(
        url,
        headers: {
          "Authorization": basicAuth,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("Issue deleted successfully.");
      } else {
        print("Failed to delete issue. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
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
    final url = Uri.parse(
        'https://achinthamihiran2.planio.com/time_entries/$spentTimeId.json');
    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';

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

  // Delete News
  Future<void> deleteNews(int NewsId) async {
    final url =
        Uri.parse('https://achinthamihiran2.planio.com/news/$NewsId.json');
    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";
    final String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';

    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': basicAuth,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print("News deleted successfully.");
      } else {
        print("Failed to delete News. Status code: ${response.statusCode}");
        throw Exception(
            "Failed to delete News. Status code: ${response.statusCode}");
      }
    } catch (error) {
      print("Error deleting News: $error");
      throw Exception("Error deleting News: $error");
    }
  }

  //fetch news id data
  Future<SingleNewsModel> fetchNewsId(int newsId) async {
    final String url = 'https://achinthamihiran2.planio.com/news/$newsId.json';

    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";

    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';

      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': basicAuth},
      );

      if (response.statusCode == 200) {
        SingleNewsModel singleNewsModel =
            SingleNewsModel.fromJson(json.decode(response.body));
        return singleNewsModel;
      } else {
        print("Failed to fetch news. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
        throw Exception("Failed to fetch news");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Failed to fetch news");
    }
  }

  //Udpate News
  Future<SingleNewsModel?> updatedNews(
      int newsId, SingleNewsModel singleNewsModel) async {
    final String url = 'https://achinthamihiran2.planio.com/news/$newsId.json';

    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';
    try {
      final responce = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth,
        },
        body: json.encode(singleNewsModel.toJson()),
      );
    } catch (error) {
      print("Error: $error ");
      throw Exception("Failed to update News");
    }
  }

  //fetch Spent Time id data
  Future<SingleSpenttimeModel> fetchSpentTimeId(int spentTimeId) async {
    final String url =
        'https://achinthamihiran2.planio.com/time_entries/$spentTimeId.json';

    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";

    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';
      final responce = await http.get(
        Uri.parse(url),
        headers: {'Authorization': basicAuth},
      );
      if (responce.statusCode == 200) {
        SingleSpenttimeModel singletimeEntry =
            SingleSpenttimeModel.fromJson(json.decode(responce.body));

        return singletimeEntry;
      } else {
        print(
            "Failed to fetch Spengt Time. status code: ${responce.statusCode} ");
        throw Exception("Failed to fetch Spengt Time");
      }
    } catch (error) {
      print("Error: $error");
      throw Exception("Faild to fetch Spengt Time");
    }
  }

  //Update spent time
  Future<SingleSpenttimeModel?> updatedSpentTime(
      int spentTimeId, SingleSpenttimeModel singleSpenttimeModel) async {
    final String url =
        'https://achinthamihiran2.planio.com/time_entries/$spentTimeId.json';
    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$apiKey'));
    try {
      final responce = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth,
        },
        body: json.encode(singleSpenttimeModel.toJson()),
      );
    } catch (error) {
      print("Error: $error ");
      throw Exception("Failed to update News");
    }
  }

  //Fetch single issues
  Future<SingleIssuesModel?> fetchSingleIssuesId(int issueId) async {
    final url = 'https://achinthamihiran2.planio.com/issues/$issueId.json';
    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";
    try {
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$apiKey'))}';
      final response = await http.get(
        Uri.parse(url),
        headers: {'Authorization': basicAuth},
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return SingleIssuesModel.fromJson(jsonResponse['issue']);
      } else {
        print('Failed to fetch issue. Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        return null;
      }
    } catch (e) {
      if (e is SocketException) {
        print('No Internet Connection: $e');
      } else if (e is TimeoutException) {
        print('Request Timed Out: $e');
      } else {
        print('Unexpected Error: $e');
      }
      return null;
    }
  }

  //Update single issues
  Future<SingleIssuesModel?> updatedSingleIssues(
      int issueId, SingleIssuesModel singleIssues) async {
    final String url =
        'https://achinthamihiran2.planio.com/issues/$issueId.json';
    const String username = "achinthamihiran654";
    const String apiKey = "Ab2#*De#";
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$apiKey'));
    try {
      final responce = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": basicAuth,
        },
        body: json.encode(singleIssues.toJson()),
      );
    } catch (error) {
      print("Error: $error ");
      throw Exception("Failed to update News");
    }
  }
}
