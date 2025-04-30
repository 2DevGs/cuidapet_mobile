part of '../../address_page.dart';

typedef AddressSelectedCallback = void Function(PlaceModel);

class _AddressSearchWidget extends StatefulWidget {

  final AddressSelectedCallback addressSelectedCallback;
  final PlaceModel? place;

  const _AddressSearchWidget({
    super.key,
    required this.addressSelectedCallback, 
    required this.place
  });

  @override
  State<_AddressSearchWidget> createState() => _AddressSearchWidgetState();
}

class _AddressSearchWidgetState extends State<_AddressSearchWidget> {

  final searchTextEC = TextEditingController();
  final searchTextFN = FocusNode();
  final controller = Modular.get<AddressSearchController>();

  @override
  void initState() {
    print('INITSTATEEEEEEEEEEEEEEEEE');
    super.initState();
    if(widget.place != null) {
      searchTextEC.text = widget.place?.address ?? '';
      searchTextFN.requestFocus();
    }
  }

  @override
  void dispose() {
    searchTextEC.dispose();
    searchTextFN.dispose();
    super.dispose();    
  }

  @override
  Widget build(BuildContext context) {

    final borderType = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(
        style: BorderStyle.none,
      ),
    );

      return Material(
        elevation: 10,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        child: TypeAheadField<PlaceModel>(
          builder: (context, searchTextEC, searchTextFN) {

            return TextField(
              controller: searchTextEC,
              focusNode: searchTextFN,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.location_on,
                  color: Colors.black,
                ),
                hintText: 'Insira um endereço',
                border: borderType,
                focusedBorder: borderType,
                disabledBorder: borderType,
                enabledBorder: borderType,
              ),
            );

          },
          decorationBuilder: (context, child) {

            return Material(
              color: Colors.white,
              type: MaterialType.card,
              elevation: 4,
              borderRadius: BorderRadius.circular(8),
              child: child,
            );

          },
          itemBuilder: (_, item) {

            return _ItemTile(
              address: item.address,
            );

          },
          onSelected:  _onSuggestionSelected,
          suggestionsCallback: _suggestionsCallback,
        ),
      );
  }

  Future<List<PlaceModel>> _suggestionsCallback(String pattern) async {

    if(pattern.isNotEmpty){
      return controller.searchAddress(pattern);
    }
      return <PlaceModel>[];
  }

  void _onSuggestionSelected(PlaceModel suggestion) {
    searchTextEC.text = suggestion.address;
    widget.addressSelectedCallback(suggestion);
  }
}

class _ItemTile extends StatelessWidget {

  final String address;

  const _ItemTile({required this.address});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: Text(address),
    );
  }
}