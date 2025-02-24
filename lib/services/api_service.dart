import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class ApiService {
  // Existing login method...
  Future<Map<String, dynamic>> login(String email, String password) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'device_name': androidInfo.model,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['data']['token'];
        final userData = responseData['data']['user'];

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token.toString());
        await prefs.setInt('user_id', userData['id']);
        await prefs.setString('user_name', userData['name']?.toString() ?? '');
        await prefs.setString(
            'user_email', userData['email']?.toString() ?? '');
        await prefs.setString(
            'user_phone_number', userData['phone_number']?.toString() ?? '');
        await prefs.setString(
            'user_is_subscribed', userData['is_subscribed']?.toString() ?? '');
        await prefs.setString(
            'valid_until', userData['valid_until']?.toString() ?? '');

        return {
          'success': true,
          'message': responseData['message'],
          'data': responseData['data'],
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              responseData['message'] ?? 'An error occurred during login',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // Existing register method...
  Future<Map<String, dynamic>> register(
      String name, String email, String phoneNumber, String password) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'phone_number': phoneNumber,
          'password': password,
          'device_name': androidInfo.model,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['data']['token'];
        final userData = responseData['data']['user'];

        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token.toString());
        await prefs.setInt('user_id', userData['id']);
        await prefs.setString('user_name', userData['name']?.toString() ?? '');
        await prefs.setString(
            'user_email', userData['email']?.toString() ?? '');
        await prefs.setString(
            'user_phone_number', userData['phone_number']?.toString() ?? '');
        await prefs.setString(
            'user_is_subscribed', userData['is_subscribed']?.toString() ?? '');
        await prefs.setString(
            'valid_until', userData['valid_until']?.toString() ?? '');

        return {
          'success': true,
          'message': responseData['message'],
          'data': responseData['data'],
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ??
              'An error occurred during registration',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // New predictImage method - sends image in Base64 to Flask backend.
  Future<Map<String, dynamic>> predictImage(String base64Image) async {
    try {
      // Optionally, if needed, add prefix for image format.
      final fullBase64 = "data:image/jpeg;base64,$base64Image";
      final response = await http.post(
        Uri.parse("$apiFlask/predict"),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'image': fullBase64}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData,
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              responseData['error'] ?? 'Failed to predict image from backend.',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // New updateProfile method.
  Future<Map<String, dynamic>> updateProfile(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    if (token == null) {
      return {
        'success': false,
        'message': 'User not authenticated. Token is missing.',
      };
    }
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/update-profile'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'message': responseData['message'] ?? 'Profile updated successfully.',
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to update profile.',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // Existing submitMembership method...
  Future<Map<String, dynamic>> submitMembership(
      Map<String, dynamic> data) async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    final int? userId = prefs.getInt('user_id');

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/submit-membership'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          ...data,
          'device_name': androidInfo.model,
          'user_id': userId,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'message': responseData['message'],
          'data': responseData['data'],
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ??
              'An error occurred during membership submission',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // Existing getUserData method...
  Future<Map<String, String?>> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getInt('user_id')?.toString(),
      'name': prefs.getString('user_name'),
      'email': prefs.getString('user_email'),
      'phone_number': prefs.getString('user_phone_number'),
    };
  }

  // Existing getToken method...
  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // Existing logout method...
  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_id');
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    await prefs.remove('user_phone_number');
  }

  // Existing checkIsSubscribed method...
  Future<bool> checkIsSubscribed() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    if (token == null) return false;

    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/is-subscribed'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        bool isSubscribed;
        if (responseData is Map && responseData.containsKey('data')) {
          final data = responseData['data'];
          isSubscribed = (data != null && data['is_subscribed'] != null)
              ? data['is_subscribed']
              : false;
        } else if (responseData is Map &&
            responseData.containsKey('is_subscribed')) {
          isSubscribed = responseData['is_subscribed'];
        } else {
          return false;
        }

        await prefs.setBool('is_subscribed', isSubscribed);
        return isSubscribed;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // Existing getUserOrders method...
  Future<Map<String, dynamic>> getUserOrders() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    if (token == null) {
      return {
        'success': false,
        'message': 'User not authenticated. Token is missing.'
      };
    }

    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/get-user-orders'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'message':
              responseData['message'] ?? 'User orders fetched successfully.',
          'data': responseData['data'],
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to fetch user orders.',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // New getTracks method using endpoint baseUrl/get-tracks with debug prints.
  Future<Map<String, dynamic>> getTracks(Map<String, dynamic> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');

    if (token == null) {
      print('[getTracks] Token is missing.');
      return {
        'success': false,
        'message': 'User not authenticated. Token is missing.'
      };
    }

    try {
      // print('[getTracks] Sending request with data: $data');
      final response = await http.post(
        Uri.parse('$apiBaseUrl/get-tracks'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );
      // print('[getTracks] Response status: ${response.statusCode}');
      // print('[getTracks] Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'message': responseData['message'] ?? 'Tracks fetched successfully.',
          'data': responseData['data'],
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to fetch tracks.',
        };
      }
    } catch (e) {
      // print('[getTracks] Exception: $e');
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // Existing getUserProfile method...
  Future<Map<String, dynamic>> getUserProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    if (token == null) {
      return {
        'success': false,
        'message': 'User not authenticated. Token is missing.',
      };
    }
    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'message': responseData['message'] ?? 'Profile fetched successfully.',
          'data': responseData['data'],
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to fetch profile.',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  Future<Map<String, dynamic>> getChats() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    if (token == null) {
      return {
        'success': false,
        'message': 'User not authenticated. Token is missing.'
      };
    }

    try {
      final response = await http.get(
        Uri.parse('$apiBaseUrl/get-chats'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData['data'],
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Failed to fetch chats.',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  Future<Map<String, dynamic>> sendChat(String message) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    if (token == null) {
      return {
        'success': false,
        'message': 'User not authenticated. Token is missing.'
      };
    }

    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/send-chat'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        return {
          'success': true,
          'data': responseData['data'],
        };
      } else {
        final responseData = jsonDecode(response.body);
        return {
          'success': false,
          'message': responseData['message'] ?? 'Error when sending chat.',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }

  // ============================
  // Fungsi baru: submitUrgentPickup
  // Fungsi ini memanggil endpoint POST /urgent-pickup sesuai dengan route dan controller Laravel.
  // Parameter timeSlot dikirim sebagai salah satu input, sementara parameter 'category', 'address'
  // & 'driver_id' dikirim sesuai dengan validasi controller.
  // Catatan: Sesuaikan nilai 'address' dan 'driver_id' sesuai kebutuhan aplikasi Anda.
  // ============================
  Future<Map<String, dynamic>> submitUrgentPickup(String timeSlot) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('auth_token');
    if (token == null) {
      return {
        'success': false,
        'message': 'User not authenticated. Token is missing.'
      };
    }
    try {
      final response = await http.post(
        Uri.parse('$apiBaseUrl/urgent-pickup'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          // Sesuaikan dengan validasi di controller, walaupun pada controller category di-set secara hardcoded.
          'category': 'Urgent Pickup',
          // Meskipun controller menggunakan auth()->user()->address untuk mengisi alamat, parameter ini
          // masih wajib dikirim sesuai validasi.
          'address': 'Your Pickup Address',
          // Pastikan driver_id valid (misalnya, id driver yang tersedia). Jika tidak ada,
          // bisa kirim dummy value yang valid sesuai data pada database Anda.
          'driver_id': 1,
          'time_slot': timeSlot,
        }),
      );
      final responseData = jsonDecode(response.body);
      return responseData;
    } catch (e) {
      return {'success': false, 'message': 'An exception occurred: $e'};
    }
  }
}
