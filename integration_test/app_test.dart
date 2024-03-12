import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/src/either.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mockito/mockito.dart';
import 'package:ninjaz_task/home_screen.dart';
import 'package:ninjaz_task/posts/data/data_source/remote/posts_remote_data_source.dart';
import 'package:ninjaz_task/posts/data/models/owner/owner.dart';
import 'package:ninjaz_task/posts/data/models/post/post.dart';
import 'package:ninjaz_task/posts/presentation/pages/posts_screen.dart';
import 'package:ninjaz_task/posts/presentation/widgets/reload_widget.dart';

class MockPostsRemoteDataSource extends Mock implements PostsRemoteDataSource {}

void main() {
  group('Posts Screen Cycle', () {
    testWidgets(
      'shows posts when API call succeeds',
      (WidgetTester tester) async {
        final mockPostsRemoteDataSource = MockPostsRemoteDataSource();
        final mockPosts = [
          Post(
            id: 'id',
            image: 'image',
            likes: 0,
            text: 'text',
            publishDate: DateTime.now(),
            tags: ['tag'],
            owner: const Owner(
              id: 'id',
              title: 'title',
              firstName: 'firstName',
              lastName: 'lastName',
              picture: 'picture',
            ),
          ),
        ];
        when(mockPostsRemoteDataSource.getPosts(page: 1)).thenAnswer(
          (_) => Future.value(Right(mockPosts)),
        );
        await tester.pumpWidget(const MaterialApp(
          home: HomeScreen(child: PostsScreen()),
        ));
        await tester.pump();
        expect(find.byType(PagedListView), findsOneWidget);
      },
    );

    testWidgets(
      'shows error message when API call fails',
      (WidgetTester tester) async {
        final mockPostsRemoteDataSource = MockPostsRemoteDataSource();
        when(mockPostsRemoteDataSource.getPosts(page: 1)).thenAnswer(
          (_) => Future.value(const Left('error')),
        );
        await tester.pumpWidget(const MaterialApp(
          home: HomeScreen(child: PostsScreen()),
        ));
        await tester.pump();
        expect(find.byType(ReloadWidget), findsOneWidget);
      },
    );
  });
}
