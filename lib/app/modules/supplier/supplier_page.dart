import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_detail.dart';
import 'package:flutter/material.dart';

import 'widgets/supplier_service_widget.dart';

class SupplierPage extends StatefulWidget {

  const SupplierPage({ super.key });

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState extends State<SupplierPage> {

  late ScrollController _scrollController;
  bool sliverCollapsed = false; // SERÁ REMOVIDO NO PRÓXIMO COMMIT, APENAS PARA COMPEREENÇÂO DO BUG FIX
  final sliverCollapsedVN = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {

      if(_scrollController.offset > 180 && 
          !_scrollController.position.outOfRange)  {
            // sliverCollapsed = true; SERÁ REMOVIDO NO PRÓXIMO COMMIT, APENAS PARA COMPEREENÇÂO DO BUG FIX
            sliverCollapsedVN.value = true;
      } else if(_scrollController.offset <= 180 && 
          !_scrollController.position.outOfRange) {
            // sliverCollapsed = false; SERÁ REMOVIDO NO PRÓXIMO COMMIT, APENAS PARA COMPEREENÇÂO DO BUG FIX
            sliverCollapsedVN.value = false;
      }

    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!'); // SERÁ REMOVIDO NO PRÓXIMO COMMIT, APENAS PARA COMPEREENÇÂO DO BUG FIX
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
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              expandedHeight: 200,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
              pinned: true,
              title: ValueListenableBuilder<bool>(
                valueListenable: sliverCollapsedVN,
                builder: (_, sliverCollapsedValue, child) {
                  print('ValueListenableBuilder ${sliverCollapsedValue}'); // SERÁ REMOVIDO NO PRÓXIMO COMMIT, APENAS PARA COMPEREENÇÂO DO BUG FIX
                  return Visibility(
                    visible: sliverCollapsedValue,
                    child: Text(
                      'Clinica Central ABC',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
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