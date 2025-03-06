import 'package:flutter/material.dart';
import 'package:wilbert_uas/api_service.dart';
import 'package:wilbert_uas/penjualan_model.dart';
import 'package:wilbert_uas/updatepage.dart';
import 'package:wilbert_uas/homepage.dart';

class DetailPage extends StatefulWidget {
  final PenjualanModel detail;
  DetailPage({required this.detail});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final apiService = ApiService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Penjualan"),
        elevation: 0,
        backgroundColor: Color(0xff6883bc),
      ),
      backgroundColor: Color(0xffc6d7eb),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xff6883bc),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text("Tanggal Penjualan : ${widget.detail.tanggal}",
                      style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 5,),
                  Divider(
                    color: Colors.white,
                    height: 10,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(height: 10,),
                  Text("Nama Pakaian : ${widget.detail.nama_pakaian}",
                    style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5,),
                  Text("Jenis Pakaian : ${widget.detail.jenis_pakaian}",
                    style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5,),
                  Text("Ukuran : ${widget.detail.ukuran}",
                    style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 5,),
                  Divider(
                    color: Colors.white,
                    height: 10,
                    thickness: 2,
                    indent: 10,
                    endIndent: 10,
                  ),
                  SizedBox(height: 10,),
                  Text("Jumlah Pakaian : ${widget.detail.jumlah_pakaian}",
                    style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10,),
                  Text("Harga Pakaian : ${widget.detail.harga_pakaian}",
                    style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10,),
                  Text("Total : ${widget.detail.total}",
                    style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  label: Text("Edit"),
                  icon : Icon(Icons.edit),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )
                  ),
                  onPressed: (){
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context)=> UpdatePage(data : widget.detail)));
                  },
                ),

                ElevatedButton.icon(
                  label: Text("Delete"),
                  icon : Icon(Icons.delete),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.4, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      )
                  ),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Confirmation'),
                            content: Text('Yakin ingin Menghapus Data Ini ?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () async {
                                  await apiService.deleteData(widget.detail.id);
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text('Delete Data berhasil')));

                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                          builder: (context) => HomePage()),
                                          (route) => false);
                                },
                                child: Text('Delete'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.redAccent,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                            ],
                          );
                        }
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
