import 'package:flutter/material.dart';
import 'package:wilbert_uas/homepage.dart';
import 'package:wilbert_uas/api_service.dart';
import 'package:wilbert_uas/penjualan_model.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final apiService = ApiService();
  final tecTanggal = TextEditingController();
  final tecNama = TextEditingController();
  final tecJumlah = TextEditingController();
  final tecHarga = TextEditingController();
  final tecTotal = TextEditingController();
  final formKey = GlobalKey<FormState>();

  //Jenis Pakaian DropDown
  String? valueJenis;
  var listJenis = ["T-Shirt","Jacket","Kemeja","Celana"];

  //Ukuran Pakaian DropDown
  String? valueUkuran;
  var listUkuran = ['S','M','L','XL'];

  Future<void> _pilihTanggal() async {
    DateTime? pilih = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if(pilih !=null){
      setState(() {
        tecTanggal.text = pilih.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Tambah Data"),
        backgroundColor: Color(0xff6883bc),
        elevation: 0,
      ),
      backgroundColor: Color(0xffc6d7eb),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                TextFormField(
                  controller: tecTanggal,
                  readOnly: true,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Tanggal Masih Kosong'
                      : null,
                  decoration: InputDecoration(
                    labelText: 'Pilih Tanggal',
                    filled: true,
                    fillColor: Colors.white60,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 2, color: Colors.greenAccent),
                    ),
                    prefixIcon: Icon(Icons.calendar_month_sharp),
                  ),
                  onTap: (){
                    _pilihTanggal();
                  },
                ),

                SizedBox(height: 15,),

                TextFormField(
                  controller: tecNama,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Nama Pakaian Masih Kosong'
                      : null,
                  decoration: InputDecoration(
                    labelText: 'Input Nama Pakaian',
                    filled: true,
                    fillColor: Colors.white60,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 2, color: Colors.greenAccent),
                    ),
                    prefixIcon: Icon(Icons.abc),
                  ),
                ),

                SizedBox(height: 15,),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 45,top: 5, right: 10 ),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: DropdownButton(
                    value: valueJenis,
                    hint: Text('Pilih Jenis Pakaian'),
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded : true,
                    iconSize: 50,
                    underline: SizedBox(),
                    dropdownColor: Colors.white,
                    items: listJenis.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        valueJenis = newValue;
                      });
                    },
                  ),
                ),

                SizedBox(height: 15,),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 45,top: 5, right: 10 ),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(width: 1, color: Colors.grey),
                  ),
                  child: DropdownButton(
                    value: valueUkuran,
                    hint: Text('Pilih Ukuran Pakaian'),
                    icon: Icon(Icons.arrow_drop_down),
                    isExpanded : true,
                    iconSize: 50,
                    underline: SizedBox(),
                    dropdownColor: Colors.white,
                    items: listUkuran.map((item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        valueUkuran = newValue;
                      });
                    },
                  ),
                ),

                SizedBox(height: 7,),

                Divider(
                  color: Colors.black87,
                  height: 20,
                  thickness: 2,
                  indent: 20,
                  endIndent: 20,
                ),

                SizedBox(height: 7,),

                TextFormField(
                  controller: tecJumlah,
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Jumlah Pakaian Masih Kosong'
                      : null,
                  decoration: InputDecoration(
                    labelText: 'Input Jumlah Pakaian',
                    filled: true,
                    fillColor: Colors.white60,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 2, color: Colors.greenAccent),
                    ),
                    prefixIcon: Icon(Icons.add),
                  ),
                  onChanged: (String text) {
                    setState(() {
                      int total = int.parse(text) * int.parse(tecHarga.text);
                      tecTotal.text = total.toString();
                    });
                  },
                ),

                SizedBox(height: 20,),

                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: tecHarga,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Harga Masih Kosong'
                      : null,
                  decoration: InputDecoration(
                    labelText: 'Input Harga Pakaian',
                    filled: true,
                    fillColor: Colors.white60,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 2, color: Colors.greenAccent),
                    ),
                    prefixIcon: Icon(Icons.money),
                  ),
                  onChanged: (String text){
                    setState(() {
                      int total = int.parse(tecJumlah.text) * int.parse(text);
                      tecTotal.text = total.toString();
                    });
                  },
                ),

                SizedBox(height: 20,),

                TextFormField(
                  readOnly: true,
                  controller: tecTotal,
                  validator: (value) => value == null || value.isEmpty
                      ? 'Total Harga Masih Kosong'
                      : null,
                  decoration: InputDecoration(
                    labelText: 'Total Harga',
                    filled: true,
                    fillColor: Colors.white60,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(width: 2, color: Colors.greenAccent),
                    ),
                    prefixIcon: Icon(Icons.monetization_on),
                  ),
                ),

                SizedBox(height: 20,),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  onPressed: () async {
                    if(formKey.currentState!.validate()){
                      int jumlah = int.parse(tecJumlah.text);
                      int harga = int.parse(tecHarga.text);
                      int total_ = int.parse(tecTotal.text);

                      await apiService.createData(tecTanggal.text.toString(),
                          tecNama.text.toString(),valueJenis.toString(),valueUkuran.toString(),
                          jumlah,harga,total_);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Data berhasil disimpan')));

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()),
                              (route) => false);
                    }
                  },
                  child: Text("Save Data"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
