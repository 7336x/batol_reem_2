import "package:dio/dio.dart";

class DioClient {
  static final _baseUrl = 'https://coded-pets-api-auth.eapi.joincoded.com';
  static final Dio client = Dio(BaseOptions(baseUrl: _baseUrl));
}

//   Future<List<Pet>> getPets() async {
//     List<Pet> pets = [];
//     try {
//       Response response = await client.get('/pets');
//       pets = (response.data as List).map((pet) => Pet.fromJson(pet)).toList();
//     } on DioError catch (error) {
//       print(error);
//     }
//     return pets;
//   }

//   Future<Pet> createPet({required Pet pet}) async {
//     late Pet retrievedPet;
//     try {
//       FormData data = FormData.fromMap({
//         "name": pet.name,
//         "age": pet.age,
//         "gender": pet.gender,
//         "image": await MultipartFile.fromFile(
//           pet.image,
//         ),
//       });
//       Response response = await client.post('/pets', data: data);
//       retrievedPet = Pet.fromJson(response.data);
//     } on DioError catch (error) {
//       print(error);
//     }
//     return retrievedPet;
//   }

//   Future<Pet> updatePet({required Pet pet}) async {
//     late Pet retrievedPet;
//     try {
//       FormData data = FormData.fromMap({
//         "name": pet.name,
//         "age": pet.age,
//         "adopted": pet.adopted,
//         "gender": pet.gender,
//         "image": await MultipartFile.fromFile(
//           pet.image,
//         ),
//       });

//       Response response = await client.put('/pets/${pet.id}', data: data);
//       retrievedPet = Pet.fromJson(response.data);
//     } on DioError catch (error) {
//       print(error);
//     }
//     return retrievedPet;
//   }

//   Future<void> deletePet({required int petId}) async {
//     try {
//       await client.delete('/pets/${petId}');
//     } on DioError catch (error) {
//       print(error);
//     }
//   }

//   Future<Pet> adoptPet({required int petId}) async {
//     late Pet retrievedPet;
//     try {
//       Response response = await client.post('/pets/adopt/${petId}');
//       retrievedPet = Pet.fromJson(response.data);
//     } on DioError catch (error) {
//       print(error);
//     }
//     return retrievedPet;
//   }
// }
