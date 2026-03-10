
import "package:http/http.dart" as http;

import "../../data/response_model.dart";
import "../../model/week_4_models/users_resopnse_model.dart";
class UserRepo{

  Future<Object> getUsers() async {
    try{
      final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"), 
      headers: {
        "Accept":"application/json",
        "content-type": "application/json"
      }
      );
      print("RESPONSE::::: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 304) {
        return SuccessResponse(data: usersResponseModelFromJson(response.body), message: "Users fetched successfully");
      } else {
        return FailureResponse(message: response.body, error: "Error: ${response.statusCode}");
      }
    } catch(e){
      return FailureResponse(message: "Failed to fetch users", error: e.toString());
    }
  }

}