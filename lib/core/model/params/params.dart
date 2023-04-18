class Params {
  const Params({this.searchTerm});
  final String? searchTerm;
}

class NoParams extends Params {}

class SearchParams extends Params {
  const SearchParams({required String searchTerm})
      : super(searchTerm: searchTerm);
}
