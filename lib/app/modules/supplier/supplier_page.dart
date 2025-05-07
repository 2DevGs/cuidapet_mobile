import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_detail.dart';
import 'package:flutter/material.dart';

import 'widgets/supplier_service_widget.dart';

class SupplierPage extends StatelessWidget {

  const SupplierPage({ super.key });

   @override
   Widget build(BuildContext context) {
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: context.primaryColor,
          label: Text(
            'Fazer agendamento',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          icon: Icon(
            Icons.schedule,
            color: Colors.white,
          ),
          onPressed: (){
            
          },
        ),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.fadeTitle,
                ],
                background: Image.network(
                  'https://th.bing.com/th/id/OIP.Vop-SSWwL7DYODRCid46eAHaE8?w=276&h=185&c=7&r=0&o=5&pid=1.7',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stacktrace) => SizedBox.shrink(),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SupplierDetail(),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Serviços (0 Selecionados)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 200,
                (context, index) {
                  return SupplierServiceWidget();
                }
              ),
            ),
          ],
        ),
       );
  }
}