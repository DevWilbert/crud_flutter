import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wilbert_uas/penjualan_model.dart';
import 'package:wilbert_uas/response.dart';

class ApiService {
  Future<PostResponse?> getData() async {
    try {
      final response = await Dio().get('http://10.0.2.2/php_penjualan_api/list_penjualan.php');
      debugPrint('Get Data : ${response.data}');
      return PostResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<PenjualanModel?> createData(String tanggal,String nama_pakaian,String jenis_pakaian,String ukuran,int jumlah_pakaian,int harga_pakaian,int total) async {
    try {
      final response = await Dio().post('http://10.0.2.2/php_penjualan_api/create.php',
          data: {
            'tanggal': tanggal,
            'nama_pakaian': nama_pakaian,
            'jenis_pakaian' : jenis_pakaian,
            'ukuran' : ukuran,
            'jumlah_pakaian' : jumlah_pakaian,
            'harga_pakaian' : harga_pakaian,
            'total' : total
          }
      );
      debugPrint('New Create Data : ${response.data}');
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<PenjualanModel?> updateData(int? id,String tanggal,String nama_pakaian,String jenis_pakaian,String ukuran,int jumlah_pakaian,int harga_pakaian,int total) async {
    try {
      final response = await Dio().put('http://10.0.2.2/php_penjualan_api/update.php/${id}',
          data: {
            'id' : id,
            'tanggal': tanggal,
            'nama_pakaian': nama_pakaian,
            'jenis_pakaian' : jenis_pakaian,
            'ukuran' : ukuran,
            'jumlah_pakaian' : jumlah_pakaian,
            'harga_pakaian' : harga_pakaian,
            'total' : total
          }
      );
      debugPrint('Update Data : ${response.data['data']}');
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<PenjualanModel?> deleteData(int? id) async {
    try {
      final response = await Dio().delete('http://10.0.2.2/php_penjualan_api/delete.php',
          data: {
            'id' : id,
          }
      );
      debugPrint('Delete Data : ${response.data['data']}');
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<PostResponse?> searchData(String? query) async {
    try {
      final response = await Dio().get('http://10.0.2.2/php_penjualan_api/search.php/?keyword=${query}');
      debugPrint('GET POST : ${response.data}');
      return PostResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }
}
