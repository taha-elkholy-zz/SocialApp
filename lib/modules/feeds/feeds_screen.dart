import 'package:flutter/material.dart';
import 'package:social_app/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Card(
            elevation: 5,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: const EdgeInsets.all(8),
            child: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                const Image(
                  image: NetworkImage(
                      'https://image.freepik.com/free-photo/portrait-positive-male-with-brunette-hair-bristle-has-piercing-wearing-black-sweater-holding-mobile-phone-copy-space-right-isolated-yellow-wall_295783-14551.jpg'),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Communicate with friends',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildPostItem(context),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
              itemCount: 10),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}

Widget buildPostItem(context) => Card(
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://image.freepik.com/free-photo/happy-successful-asian-young-business-man-glasses-blue-shirt-talking-cell-phone-working-with-laptop-table-white-wall_295783-13985.jpg'),
                  radius: 25,
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Taha Elkholy',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(height: 1.4),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.check_circle,
                              size: 15, color: Colors.blue),
                        ],
                      ),
                      Text(
                        'January 21, 2021 at 11:00 pm',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                      size: 16,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                color: Colors.grey.shade300,
                width: double.infinity,
                height: 1,
              ),
            ),
            Text(
              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: 6,
                  children: [
                    SizedBox(
                        height: 25,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          onPressed: () {},
                          child: Text(
                            '#Software',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        )),
                    SizedBox(
                        height: 25,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          onPressed: () {},
                          child: Text(
                            '#Software',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        )),
                    SizedBox(
                        height: 25,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          onPressed: () {},
                          child: Text(
                            '#Software',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        )),
                    SizedBox(
                        height: 25,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          minWidth: 1,
                          onPressed: () {},
                          child: Text(
                            '#Software_development_workshop',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: Colors.blue),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                  image: NetworkImage(
                    'https://image.freepik.com/free-photo/portrait-positive-male-with-brunette-hair-bristle-has-piercing-wearing-black-sweater-holding-mobile-phone-copy-space-right-isolated-yellow-wall_295783-14551.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    child: Row(
                      children: [
                        const Icon(IconBroken.Heart, color: Colors.red),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '123',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {},
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(IconBroken.Chat, color: Colors.amber),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '514 Comments',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                color: Colors.grey.shade300,
                width: double.infinity,
                height: 1,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://image.freepik.com/free-photo/happy-successful-asian-young-business-man-glasses-blue-shirt-talking-cell-phone-working-with-laptop-table-white-wall_295783-13985.jpg'),
                          radius: 18,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Write a comment...',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Icon(IconBroken.Heart, color: Colors.amber),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Like',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
