// class DialogoProgreso {
//   String? mensaje;
//   //static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

//   DialogoProgreso(BuildContext context, String mensaje,
//       {bool isDismissible = true}) {
//     this.mensaje = mensaje;
//     this.pr = new ProgressDialog(context, isDismissible: isDismissible);

//     this.pr.style(
//         message: mensaje,
//         borderRadius: 5.0,
//         backgroundColor: Colors.white,
//         progressWidget: Container(
//             padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
//         elevation: 10.0,
//         insetAnimCurve: Curves.easeInOut,
//         progress: 0.0,
//         maxProgress: 10.0,
//         progressTextStyle: TextStyle(
//             color: Colors.black, fontSize: 12.0, fontWeight: FontWeight.w400),
//         messageTextStyle: TextStyle(
//             color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600));
//   }

//   mostrarDialogo() async {
//     await this.pr.show();
//   }

//   ocultarDialogo() async {
//     await this.pr.hide();
//   }

//   estadoDialogo() {
//     this.pr.isShowing();
//   }
// }