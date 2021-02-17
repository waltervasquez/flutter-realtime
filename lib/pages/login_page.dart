import 'package:band_name/widgets/boton_azul.dart';
import 'package:band_name/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height  * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Logo(),
                _Form(),
                _Labels(),
                Text('Terminos y Condiciones de uso', style: TextStyle(fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class _Logo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        width: 170,
        child:  Column(
          children: [
            Image(image:  AssetImage('assets/tag-logo.png'),),
            SizedBox(height: 20,),
            Text('Mensagger',  style: TextStyle(fontSize: 30), )
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textEditingController: emailCtrl,
            isPassword: false,
          ),
          CustomInput(
            icon: Icons.looks_3_outlined,
            placeholder: 'Password',
            keyboardType: TextInputType.text,
            textEditingController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
            Texto: 'Ingresar',
            colors: Colors.blue,
            onPress: () {
              print(emailCtrl.text);
            },
          ),
        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('No tienes cuenta?', style: TextStyle(color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w700),),
          SizedBox(height: 10,),
          GestureDetector(
            child: Text('Crea una ahora', style: TextStyle(color: Colors.blue[600], fontSize: 18, fontWeight: FontWeight.bold), ),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'register');
            },
          ),
        ],
      ),
    );
  }
}





