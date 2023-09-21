import 'dart:developer';

import 'package:application8/models/user_model.dart';
import 'package:application8/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../models/event_model.dart';
import '../services/event_service.dart';

class EventCard extends StatefulWidget {
  final Event event;
  const EventCard({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  DateTime get dateTime =>
      DateTime.fromMillisecondsSinceEpoch(widget.event.time);
  String get formattedDate => formatTimestampDate(widget.event.time);
  String get formattedTime => formatTimestampTime(widget.event.time);

  String formatTimestampDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDate = DateFormat('d MMMM yyyy').format(dateTime);
    return ' $formattedDate';
  }

  String formatTimestampTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            ListTile(
              trailing: GestureDetector(
                  onTap: () {}, child: const Icon(Icons.star_border)),
              leading: Image.asset(
                'lib/assets/background.png',
                width: 40,
                height: 40,
              ),
              title: Text(
                widget.event.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              subtitle: Row(
                children: [
                  FutureBuilder<User>(
                      future: UserService.getUserById(widget.event.userId),
                      builder: (context, snapshot) {
                        log(snapshot.toString());
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                          );
                        }
                        return const Text("Loading");
                      }),
                  Text(
                    ' | $formattedTime',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Image.asset(
                'lib/assets/media.png',
                height: 152,
                width: 356,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.event.title,
                      style: Theme.of(context).textTheme.headlineMedium),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "📅 Date : $formattedDate",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                      Text(
                        "⏰ Time : $formattedTime",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                      Text(
                        "📍 Venue : ${widget.event.venue}",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    widget.event.desc,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Free Registration '),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Register'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
