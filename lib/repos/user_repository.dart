class LoginRepository {
  final String endpoint = "";

  Future<bool> loginUser(String username, String password) async {
    try {
      // final response = await http.post(
      //   endpoint,
      //   data: {'username': username, 'password': password},
      // );
      // if (response.statusCode == 200) {

      //     return true;
      //   } else {

      //     return false;
      //   }
      await Future.delayed(Duration(seconds: 2));
      if (username == "admin" && password == "password") {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error logging in: $error');
      return false;
    }
  }
}


class SignUpRepo{
  final String endpoint="";

  Future<bool> signupUser(
    String firstname,
    String lastname,
    String email,
    String phone,
    String password,
    )
  async {
    try {
     
       await Future.delayed(Duration(seconds: 2));
        print(firstname);
        print(lastname);
        print (email);
        print(phone);
        print(password);
       return true;
       
      
    } catch (error) {
      print('error while signing in:$error');
      return false;
    }
  }
}