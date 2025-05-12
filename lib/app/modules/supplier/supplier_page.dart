import 'package:cuidapet_mobile/app/core/life_cycle/page_life_cycle_state.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:cuidapet_mobile/app/modules/supplier/supplier_controller.dart';
import 'package:cuidapet_mobile/app/modules/supplier/widgets/supplier_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'widgets/supplier_service_widget.dart';

class SupplierPage extends StatefulWidget {
  final int _supplierId;

  const SupplierPage({super.key, required int supplierId})
      : _supplierId = supplierId;

  @override
  State<SupplierPage> createState() => _SupplierPageState();
}

class _SupplierPageState
    extends PageLifeCycleState<SupplierController, SupplierPage> {
  late ScrollController _scrollController;
  // bool sliverCollapsed = false;
  final sliverCollapsedVN = ValueNotifier(false);

  @override
  Map<String, dynamic>? get params => {'supplierId': widget._supplierId};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 180 &&
          !_scrollController.position.outOfRange) {
        sliverCollapsedVN.value = true;
      } else if (_scrollController.offset <= 180 &&
          !_scrollController.position.outOfRange) {
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
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Observer(
        builder: (_) {
          return AnimatedOpacity(
            duration: Duration(milliseconds: 300),
            opacity: controller.totalServicesSelected > 0 ? 1 : 0,
            child: Visibility(
              visible: controller.totalServicesSelected > 0,
              child: FloatingActionButton.extended(
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
                onPressed: controller.goToSchedule,
              ),
            ),
          );
        },
      ),
      body: Observer(
        builder: (_) {
          final supplier = controller.supplierModel;

          if (supplier == null) {
            return const Text('Buscando dados do fornecedor');
          }

          return CustomScrollView(
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
                    return Visibility(
                      visible: sliverCollapsedValue,
                      child: Text(
                        supplier.name,
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
                    supplier.logo,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stacktrace) =>
                        SizedBox.shrink(),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SupplierDetail(
                  controller: controller,
                  supplier: supplier,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Serviços (${controller.totalServicesSelected} selecionado${controller.totalServicesSelected > 1 ? 's' : ''})',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: controller.supplierServices.length,
                    (context, index) {
                  final service = controller.supplierServices[index];
                  return SupplierServiceWidget(
                    service: service,
                    supplierController: controller,
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
