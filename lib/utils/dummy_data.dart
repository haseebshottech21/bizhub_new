import 'package:bizhub_new/model/post_model.dart';
import 'package:flutter/cupertino.dart';

import '../model/chat_model.dart';
import '../model/message_model.dart';
import '../model/on_board_model.dart';
import '../model/type.dart';

List<OnBoardModel> onboardData = [
  OnBoardModel(
    text: 'Welcome to BizHub',
    description:
        'Search for services, you need done and find services you can do for others.',
    subDes: 'Get Bizzy With it',
    image: 'assets/images/welcome.jpg',
  ),
  OnBoardModel(
    text: 'Start Searching Services',
    description:
        'Sign up to provide services you know how to render. Make some extra cash. Find leads from people near you that need your services.',
    subDes: '',
    image: 'assets/images/intro_1_bg.png',
  ),
  OnBoardModel(
    text: 'Connect with Providers',
    description:
        'Providers will be notified when new services are available in their area, allowing you to have multiple offers as soon as possible.\n\n“Find the help you are looking for"',
    subDes: '',
    image: 'assets/images/intro_2_bg.png',
  ),
];

final List<String> sliderImages = [
  'https://cdn.mos.cms.futurecdn.net/6J8riT32EkrhW9NYfE5oyK.jpg',
  'https://www.thecreativemomentum.com/hubfs/blog-files/2007%20batch/2007-10-Sites%20for%20Web%20Design%20Inspiration-h-1.jpg',
];

List<Chat> getChat() {
  return [
    Chat(
      id: 1,
      username: 'Oliva',
      postTitle: 'I will create your bussiness website',
      message: 'Hey, How are you ?',
      unReadCount: 2,
      lastMessageAt: '2:40 AM',
    ),
    Chat(
      id: 2,
      username: 'Elex',
      postTitle: 'I will create your bussiness website',
      message: 'I am fine.',
      unReadCount: 3,
      lastMessageAt: '2:40 AM',
    ),
    Chat(
      id: 3,
      username: 'Elex',
      postTitle: 'I will create your bussiness website',
      message: 'I am fine.',
      unReadCount: 0,
      lastMessageAt: '2:40 AM',
    ),
    Chat(
      id: 4,
      username: 'Elex',
      postTitle: 'I will create your bussiness website',
      message: 'I am fine.',
      unReadCount: 0,
      lastMessageAt: '2:40 AM',
    ),
    Chat(
      id: 5,
      username: 'Elex',
      postTitle: 'I will create your bussiness website',
      message: 'I am fine.',
      unReadCount: 0,
      lastMessageAt: '2:40 AM',
    ),
    Chat(
      id: 6,
      username: 'Elex',
      postTitle: 'I will create your bussiness website',
      message: 'I am fine.',
      unReadCount: 0,
      lastMessageAt: '2:40 AM',
    ),
    Chat(
      id: 7,
      username: 'Elex',
      postTitle: 'I will create your bussiness website',
      message: 'I am fine.',
      unReadCount: 0,
      lastMessageAt: '2:40 AM',
    ),
    Chat(
      id: 8,
      username: 'Elex',
      postTitle: 'I will create your bussiness website',
      message: 'I am fine.',
      unReadCount: 0,
      lastMessageAt: '2:40 AM',
    ),
  ];
}

List<Message> getMessage() {
  return [
    Message(
      text: 'Hello',
      isMe: false,
      createdAt: '2:30 PM',
    ),
    Message(
      text: 'Hey, How are you?',
      isMe: true,
      createdAt: '2:31 PM',
    ),
    Message(
      text: 'I am fine',
      isMe: false,
      createdAt: '2:32 PM',
    ),
    Message(
      text: 'And you?',
      isMe: false,
      createdAt: '2:33 PM',
    ),
    Message(
      text: 'I am fine too',
      isMe: true,
      createdAt: '2:34 PM',
    ),
    Message(
      text: 'Did you finished the task?',
      isMe: true,
      createdAt: '2:35 PM',
    ),
    Message(
      text: 'ahh, I finished it',
      isMe: false,
      createdAt: '2:36 PM',
    ),
    Message(
      text: 'no, I am still working on it',
      isMe: false,
      createdAt: '2:37 PM',
    ),
    Message(
      text: 'maybe you can help me 🥹',
      isMe: false,
      createdAt: '2:38 PM',
    ),
  ];
}

List<Post> getPosts() {
  return [
    Post(
      id: 1,
      postImage: 'assets/images/job2.jpg',
      postTitle: 'I will create your bussiness webiste with new features',
      postPrice: '50',
      postStatus: 'Active',
    ),
    Post(
      id: 2,
      postImage: 'assets/images/job2.jpg',
      postTitle: 'I will create your bussiness webiste with new features',
      postPrice: '50',
      postStatus: 'Active',
    ),
    Post(
      id: 3,
      postImage: 'assets/images/job2.jpg',
      postTitle: 'I will create your bussiness webiste with new features',
      postPrice: '50',
      postStatus: 'Active',
    ),
    Post(
      id: 4,
      postImage: 'assets/images/job2.jpg',
      postTitle: 'I will create your bussiness webiste with new features',
      postPrice: '50',
      postStatus: 'Active',
    ),
  ];
}

List<TypeModel> getType() {
  return [
    TypeModel(
      typeTitle: 'Jobs Near By',
      typeIcon: CupertinoIcons.money_dollar_circle_fill,
      typeSelect: true,
    ),
    TypeModel(
      typeTitle: 'Service Near By',
      typeIcon: CupertinoIcons.briefcase_fill,
      typeSelect: false,
    ),
  ];
}
