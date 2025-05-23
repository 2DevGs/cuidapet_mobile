part of '../login_page.dart';

class _LoginRegisterButtons extends StatelessWidget {

  final controller = Modular.get<LoginController>();

  _LoginRegisterButtons();

  @override
  Widget build(BuildContext context) {
      return Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: [
          RoundedButtonWithIcon(
            onTap: (){}, 
            width: .42.sw, 
            color: const Color(0xFF4267B3), 
            icon: Cuidapeticons.facebook, 
            label: 'Facebook',
          ),
          RoundedButtonWithIcon(
            onTap: (){
              controller.socialLogin(SocialLoginType.google);
            }, 
            width: .42.sw, 
            color: const Color(0xFFE15031), 
            icon: Cuidapeticons.google, 
            label: 'Google',
          ),
          RoundedButtonWithIcon(
            onTap: (){
              Navigator.pushNamed(context, '/auth/register/');
            }, 
            width: .42.sw, 
            color: context.primaryColorDark, 
            icon: Icons.mail, 
            label: 'Cadastre-se',
          ),
        ],
      );
  }
}