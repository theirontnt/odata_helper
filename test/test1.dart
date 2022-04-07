import 'dart:convert';

import 'package:odata_helper/decoder.dart';
import 'package:odata_helper/odata.dart';
import 'package:odata_helper/odata/query_options.dart';
import 'package:test/test.dart';

// {
//   "userName": "string",
//   "password": "string",
//   "deviceToken": "string"
// }

// "success": true,
//   "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMzOWRlNzYwLTJlN2ItNDZmYS1hNzNlLWJjMGQ2MDBhZjkzMCIsInR5cGUiOiJVc2VyQWNjb3VudCIsImlkIjoiMzM5ZGU3NjAtMmU3Yi00NmZhLWE3M2UtYmMwZDYwMGFmOTMwIiwibmFtZSI6ImJhdXJqYW4iLCJlbWFpbCI6ImJhdXJqYW4iLCJzdWIiOiJiYXVyamFuIiwianRpIjoiODkxZTM0MjAtZTUwNi00MTU3LThjYWMtZTIyOGJiMzRlZGVkIiwiZXhwIjoxNjUwNjAyODQ1LCJpc3MiOiJYYWZTZWN1cml0eSIsImF1ZCI6Imh0dHA6Ly9sb2NhbGhvc3Q6NDIwMCJ9.GaHVdEkiKJ_BG7Qu3T7l0cNwyvm4Xp1xr3Sxzdmn_Ns",
//   "refreshToken": "YHYJSIXVMIP9IC4H0V7EHUJ2Vebf0a952-42c3-4c5f-9766-dd732cdf7eda",
//   "customerOid": "c0275348-9b0b-492e-8d9d-57bfb2dcebc2",
//   "userOid": "3b6f7bb1-359b-429e-a328-c491110f752b",
//   "propertyOwnerOid": "00000000-0000-0000-0000-000000000000",
//   "applicationUserId": "339de760-2e7b-46fa-a73e-bc0d600af930"
void main() {
  test('Fetch user data', () async {
    final OData instance = OData(r"api-v2.dev.spacehub.mn");

    final response = await instance
        .single<JSON>(
          "/Authentication/Login",
          options: QueryOptions(
            method: "POST",
            data: jsonEncode({
              "userName": "baurjan",
              "password": "1234",
            }),
            convert: (a) => a,
          ),
          tryUseAuth: false,
        )
        .fetch();

    if (response != null) {
      print(response.json);

      instance.setBearer(response.json["accessToken"]);

      print(response.response?.headers.keys);

      final _cookie = response.response?.headers["set-cookie"];

      if (_cookie != null) {
        instance.setCookie(_cookie);
      }

      print("Login success: ${response.json["success"]}");
      print("Bearer: ${response.json["accessToken"]}");
      print("Cookie: $_cookie");

      final oid = response.json["userOid"];

      final userData = await instance.single("/api/User($oid)").fetch();

      print(userData?.json);
    } else {
      throw Exception("Response obso");
    }
  });
}
