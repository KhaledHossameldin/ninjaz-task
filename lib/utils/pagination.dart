import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

mixin Pagination<T> {
  PagingController<int, T> controller =
      PagingController<int, T>(firstPageKey: 1);

  int page = 1;
  int limit = 20;

  void appendPage({required List<T> items}) {
    if (items.length < limit) {
      controller.appendLastPage(items);
      return;
    }
    controller.appendPage(items, page + 1);
    page++;
  }

  void reset(void Function(int) listener) {
    controller.dispose();
    controller = PagingController<int, T>(firstPageKey: 1)
      ..addPageRequestListener(listener);
    page = 1;
  }
}
