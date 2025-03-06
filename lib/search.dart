import 'package:flutter/material.dart';
import 'package:wilbert_uas/api_service.dart';
import 'package:wilbert_uas/penjualan_model.dart';
import 'package:wilbert_uas/response.dart';
import 'package:wilbert_uas/detailpage.dart';

class SearchPage extends SearchDelegate {
  final apiService = ApiService();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        color: Color(0xff6883bc),
      ),
      hintColor: Colors.white70,
      textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: Colors.black,
          )
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = '';
      }, icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(color: Color(0xffc6d7eb),),
      child: FutureBuilder<PostResponse?>(
        future: apiService.searchData(query),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
          if(!snapshot.hasData){
            return Center(child: CircularProgressIndicator(),);
          }else {
            var data = snapshot.data!.listPenjualan;
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (_,index){
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5.0,
                  margin : EdgeInsets.only(left: 10, top: 6, right: 10, bottom: 6),
                  child : Container(
                    decoration: BoxDecoration(
                      color: Color(0xff8a307f),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
                      leading: Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(right: BorderSide(width: 1, color: Colors.white70))
                          ),
                          padding: EdgeInsets.only(right: 10.0),
                          child: Icon(Icons.shopping_basket),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Tanggal Penjualan : ${data[index].tanggal.toString()}',
                            style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),),
                          Text('${data[index].nama_pakaian.toString()}',
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 2,),
                          Text('Jumlah : ${data[index].jumlah_pakaian.toString()} | Harga : ${data[index].harga_pakaian.toString()} ',
                            style: TextStyle(color: Colors.white70),),

                          SizedBox(height: 2,),
                          Text('Total : ${data[index].total.toString()}', style: TextStyle(color: Colors.white70),),
                        ],
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) => DetailPage(detail : data[index],)));
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xffc6d7eb),),
      child: Center(
        child: Text('Search...',style: TextStyle(fontSize: 20),),
      ),
    );
  }

}