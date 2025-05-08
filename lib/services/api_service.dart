// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'auth_service.dart';

// class ApiService {
//   final Dio _dio;
//   final AuthService _authService;
//   final String baseUrl = 'https://avaronn-backend-development-server.pemy8f8ay9m4p.ap-south-1.cs.amazonlightsail.com/test/api/auth';


//   ApiService({Dio? dio, AuthService? authService})
//       : _dio = dio ?? Dio(),
//         _authService = authService ?? AuthService();

//   Future<void> _setupAuthInterceptor() async {
//     _dio.interceptors.clear();
//     _dio.interceptors.add(
//       InterceptorsWrapper(
//         onRequest: (options, handler) async {
//           // For non-auth endpoints, add the token
//           if (!options.path.contains('/sendOtp') && 
//               !options.path.contains('/verifyOtp') && 
//               !options.path.contains('/refreshAccessToken')) {
//             final token = await _authService.getAccessToken();
//             if (token != null) {
//               options.headers['Authorization'] = 'Bearer $token';
//             }
//           }
//           return handler.next(options);
//         },
//         onError: (DioException error, handler) async {
//           if (error.response?.statusCode == 401) {
//             try {
//               // Token expired, try to refresh it
//               final newToken = await _authService.refreshAccessToken();
              
//               // Retry the original request with the new token
//               final opts = error.requestOptions;
//               opts.headers['Authorization'] = 'Bearer $newToken';
              
//               final response = await _dio.fetch(opts);
//               return handler.resolve(response);
//             } catch (e) {
//               // Refresh token is also invalid, logout user
//               await _authService.logout();
//               return handler.next(error);
//             }
//           }
//           return handler.next(error);
//         },
//       ),
//     );
//   }

//   Future<Response> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
//     await _setupAuthInterceptor();
//     try {
//       return await _dio.get(
//         '$baseUrl$endpoint',
//         queryParameters: queryParameters,
//       );
//     } catch (e) {
//       _handleError(e);
//       rethrow;
//     }
//   }

//   Future<Response> post(String endpoint, {dynamic data}) async {
//     await _setupAuthInterceptor();
//     try {
//       return await _dio.post(
//         '$baseUrl$endpoint',
//         data: data,
//       );
//     } catch (e) {
//       _handleError(e);
//       rethrow;
//     }
//   }

//   Future<Response> put(String endpoint, {dynamic data}) async {
//     await _setupAuthInterceptor();
//     try {
//       return await _dio.put(
//         '$baseUrl$endpoint',
//         data: data,
//       );
//     } catch (e) {
//       _handleError(e);
//       rethrow;
//     }
//   }

//   Future<Response> uploadFile(String endpoint, String attributeType, dynamic file) async {
//     await _setupAuthInterceptor();
//     try {
//       FormData formData = FormData.fromMap({
//         'attribute': attributeType,
//         'file': file,
//       });
      
//       return await _dio.post(
//         '$baseUrl$endpoint',
//         data: formData,
//       );
//     } catch (e) {
//       _handleError(e);
//       rethrow;
//     }
//   }

//   void _handleError(dynamic error) {
//     if (kDebugMode) {
//       print('API Error: $error');
//     }
//   }
// }