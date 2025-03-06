import 'package:wilbert_uas/penjualan_model.dart';

class PostResponse{
  List<PenjualanModel> listPenjualan = [];

  PostResponse.fromJson(json){
    for(int i = 0; i < json.length;i++){
      PenjualanModel penjualanModel = PenjualanModel.fromJson(json[i]);
      listPenjualan.add(penjualanModel);
    }
  }
}
