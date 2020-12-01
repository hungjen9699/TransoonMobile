import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertransoon/blocs/authentication/authentication_bloc.dart';
import 'package:fluttertransoon/blocs/getuser/getuser_bloc.dart';
import 'package:fluttertransoon/dtos/userDTO.dart';
import 'package:fluttertransoon/repositories/user_repository.dart';
import 'package:fluttertransoon/screens/account_tab/account_component/banner.dart';
import 'package:fluttertransoon/screens/account_tab/editprofile.dart';
import 'package:fluttertransoon/screens/payment/payment.dart';
import '../transoon_loader.dart';
import 'account_component/account_info.dart';
import 'account_component/balance.dart';
import 'account_component/opacity_line.dart';
import 'account_component/profile_tab.dart';
import 'favoritetransooner.dart';

// ignore: must_be_immutable
class AccountPage extends StatelessWidget {
  final UserRepository _userRepository;
  final String displayName;
  UserDTO dto;

  AccountPage(
      {Key key, @required UserRepository userRepository, this.displayName})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    GetUserBloc _getUser = GetUserBloc(null, _userRepository);
    _getUser.add(GetUser());
    return BlocProvider(
      create: (context) => _getUser,
      child: BlocBuilder<GetUserBloc, GetUserState>(
        builder: (context, state) {
          if (state is GetUserLoading) {
            return TransoonLoader();
          } else if (state is GetUserSuccess) {
            return Container(
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  AccountInfo(state.dto.fullName, state.dto.email),
                  AccountBalance(state.dto.balance.toString()),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPro(
                                    userRepository: _userRepository,
                                    displayName: displayName,
                                  )));
                    },
                    child: ProfileTab(
                      name: "Edit",
                      icon: Icons.border_color,
                    ),
                  ),
                  OpacityLine(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Payment(
                                    accountBalance: state.dto.balance,
                                  )));
                    },
                    child: ProfileTab(
                      name: "Payment",
                      icon: Icons.payment,
                    ),
                  ),
                  OpacityLine(),
                  ProfileTab(
                    name: "Setting",
                    icon: Icons.settings,
                  ),
                  OpacityLine(),
                  ProfileTab(
                    name: "Help",
                    icon: Icons.help,
                  ),
                  OpacityLine(),
                  ProfileTab(
                    name: "Emergency Contact",
                    icon: Icons.favorite,
                  ),
                  OpacityLine(),
                  ProfileTab(
                    name: "About Transoon",
                    icon: Icons.info,
                  ),
                  OpacityLine(),
                  GestureDetector(
                    onTap: () {
                      BlocProvider.of<AuthenticationBloc>(context).add(
                        LoggedOut(),
                      );
                    },
                    child: ProfileTab(
                      name: "Log Out",
                      icon: Icons.power_settings_new,
                    ),
                  ),
                  SaleBanner(),
                ],
              ),
            );
          } else
            return FavoriteTransooner();
        },
      ),
    );
  }
}
