import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stoke_management/utills/color_constant.dart';
import 'package:stoke_management/utills/utils_routes.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController displayFirstNameController = TextEditingController();
  TextEditingController displayLastNameController = TextEditingController();
  TextEditingController displayMobileNumberController = TextEditingController();


  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    setState(() {
      isLoading = true;
    });
    displayFirstNameController.text = "vivek";
    displayLastNameController.text = "Sorathiya";
    displayMobileNumberController.text = "9925755626";

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: ColorConstant.themColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: ColorConstant.themColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              w_ImageProfile(),
              const SizedBox(height: 20,),
              w_buildDisplayTextField(),
              const SizedBox(height: 30,),
              w_SaveButton(),

            ],
          ),
        ),
      ),
    );
  }

  Widget w_ImageProfile(){
    return Center(
      child: Container(
        width: 70,
        height: 70,
        color: Colors.grey,
      ),
    );
  }


  Widget w_buildDisplayTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        TextField(
          controller: displayFirstNameController,
          decoration: const InputDecoration(
            labelText: "Firstname",
          ),
        ),

        const SizedBox(height: 20,),

        TextField(
          controller: displayLastNameController,
          decoration: const InputDecoration(
            labelText : "Lastname",
          ),
        ),

        const SizedBox(height: 20,),

        TextField(
          controller: displayMobileNumberController,
          decoration: const InputDecoration(
          //  label: Text("Mobile Number"),
          ),
        ),


      ],
    );
  }

  Widget w_TextField(){
    return Column(
      children:  const [




        TextField(

          decoration: InputDecoration(
            labelText: "Firstname",
            labelStyle: TextStyle(fontSize: 14),
              hintText: "UserFirstName"
          ),

          ),


        SizedBox(height: 20,),

        TextField(
          decoration: InputDecoration(
              labelText: "Lastname",
              labelStyle: TextStyle(fontSize: 14),
              hintText: "UserLastName"),

          ),

        SizedBox(height: 20,),

        TextField(
          decoration: InputDecoration(
              labelText: "Mobile Number",labelStyle: TextStyle(fontSize: 14), hintText: "Mobile Number"),

          ),
      ],
    );
  }

  Widget w_SaveButton() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, UtilRoutes.ProfileScreen);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        decoration: BoxDecoration(
          color: ColorConstant.primarycolor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Center(
          child: Text(
            "Edit Profile",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white
            ),),
        ),
      ),
    );
  }

}
