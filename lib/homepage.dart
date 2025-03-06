import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wilbert_uas/api_service.dart';
import 'package:wilbert_uas/penjualan_model.dart';
import 'package:wilbert_uas/response.dart';
import 'package:wilbert_uas/createpage.dart';
import 'package:dio/dio.dart';
import 'package:wilbert_uas/search.dart';
import 'package:wilbert_uas/detailpage.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.sort),
          title : Text('Main Menu'),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
            IconButton(onPressed: (){}, icon: Icon(Icons.bookmark)),
          ],
          centerTitle: true,
          elevation: 0,
          backgroundColor: Color(0xff6883bc),
        ),
        backgroundColor: Color(0xffc6d7eb),
        body : SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xff6883bc),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding : const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white70),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text('Aplikasi Perhitungan',
                                style: TextStyle(fontSize: 20,color: Colors.white70,fontWeight: FontWeight.bold),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text('Penjualan Pakaian',
                                style: TextStyle(fontSize: 20,color: Colors.white70,fontWeight: FontWeight.bold),),
                            ),
                            Divider(
                              color: Colors.white,
                              height: 10,
                              thickness: 2,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text('Created By : Wilbert',
                                style: TextStyle(fontSize: 20, color: Colors.white70),),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Center(
                        child: ElevatedButton.icon(
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => CreatePage()));
                          },
                          label: Text('Tambah Data'),
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ),

                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextField(
                          keyboardType: TextInputType.none,
                          readOnly: true,
                          enableInteractiveSelection: true,
                          style: TextStyle(color: Colors.white70),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide(color: Colors.white, width: 1)
                            ),
                            prefixIcon: Icon(Icons.search) ,
                            prefixIconColor: Color(0xFF37474F),
                            hintText: 'Search',
                          ),
                          onTap: (){
                            showSearch(context: context, delegate: SearchPage());
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              widgetFutureBuilder(),
            ],
          ),
        )
    );
  }

  Widget widgetFutureBuilder() {
    return FutureBuilder(
      future: apiService.getData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasError){
          return Center(child: Text('${snapshot.error}'),);
        } else if(snapshot.hasData) {
          return PenjualanList(list : snapshot.data!.listPenjualan);
        } else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

}

class PenjualanList extends StatelessWidget {
  List<PenjualanModel> list;
  PenjualanList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: list.length,
      itemBuilder: (_,index){
        var data = list[index];
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
                  Text('Tanggal Penjualan : ${list[index].tanggal.toString()}',
                    style: TextStyle(color: Colors.white ,fontWeight: FontWeight.bold),),
                  Text('${list[index].nama_pakaian.toString()}',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 2,),
                  Text('Jumlah : ${list[index].jumlah_pakaian.toString()} | Harga : ${list[index].harga_pakaian.toString()} ',
                    style: TextStyle(color: Colors.white70),),

                  SizedBox(height: 2,),
                  Text('Total : ${list[index].total.toString()}', style: TextStyle(color: Colors.white70),),
                ],
              ),
              trailing: Icon(Icons.keyboard_arrow_right_rounded),
              onTap: (){
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => DetailPage(detail : data,)));
              },
            ),
          ),
        );
      },
    );
  }
}
